package com.Eshop.pojo;

import java.io.Serializable;
import java.util.Date;

/**
 * @Description: 评价
 * @Author: Liyunhan
 * @Date: 2021/5/6 11:23
 */
public class Comment implements Serializable {

    //主键
    private Integer id;

    //用户id
    private Integer userId;
    private User user;

    //商品id
    private Integer itemId;

    //评价内容
    private String content;

    //发布时间
    private Date addTime;


    public Comment() {
    }

    public Comment(Integer id, Integer userId, Integer itemId, String content, Date addTime) {
        this.id = id;
        this.userId = userId;
        this.itemId = itemId;
        this.content = content;
        this.addTime = addTime;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Integer getItemId() {
        return itemId;
    }

    public void setItemId(Integer itemId) {
        this.itemId = itemId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    @Override
    public String toString() {
        return "Comment{" +
                "id=" + id +
                ", userId=" + userId +
                ", itemId=" + itemId +
                ", content='" + content + '\'' +
                ", addTime=" + addTime +
                '}';
    }
}
