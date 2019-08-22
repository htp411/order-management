package org.htp.order.dto;

public class DeliveryDto {
    private String id;
    private String channel;
    private String trackingNumber;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getChannel() {
        return channel;
    }

    public void setChannel(String channel) {
        this.channel = channel;
    }

    public String getTrackingNumber() {
        return trackingNumber;
    }

    public void setTrackingNumber(String trackingNumber) {
        this.trackingNumber = trackingNumber;
    }

    @Override
    public String toString() {
        return "DeliveryDto{" +
                "id='" + id + '\'' +
                ", channel='" + channel + '\'' +
                ", trackingNumber='" + trackingNumber + '\'' +
                '}';
    }
}
