package com.asms.qtip;

import org.apache.tomcat.util.json.ParseException;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Period;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
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

        String declareQuery = "";

        //attachment exists
        if(ops.get(ops.size()-1).size()>0){

            variable = declareList(ops.get(ops.size()-1)).get(0);
            setVar = declareList(ops.get(ops.size()-1)).get(1);

            for(String key : variable.keySet()){
                declareQuery += variable.get(key);
                declareQuery += "<br>";
            }

        }

        List<String> dates = dateRange(info.getStartDate(), info.getEndDate());

        if(dates.size()>0){

            List<String> tables = new ArrayList<>();
            for(int i =0;i<dates.size();i++){
                tables.add("table"+ (i+1));
            }
            String tableQuery = "";
            for(int i=0;i<dates.size();i++){

                tableQuery += "<br> let "+tables.get(i)+" = ";
                String startDate = dates.get(i).split(",")[0];
                String endDate = dates.get(i).split(",")[1];
                tableQuery += makeQuery(query, startDate, endDate, info, ops, setVar, "Y");
                tableQuery += "<br>";
            }
            query += declareQuery;
            query += tableQuery;
            query += "<br> union withsource= UnionTable ";

            for(int i=0;i<tables.size();i++){
                if(i == tables.size()-1){
                    query += tables.get(i);
                }else{
                    query+= tables.get(i) + ", ";
                }
            }

            query += "<br> | summarize Quantity = sum(Quantity), sum(Cost) by ";

            List<String> setCols = info.getColumns();
            for(int i=0;i<setCols.size();i++){
                if(i==setCols.size()-1){
                    query+= " " + setCols.get(i);
                }else{
                    query+= " " + setCols.get(i) + ",";
                }
            }
        }

        else{
            String tempQuery = "";
            query += declareQuery;
            tempQuery += makeQuery(tempQuery, info.getStartDate(), info.getEndDate(), info, ops, setVar,"N");
            query += tempQuery;

        }

        return query;
    }

    public static String makeQuery (String query, String startDate, String endDate, InfoDO info, List<Map<String, Object>> ops, Map<String, String> setVar, String isCross){

        if("Y".equals(isCross)){
            query+= "(";
        }
        query += "GetUCDDAMPAWSv2("+ info.getEnrollNum()+",";
        query += "datetime("+ startDate +"),datetime(" + endDate + "))";

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
        query += "<br> | summarize Quantity = sum(Quantity), Cost = sum(Cost) by ";

        List<String> cols = info.getColumns();
        for(int i=0;i<cols.size();i++){
            if(i==cols.size()-1){
                query+= " " + cols.get(i);
            }else{
                query+= " " + cols.get(i) + ",";
            }
        }
        if("Y".equals(isCross)){
            query+=");";
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

    public static List<String> dateRange(String start, String end){
        //Map<String, String> dates = new HashMap<>();
        List<String> dates = new ArrayList<>();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate startDate = LocalDate.parse(start,formatter);
        LocalDate endDate = LocalDate.parse(end,formatter);

        Period period = Period.between(startDate, endDate);
        int months = period.getMonths();

        YearMonth moStart = YearMonth.from(startDate);
        YearMonth moEnd = YearMonth.from(endDate);

        //if year/months is not same
        if(!moStart.equals(moEnd)){

            //시작
            dates.add(startDate + "," + moStart.atEndOfMonth());
            System.out.println(startDate + ", " + moStart.atEndOfMonth());

            if(months > 0){
                for(int i=1;i<months;i++){
                    LocalDate nextMonth = startDate.plusMonths(i);
                    String tMonth= nextMonth.getMonthValue()+"";

                    if(nextMonth.getMonthValue()<10){
                        tMonth = "0"+ tMonth;
                    }
                    String temp = nextMonth.getYear() + "-" + tMonth + "-01";
                    LocalDate tempDate = LocalDate.parse(temp, formatter);
                    YearMonth tempMonth = YearMonth.from(tempDate);
                    dates.add(tempMonth.atDay(1)  + "," + tempMonth.atEndOfMonth());
                    System.out.println( tempMonth.atDay(1)  + ", " + tempMonth.atEndOfMonth());
                    }
            }
            //마지막
            dates.add(moEnd.atDay(1) + "," + endDate);
            System.out.println(moEnd.atDay(1) + ", " + endDate);
            System.out.println(months);
        }

        return dates;
    }
}
