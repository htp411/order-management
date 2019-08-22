package org.htp.order.dao;

import org.apache.ibatis.annotations.Param;
import org.htp.order.entity.Log;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository("logDao")
public interface LogDao {
    List<Log> select();
    void insert(Log log);

    List<Log> selectByOption(@Param("module") String module, @Param("start") String start, @Param("end") String end);
}
