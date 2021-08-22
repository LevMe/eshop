package com.Eshop.pojo;

import java.util.List;

/**
 * @Description: 为页面内容服务的 -- 一级类目和它的二级类目列表
 * @Author: Liyunhan
 * @Date: 2021/5/6 11:23
 */
public class CategoryDto {

    //父类
    private ItemCategory father;

    //父类的下一级列表
    private List<ItemCategory> childrens;

    public ItemCategory getFather() {
        return father;
    }

    public void setFather(ItemCategory father) {
        this.father = father;
    }

    public List<ItemCategory> getChildrens() {
        return childrens;
    }

    public void setChildrens(List<ItemCategory> childrens) {
        this.childrens = childrens;
    }
}
