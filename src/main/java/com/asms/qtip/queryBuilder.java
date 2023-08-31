package com.asms.qtip;

import org.apache.tomcat.util.json.ParseException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

public class queryBuilder {

    public String getUsageQuery(InfoDO info) throws ParseException {

        String query = "\"GetUCDDAMPAWSv2(XXXXXXXX,";
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
        if(!mcs.get(0).equals("All")){
            query += "<br> | where MeterCategory in! (";

            for(int i=0;i<mcs.size();i++){

                if(i== list.size()-1){
                    query += "\"" +list.get(i) + "\")";
                }else{
                    query += "\"" +list.get(i) + "\",";
                }
            }
        }




        List<Map<String, String>> ops = info.getOperations();
        System.out.println(ops.get(0).get("field"));


        query += "<br> | summarize Quantity = sum(Quantity), sum(Cost) by Date,SubscriptionGuid,MeterCategory,MeterName,ResourceId,AdditionalInfo,ChargeTypeInternal\"";


        System.out.println(query);

        return query;
    }
}
