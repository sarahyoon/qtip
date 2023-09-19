package com.asms.qtip;

import jakarta.servlet.http.HttpServletRequest;
import org.apache.tomcat.util.json.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
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
    public Map<String, String> getQuery( @RequestPart(value="files", required=false) List<MultipartFile> file,
                                         @RequestPart(value="infos", required=true) Map<String, Object> map, HttpServletRequest request) throws ParseException, IOException {

            queryBuilder qb = new queryBuilder();
            InfoDO infos = new InfoDO();

            if(map.get("enrollNum") == null){
                infos.setEnrollNum("Input Enrollment # HERE");
            }
            else {
                infos.setEnrollNum((String) map.get("enrollNum"));
            }

            infos.setStartDate((String) map.get("startDate"));
            infos.setEndDate((String) map.get("endDate"));
            infos.setCostType((String) map.get("costType"));
            infos.setSubIds((List<String>) map.get("subIds"));
            infos.setColumns((List<String>) map.get("columns"));
            infos.setMeterCategory((List<String>) map.get("meterCategory"));
            infos.setOperations(operationsEditor(map.get("operations"),file));

            String query = qb.getUsageQuery(infos);
            System.out.println(query);
            Map<String, String> result = new HashMap<>();
            result.put("query", query);
            return result;
    }

    public List<Map<String, Object>> operationsEditor (Object map, List<MultipartFile> file) throws IOException {

        List<Map<String, Object>> ops = (List<Map<String, Object>>) map;
        Map<String, Object> attachMap = new HashMap<>();
        int getAttach = 0;

        for (int i = 0; i < ops.size(); i++) {

            String isAttach = (String) ops.get(i).get("val");

            if ("UP".equals(isAttach)) {

                List<String> list = new ArrayList<>();
                InputStreamReader isr = new InputStreamReader(file.get(getAttach++).getInputStream());
                BufferedReader br = new BufferedReader(isr);

                String str = "";
                String mvals = "";

                try {
                    while ((str = br.readLine()) != null) {
                        mvals += str + ",";
                        list.add(str);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }

                attachMap.put((String) ops.get(i).get("field"), list );
                ops.get(i).put("val", mvals.substring(0, mvals.length() - 1));
            }
        }
        ops.add(attachMap);
        return ops;
    }
}
