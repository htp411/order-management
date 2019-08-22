package org.htp.order.dto;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class IdDto {
    private String id;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "IdDto{" +
                "id='" + id + '\'' +
                '}';
    }
}
