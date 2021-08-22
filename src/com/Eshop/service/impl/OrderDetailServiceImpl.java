package com.Eshop.service.impl;

import com.Eshop.base.BaseDao;
import com.Eshop.base.BaseServiceImpl;
import com.Eshop.mapper.OrderDetailMapper;
import com.Eshop.pojo.OrderDetail;
import com.Eshop.service.OrderDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Description:
 * @Author: Liyunhan
 * @Date: 2021/5/4 21:35
 */
@Service
public class OrderDetailServiceImpl extends BaseServiceImpl<OrderDetail> implements OrderDetailService {

    @Autowired
    private OrderDetailMapper orderDetailMapper;

    @Override
    public BaseDao<OrderDetail> getBaseDao() {
        return orderDetailMapper;
    }
}
