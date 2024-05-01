package com.asms.qtip.qtip_asms.Model;

import java.util.List;

public class DInfo {

    String enrollNum;
    String startDate;
    String endDate;
    List<String> ids;

    public String getEnrollNum() {
        return enrollNum;
    }

    public void setEnrollNum(String enrollNum) {
        this.enrollNum = enrollNum;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public List<String> getIds() {
        return ids;
    }

    public void setIds(List<String> ids) {
        this.ids = ids;
    }
}
