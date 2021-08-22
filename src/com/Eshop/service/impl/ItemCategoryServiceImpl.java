package com.Eshop.service.impl;

import com.Eshop.base.BaseDao;
import com.Eshop.base.BaseServiceImpl;
import com.Eshop.mapper.ItemCategoryMapper;
import com.Eshop.pojo.ItemCategory;
import com.Eshop.service.ItemCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Description:
 * @Author: Liyunhan
 * @Date: 2021/5/3 15:35
 */
@Service
public class ItemCategoryServiceImpl extends BaseServiceImpl<ItemCategory> implements ItemCategoryService {

    @Autowired
    private ItemCategoryMapper itemCategoryMapper;

    /**
     *   此处实现父类(抽象基类)的抽象方法,返回本实现类对应的mapper,则抽象基类(父类)中的"真正执行者"动态的
     * 切换为此处的mapper -->(getBaseDao)
     * @return
     */
    @Override
    public BaseDao<ItemCategory> getBaseDao() {
        return itemCategoryMapper;
    }
}
