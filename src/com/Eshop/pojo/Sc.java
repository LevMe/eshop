package com.Eshop.pojo;

import java.io.Serializable;

/**
 * @Description: 收藏
 * @Author: Liyunhan
 * @Date: 2021/5/7 18:06
 */
public class Sc implements Serializable {

    //主键
    private Integer id;

    //商品 id
    private Integer itemId;
    private Item item;

    //用户(收藏者) id
    private Integer userId;

    public Sc(Integer id, Integer itemId, Integer userId) {
        this.id = id;
        this.itemId = itemId;
        this.userId = userId;
    }

    public Sc() {
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

    @Override
    public String toString() {
        return "Sc{" +
                "id=" + id +
                ", itemId=" + itemId +
                ", item=" + item +
                ", userId=" + userId +
                '}';
    }
}
