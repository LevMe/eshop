package com.Eshop.pojo;

import java.io.Serializable;

/**
 * @Description: 购物车 **("购物车"中的每一件商品视为一个pojo(car),一个用户的多个pojo(car)合为真正的购物车)**
 * @Author: Liyunhan
 * @Date: 2021/5/7 20:19
 */
public class Car implements Serializable {

    //主键id
    private Integer id;

    //商品id
    private Integer itemId;
    private Item item;

    //用户id
    private Integer userId;

    //商品数量(加入购物车的数量)
    private Integer num;

    //商品单价
    private double price;

    //商品总价
    private String total;

    public Car(Integer id, Integer itemId, Integer userId, Integer num, double price, String total) {
        this.id = id;
        this.itemId = itemId;
        this.userId = userId;
        this.num = num;
        this.price = price;
        this.total = total;
    }

    public Car() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getItemId() {
        return itemId;
    }

    public void setItemId(Integer itemId) {
        this.itemId = itemId;
    }

    public Item getItem() {
        return item;
    }

    public void setItem(Item item) {
        this.item = item;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

    @Override
    public String toString() {
        return "Car{" +
                "id=" + id +
                ", itemId=" + itemId +
                ", item=" + item +
                ", userId=" + userId +
                ", num=" + num +
                ", price=" + price +
                ", total='" + total + '\'' +
                '}';
    }
}

