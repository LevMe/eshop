package com.Eshop.pojo;

import java.io.Serializable;

/**
 * @Description: 用户
 * @Author: Liyunhan
 * @Date: 2021/5/3 21:12
 */
public class User implements Serializable {

    //主键 id
    private Integer id;

    //用户名 userName
    private String userName;

    //密码 passWord
    private String passWord;

    //电话号码 phone
    private String phone;

    //姓名 realName
    private String realName;

    //性别 sex
    private String sex;

    //地址 address
    private String address;

    //电子邮箱 email
    private String email;

    public User(Integer id, String userName, String passWord, String phone, String realName, String sex, String address, String email) {
        this.id = id;
        this.userName = userName;
        this.passWord = passWord;
        this.phone = phone;
        this.realName = realName;
        this.sex = sex;
        this.address = address;
        this.email = email;
    }

    public User() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassWord() {
        return passWord;
    }

    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }


    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", userName='" + userName + '\'' +
                ", passWord='" + passWord + '\'' +
                ", phone='" + phone + '\'' +
                ", realName='" + realName + '\'' +
                ", sex='" + sex + '\'' +
                ", address='" + address + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
}
