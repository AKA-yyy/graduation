package com.wulaobo.mapper;

import com.wulaobo.bean.User;

import java.util.List;

public interface UserMapper {

    User login(String username, String password);

    void save(User user);

    User getUserByUserName(String username);

    void updatePasswordByUserName(String md5Pwd, String userName);

    User adminLogin(String username, String password);

    List<User> getAllUser();

    List<User> selectByName(String username);

    boolean deleteUserById(Integer id);

    boolean changeRoleByUser(User user);

    User getUserById(Integer id);

    boolean updateStateByUser(User user);

    boolean updateAdminPassword(User admin);
}
