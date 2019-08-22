package org.htp.order.biz.impl;

import org.htp.order.biz.UserBiz;
import org.htp.order.dao.UserDao;
import org.htp.order.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service("userBiz")
public class UserBizImpl implements UserBiz {
    private final UserDao userDao;

    public UserBizImpl(@Qualifier("userDao") UserDao userDao) {
        this.userDao = userDao;
    }

    public boolean isPassCheck(User user) {
        return userDao.select(user) != null;
    }

    public void createUser(User user) {
        userDao.insert(user);
    }
}
