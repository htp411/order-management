package org.htp.order.entity;

public class SearchOrders {
    private String option;
    private String option_detail;
    private String country;
    private String start;
    private String end;
    private String order_status;

    public String getOption() {
        return option;
    }

    @Override
    public String toString() {
        return "SearchOrders{" +
                "option='" + option + '\'' +
                ", option_detail='" + option_detail + '\'' +
                ", country='" + country + '\'' +
                ", start='" + start + '\'' +
                ", end='" + end + '\'' +
                '}';
    }

    public String getOption_detail() {
        return option_detail;
    }

    public void setOption_detail(String option_detail) {
        this.option_detail = option_detail;
    }

    public void setOption(String option) {
        this.option = option;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getStart() {
        return start;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public String getEnd() {
        return end;
    }

    public void setEnd(String end) {
        this.end = end;
    }

    public String getOrder_status() {
        return order_status;
    }

    public void setOrder_status(String order_status) {
        this.order_status = order_status;
    }
}
