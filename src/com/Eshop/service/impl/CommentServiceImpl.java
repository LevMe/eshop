package com.Eshop.service.impl;

import com.Eshop.base.BaseDao;
import com.Eshop.base.BaseServiceImpl;
import com.Eshop.mapper.CommentMapper;
import com.Eshop.pojo.Comment;
import com.Eshop.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Description:
 * @Author: Liyunhan
 * @Date: 2021/5/9 11:29
 */
@Service
public class CommentServiceImpl extends BaseServiceImpl<Comment> implements CommentService {

    @Autowired
    private CommentMapper commentMapper;

    @Override
    public BaseDao<Comment> getBaseDao() {
        return commentMapper;
    }
}
