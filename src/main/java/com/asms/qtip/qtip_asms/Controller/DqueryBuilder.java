package com.asms.qtip.qtip_asms.Controller;

import com.asms.qtip.qtip_asms.Model.DInfo;
import com.asms.qtip.qtip_asms.Service.Utils;
import org.apache.tomcat.util.json.ParseException;

import java.util.ArrayList;
import java.util.List;

public class DqueryBuilder {

    public List<String> getUsageQuery(DInfo info) throws ParseException {

        List<String> listQuery = new ArrayList<>();
        String mappingQuery = "";
        String costQuery = "";

        Utils utils = new Utils();
        List<String> dates = utils.DateRange(info.getStartDate(), info.getEndDate());

        //part1
        mappingQuery = part1(dates,info, true);

        //part2
        costQuery = part2(dates,info, false);


        listQuery.add(mappingQuery);
        listQuery.add(costQuery);

        return listQuery;

    }

    public static String part1(List<String> dates, DInfo info, Boolean ispart1){

        String mappingQuery = "";
        String declareQuery = "";
        int datesNum = dates.size();

        declareQuery += declareList(info.getIds());
        mappingQuery += declareQuery;
        // If it is cross month
        if (dates.size() > 0) {

            String hostQuery = "";

            for (int i = 0; i < dates.size(); i++) {
                String startDate = dates.get(i).split(",")[0];
                String endDate = dates.get(i).split(",")[1];
                hostQuery += mappingQuery(startDate, endDate, info, i+1, "Y", ispart1);
                hostQuery += "<br>";
            }

            mappingQuery += hostQuery;
            mappingQuery += endMappingQuery(datesNum, ispart1);

        }

        // If it not a cross month
        else {
            String tempQuery = "";
            tempQuery += mappingQuery(info.getStartDate(), info.getEndDate(), info, 1, "N", ispart1);
            mappingQuery += tempQuery;
            if(ispart1){
                mappingQuery += "<br>| distinct HostURI, ResourceId";
            }
        }

        return mappingQuery;
    }

    public static String part2(List<String> dates, DInfo info, Boolean ispart1){
        String costQuery = "";
        String totalQuery = "";
        String mappingQuery = "";

        mappingQuery = part1(dates,info,false);

        // If it is cross month
        if (dates.size() > 0) {

            List<String> tables = new ArrayList<>();
            for (int i = 0; i < dates.size(); i++) {
                tables.add("table" + (i + 1));
            }

            String tableQuery = "";

            for (int i = 0; i < dates.size(); i++) {
                tableQuery += "<br> let " + tables.get(i) + " = ";
                String startDate = dates.get(i).split(",")[0];
                String endDate = dates.get(i).split(",")[1];
                tableQuery += makeQuery(costQuery, startDate, endDate, info.getEnrollNum(), dates.size()+1, "Y");
                tableQuery += "<br>";
            }

            costQuery += tableQuery;
            costQuery += "<br> union withsource= UnionTable ";

            for (int i = 0; i < dates.size(); i++) {
                if (i == dates.size()-1) {
                    costQuery += tables.get(i);
                } else {
                    costQuery += tables.get(i) + ", ";
                }
            }
            costQuery += "<br> | summarize Quantity = sum(Quantity), sum(Cost) by Date,MeterCategory,MeterSubCategory,MeterName,ResourceId,AdditionalInfo";

        }

        // If it not a cross month
        else {
            String tempQuery = "";
            costQuery += makeQuery(tempQuery, info.getStartDate(), info.getEndDate(), info.getEnrollNum(), 1, "N");
            costQuery += tempQuery;
        }

        totalQuery += mappingQuery;
        totalQuery += "<br>";
        totalQuery += costQuery;

        return totalQuery;
    }

    public static String declareList(List<String> list) {

        String query = "";

        query += "//ResourceId <br>";
        query += "let list = datatable(List:string) <br>";
        query += "[";

        for (int i = 0; i < list.size(); i++) {

            if (i == list.size() - 1) {
                query += "\'" + list.get(i) + "\'";
                query += "];";
            } else {
                query += "\'" + list.get(i) + "\',";
            }
        }
            query += "<br>";

        return query;
    }

    public static String mappingQuery(String startDate, String endDate, DInfo info, int num, String isCross, Boolean ispart1) {
        String query = "";

        if(isCross.equals("Y") || !ispart1){
            query += "<br>let HostURITable" + num + " = (";
        }
        query += "<br>GetUCDDAMPAWSv2(" + info.getEnrollNum() + ",";
        query += "datetime(" + startDate + "),datetime(" + endDate + "))";
        query += "<br>| where IsActualCost == True";
        query += "<br>| join hint.strategy = broadcast kind = leftouter(vwMeterAll) on MeterId";
        query += "<br> | where MeterCategory == \"Virtual Machines\"";
        query += "<br>| where ResourceId in~(list)";
        query += "<br>| project HostURI=(extract_json(\"$.HostResourceUri\", AdditionalInfo, typeof(string))), ResourceId";

        if(isCross.equals("Y") || !ispart1){
            query+=");";
        }

        return query;

    }

    public static String endMappingQuery(int datesNum, Boolean ispart1){
        String endQuery="";
        int nextIdx = datesNum+1;
        endQuery+= "<br> let HostURITable"+nextIdx+"=(union withsource = UnionTable ";
        for (int i =1;i<nextIdx;i++){
            if(i == datesNum){
                endQuery+=" HostURITable"+i;
            }else{
                endQuery+=" HostURITable"+i+",";
            }
        }
        endQuery += "<br>| distinct HostURI, ResourceId);";

        if(ispart1){
            endQuery += "<br><br>HostURITable"+nextIdx;
        }

        return endQuery;
    }
    public static String makeQuery(String query, String startDate, String endDate, String enrollNum, int num, String isCross) {

        if ("Y".equals(isCross)) {
            query += "(";
        }
        query += "<br>GetUCDDAMPAWSv2(" + enrollNum + ",";
        query += "datetime(" + startDate + "),datetime(" + endDate + "))";

        query += "<br> | where IsActualCost ==" + "True";
        query += "<br> | join hint.strategy = broadcast kind = leftouter (vwMeterAll) on MeterId";
        query += "<br> | where ResourceId in~(HostURITable"+num+")";
        query += "<br> | summarize Quantity=sum(Quantity), Cost=sum(Cost) by Date,MeterCategory,MeterSubCategory,MeterName,ResourceId,AdditionalInfo";

        if ("Y".equals(isCross)) {
            query += ");";
        }

        return query;
    }

}
