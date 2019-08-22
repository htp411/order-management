package org.htp.order.biz.impl;

import org.htp.order.biz.LogBiz;
import org.htp.order.dao.LogDao;
import org.htp.order.entity.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;
@Service("logBiz")
public class LogBizImpl implements LogBiz {
    private final LogDao logDao;

    public LogBizImpl(@Qualifier("logDao") LogDao logDao) {
        this.logDao = logDao;
    }

    public List<Log> getAll() {
        return logDao.select();
    }

    public void add(Log log) {
        logDao.insert(log);
    }

    public List<Log> searchLog(String module, String start, String end) {
        return logDao.selectByOption(module,start,end);
    }
}
