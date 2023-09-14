package com.asms.qtip;

import org.apache.tomcat.util.json.ParseException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

public class queryBuilder {

    public String getUsageQuery(InfoDO info) throws ParseException {

        String query = "GetUCDDAMPAWSv2("+ info.getEnrollNum()+",";
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
        List<Map<String, Object>> ops = info.getOperations();

        if(ops.size()>=1 && !"".equals(ops.get(0).get("val"))){
            query += "<br> | where ";

            for(int i=0;i<ops.size();i++){

                String[] splitVals = ops.get(i).get("val").toString().split(",");
                String setVals = "";
                for(int j=0;j<splitVals.length;j++){
                    if(j == splitVals.length-1){
                        setVals += "\"" + splitVals[j]+"\"";
                    }else{
                        setVals += "\"" + splitVals[j]+"\",";
                    }
                }

                if(i==0){
                    query+= ops.get(i).get("field") + " " + ops.get(i).get("ops")  + "(" +  setVals + ")";
                }
                else{
                    query+= "<br> | " + ops.get(i).get("clause") + " " + ops.get(i).get("field") + " " + ops.get(i).get("ops") + "(" +  setVals + ")";
                }

            }
            query += "<br> | summarize Quantity = sum(Quantity), sum(Cost) by ";
        }
        else{
            query += "<br> | summarize Quantity = sum(Quantity), sum(Cost) by ";
        }

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
}
