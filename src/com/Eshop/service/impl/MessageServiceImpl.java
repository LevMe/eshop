package com.Eshop.service.impl;

import com.Eshop.base.BaseDao;
import com.Eshop.base.BaseServiceImpl;
import com.Eshop.mapper.MessageMapper;
import com.Eshop.pojo.Message;
import com.Eshop.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Description:
 * @Author: Liyunhan
 * @Date: 2021/5/5 10:52
 */
@Service
public class MessageServiceImpl extends BaseServiceImpl<Message> implements MessageService {

    @Autowired
    private MessageMapper messageMapper;


    @Override
    public BaseDao<Message> getBaseDao() {
        return messageMapper;
    }
}
