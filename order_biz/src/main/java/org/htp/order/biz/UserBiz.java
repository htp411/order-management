package org.htp.order.biz;

import org.htp.order.entity.User;

public interface UserBiz {
    boolean isPassCheck(User user);

    void createUser(User user);
}
