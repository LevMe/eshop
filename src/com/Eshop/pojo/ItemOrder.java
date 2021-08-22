package com.Eshop.pojo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * @Description: 订单
 * @Author: Liyunhan
 * @Date: 2021/5/4 16:58
 */
public class ItemOrder implements Serializable {

    //主键
    private Integer id;

    //买家id
    private Integer userId;
    private User user;

    //订单号
    private String code;

    //下单时间
    private Date addTime;

    //购买数量
    private String total;

    //是否已下架
    private Integer isDelete;

    //0.待发货1.已取消 2已发货3.收到货4已评价
    private Integer status;

    //一次订单的"订单内容"(一个单号可能买了不止一件东西)
    private List<OrderDetail> details;

    public ItemOrder(Integer id, Integer userId, User user, String code, Date addTime, String total, Integer isDelete, Integer status) {
        this.id = id;
        this.userId = userId;
        this.user = user;
        this.code = code;
        this.addTime = addTime;
        this.total = total;
        this.isDelete = isDelete;
        this.status = status;
    }

    public ItemOrder() {
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

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

    public Integer getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(Integer isDelete) {
        this.isDelete = isDelete;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public List<OrderDetail> getDetails() {
        return details;
    }

    public void setDetails(List<OrderDetail> details) {
        this.details = details;
    }

    @Override
    public String toString() {
        return "ItemOrder{" +
                "id=" + id +
                ", userId=" + userId +
                ", user=" + user +
                ", code='" + code + '\'' +
                ", addTime=" + addTime +
                ", total='" + total + '\'' +
                ", isDelete=" + isDelete +
                ", status=" + status +
                '}';
    }
}
