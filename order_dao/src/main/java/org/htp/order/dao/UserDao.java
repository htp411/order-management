package org.htp.order.dao;

import org.htp.order.entity.User;
import org.springframework.stereotype.Repository;

@Repository("userDao")
public interface UserDao {
    User select(User user);

    void insert(User user);
}
