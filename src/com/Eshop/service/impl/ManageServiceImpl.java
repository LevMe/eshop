package com.Eshop.service.impl;

import com.Eshop.base.BaseDao;
import com.Eshop.base.BaseServiceImpl;
import com.Eshop.mapper.ManageMapper;
import com.Eshop.pojo.Manage;
import com.Eshop.service.ManageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Description:
 * @Author: Liyunhan
 * @Date: 2021/5/3 15:35
 */
@Service
public class ManageServiceImpl extends BaseServiceImpl<Manage> implements ManageService {

    @Autowired
    private ManageMapper manageMapper;

    /**
     *   此处实现父类(抽象基类)的抽象方法,返回本实现类对应的mapper,则抽象基类(父类)中的"真正执行者"动态的
     * 切换为此处的mapper -->(getBaseDao)
     * @return
     */
    @Override
    public BaseDao<Manage> getBaseDao() {
        return manageMapper;
    }
}
