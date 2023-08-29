package com.asms.qtip;

import java.util.List;
import java.util.Map;

public class InfoDO {

    String startDate;
    String endDate;
    List<String> subIds;
    String costType;
    List<String> columns;
    List<String> meterCategory;
    List<Map<String, String>> operations;

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

    public List<Map<String, String>> getOperations() {
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

    public void setOperations(List<Map<String, String>> operations) {
        this.operations = operations;
    }
}
