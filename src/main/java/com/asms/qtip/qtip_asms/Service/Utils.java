package com.asms.qtip.qtip_asms.Service;

import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

public class Utils{
    public static List<String> DateRange(String start, String end) {
        // Map<String, String> dates = new HashMap<>();
        List<String> dates = new ArrayList<>();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate startDate = LocalDate.parse(start, formatter);
        LocalDate endDate = LocalDate.parse(end, formatter);

        //Period period = Period.between(startDate, endDate);
        //int months = period.getMonths();

        YearMonth moStart = YearMonth.from(startDate);
        YearMonth moEnd = YearMonth.from(endDate);

        int months = (int) ChronoUnit.MONTHS.between(moStart, moEnd);
        // if year/months is not same
        if (!moStart.equals(moEnd)) {

            // 시작
            dates.add(startDate + "," + moStart.atEndOfMonth());
            System.out.println(startDate + ", " + moStart.atEndOfMonth());

            if (months > 0) {
                for (int i = 1; i < months; i++) {
                    LocalDate nextMonth = startDate.plusMonths(i);
                    String tMonth = nextMonth.getMonthValue() + "";

                    if (nextMonth.getMonthValue() < 10) {
                        tMonth = "0" + tMonth;
                    }
                    String temp = nextMonth.getYear() + "-" + tMonth + "-01";
                    LocalDate tempDate = LocalDate.parse(temp, formatter);
                    YearMonth tempMonth = YearMonth.from(tempDate);
                    dates.add(tempMonth.atDay(1) + "," + tempMonth.atEndOfMonth());
                    System.out.println(tempMonth.atDay(1) + ", " + tempMonth.atEndOfMonth());
                }
            }
            // 마지막
            dates.add(moEnd.atDay(1) + "," + endDate);
            System.out.println(moEnd.atDay(1) + ", " + endDate);
            System.out.println(months);
        }

        return dates;
    }
}
