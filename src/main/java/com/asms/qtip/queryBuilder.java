package com.asms.qtip;

import org.apache.tomcat.util.json.ParseException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class queryBuilder {

    public String getUsageQuery(InfoDO info) throws ParseException {

        List<Map<String, Object>> ops = info.getOperations();
        String query = "";
        Map<String, String> variable = new HashMap<>();
        Map<String, String> setVar = new HashMap<>();

        //attachment exists
        if(ops.get(ops.size()-1).size()>0){

            variable = declareList(ops.get(ops.size()-1)).get(0);
            setVar = declareList(ops.get(ops.size()-1)).get(1);

            for(String key : variable.keySet()){
                query += variable.get(key);
                query += "<br>";
            }

        }

        //dateRange(info.getStartDate(), info.getEndDate());

        query += "GetUCDDAMPAWSv2("+ info.getEnrollNum()+",";
        query += "datetime("+ info.getStartDate() +"),datetime(" + info.getEndDate() + "))";

        //CostType
        if(info.getCostType().equals("Actual")){
            query+= "<br> | where IsActualCost =="  + "True";
        }
        else{
            query+= "<br> | where IsAmortizedCost ==" + "True";
        }
        query += "<br> | join hint.strategy = broadcast kind = leftouter (vwMeterAll) on MeterId";

        //Subs
        List<String> list = info.getSubIds();
        if(!list.get(0).equals("All")){
            query += "<br> | where SubscriptionGuid in~ (";

            for(int i=0;i<list.size();i++){

                if(i == list.size()-1){
                    query += "\"" +list.get(i) + "\")";
                }
                else{
                    query += "\"" +list.get(i) + "\",";
                }
            }
        }

        //MeterCategory
        List<String> mcs = info.getMeterCategory();
        if(mcs.size() >0){
            if(!mcs.get(0).equals("All")){
                query += "<br> | where MeterCategory in~ (";

                for(int i=0;i<mcs.size();i++){

                    if(i== mcs.size()-1){
                        query += "\"" +mcs.get(i).trim() + "\")";
                    }else{
                        query += "\"" +mcs.get(i).trim() + "\",";
                    }
                }
            }
        }

        //Add Options

        if(ops.size()-1>=1){
            Boolean isStart = true;

            for(int i=0;i<ops.size()-1;i++){

                if(!"".equals(ops.get(i).get("val"))){
                    String fieldName = (String) ops.get(i).get("field");
                    if(setVar.containsKey(fieldName)){
                        //first line
                        if(i==0 || isStart){
                            query += "<br> | where ";
                            query+= fieldName + " " + ops.get(i).get("ops")  + "(" + setVar.get(fieldName)  + ")";
                            isStart = false;
                        }
                        else{
                            query+= "<br>" + ops.get(i).get("clause") + " " + fieldName + " " + ops.get(i).get("ops") + "(" +  setVar.get(fieldName) + ")";
                        }
                    }
                    else{
                        String[] splitVals = ops.get(i).get("val").toString().split(",");
                        String setVals = "";
                        for(int j=0;j<splitVals.length;j++){
                            if(j == splitVals.length-1){
                                setVals += "\"" + splitVals[j]+"\"";
                            }else{
                                setVals += "\"" + splitVals[j]+"\",";
                            }
                        }
                        //first line
                        if(i==0 || isStart){
                            query += "<br> | where ";
                            query+= ops.get(i).get("field") + " " + ops.get(i).get("ops")  + "(" +  setVals + ")";
                            isStart = false;
                        }
                        else{
                            query+= "<br>" + ops.get(i).get("clause") + " " + ops.get(i).get("field") + " " + ops.get(i).get("ops") + "(" +  setVals + ")";
                        }
                    }
                }
            }
        }
        query += "<br> | summarize Quantity = sum(Quantity), sum(Cost) by ";

        List<String> cols = info.getColumns();
        for(int i=0;i<cols.size();i++){
            if(i==cols.size()-1){
                query+= " " + cols.get(i);
            }else{
                query+= " " + cols.get(i) + ",";
            }
        }

        return query;
    }

    public static List<Map<String, String>> declareList(Map<String, Object> map){

        List<Map<String, String>> listSet = new ArrayList<>();
        Map<String, String> variable = new HashMap<>();
        Map<String, String> listName = new HashMap<>();
        int num = 1;


        for(String key : map.keySet()){
            String query="";
            List<String> list = (List<String>) map.get(key);
            query += "//"+key+"<br>";
            query+= "let list"+ num + " = datatable(List:string) <br>";
            query+= "[";

            for(int i=0;i<list.size();i++){

                if(i == list.size()-1){
                    query+= "\'" + list.get(i) + "\'";
                    query+= "];";
                }
                else{
                    query+= "\'" + list.get(i) + "\',";
                }
            }
            query += "<br>";
            variable.put("list"+num, query);
            listName.put(key, "list"+num);
            num++;
        }
        listSet.add(variable);
        listSet.add(listName);

        return listSet;
    }

//    public static Map<String, String> dateRange(String start, String end){
//        Map<String, String> dates = new HashMap<>();
//
//
//
//        return dates;
//    }
}
