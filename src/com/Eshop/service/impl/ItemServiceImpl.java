package com.Eshop.service.impl;

import com.Eshop.base.BaseDao;
import com.Eshop.base.BaseServiceImpl;
import com.Eshop.mapper.ItemMapper;
import com.Eshop.pojo.Item;
import com.Eshop.service.ItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Description:
 * @Author: Liyunhan
 * @Date: 2021/5/4 9:55
 */
@Service
public class ItemServiceImpl extends BaseServiceImpl<Item> implements ItemService {

    @Autowired
    private ItemMapper itemMapper;

    @Override
    public BaseDao<Item> getBaseDao() {
        return itemMapper;
    }
}
