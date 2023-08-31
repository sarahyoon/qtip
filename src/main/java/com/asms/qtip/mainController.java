package com.asms.qtip;

import org.apache.tomcat.util.json.JSONParser;
import org.apache.tomcat.util.json.ParseException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class mainController {

    @GetMapping("/")
    public String main(){
        return "getusage";
    }

    @GetMapping("/slacalc")
    public String slaCalc(){
        return "slacalc";
    }

    @ResponseBody
    @RequestMapping(value="/getusage", method={RequestMethod.POST, RequestMethod.GET})
    public Map<String, String> getQuery(@RequestParam Map<String, Object> map) throws ParseException {
            queryBuilder qb = new queryBuilder();
            InfoDO infos = new InfoDO();

            Object sb = map.get("subIds");
            JSONParser parser = new JSONParser(sb.toString());
            Object subs = parser.parse();

            Object cs = map.get("columns");
            JSONParser parser1 = new JSONParser(cs.toString());
            Object cols = parser1.parse();

            Object mc = map.get("meterCategory");
            JSONParser parser2 = new JSONParser(mc.toString());
            Object meters = parser2.parse();

            Object ops = map.get("operations");
            JSONParser parser3 = new JSONParser(ops.toString());
            Object oper = parser3.parse();

//            JSONParser parser4 = new JSONParser(oper.toString());
//            Object clause = parser4.parse();

            infos.setStartDate((String) map.get("startDate"));
            infos.setEndDate((String) map.get("endDate"));
            infos.setCostType((String) map.get("costType"));
            infos.setSubIds((List<String>) subs);
            infos.setColumns((List<String>) cols);
            infos.setMeterCategory((List<String>) meters);
            infos.setOperations((List<Map<String, String>>) oper);

            String query = qb.getUsageQuery(infos);
            System.out.println(query);
            Map<String, String> result = new HashMap<>();
            result.put("query", query);
            return result;
    }
}
