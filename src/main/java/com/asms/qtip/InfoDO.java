package com.asms.qtip;

import java.util.List;
import java.util.Map;

public class InfoDO {

    String enrollNum;
    String startDate;
    String endDate;
    List<String> subIds;
    String costType;
    List<String> columns;
    List<String> meterCategory;
    List<Map<String, Object>> operations;

    public String getEnrollNum() {
        return enrollNum;
    }

    public void setEnrollNum(String enrollNum) {
        this.enrollNum = enrollNum;
    }
    public String getStartDate() {
        return startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public List<String> getSubIds() {
        return subIds;
    }

    public String getCostType() {
        return costType;
    }

    public List<String> getColumns() {
        return columns;
    }

    public List<String> getMeterCategory() {
        return meterCategory;
    }

    public List<Map<String, Object>> getOperations() {
        return operations;
    }

    public void setSubIds(List<String> subIds) {
        this.subIds = subIds;
    }

    public void setColumns(List<String> columns) {
        this.columns = columns;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public void setCostType(String costType) {
        this.costType = costType;
    }

    public void setMeterCategory(List<String> meterCategory) {
        this.meterCategory = meterCategory;
    }

    public void setOperations(List<Map<String, Object>> operations) {
        this.operations = operations;
    }
}
