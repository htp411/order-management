package org.htp.order.biz;

import org.htp.order.entity.Log;

import java.util.List;

public interface LogBiz {
    List<Log> getAll();
    void add(Log log);

    List<Log> searchLog(String module, String start, String end);
}
