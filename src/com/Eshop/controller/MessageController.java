package com.Eshop.controller;

import com.Eshop.base.BaseController;
import com.Eshop.pojo.Message;
import com.Eshop.service.MessageService;
import com.Eshop.utils.Pager;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @Description: 留言管理controller
 * @Author: Liyunhan
 * @Date: 2021/5/5 10:07
 */
@Controller
@RequestMapping("/message")
public class MessageController extends BaseController {

    @Autowired
    private MessageService messageService;
    /**
     * 留言列表查询展示
     * @param message
     * @param model
     * @return
     */
    @RequestMapping("/findBySql")
    public String findBySql(Message message, Model model) {
        String sql = "select * from message where 1=1 ";
        //有参数传过来就模糊查询,没有查询全部
        if (!isEmpty(message.getName())) {
            sql += " and name like '%" + message.getName() + "%' ";
        }
        sql += " order by id desc";

        Pager<Message> pagers = messageService.findBySqlRerturnEntity(sql);
        model.addAttribute("pagers",pagers);
        model.addAttribute("obj",message);

        return "message/message";
    }


    /**
     * 删除留言
     * @param id
     * @return
     */
    @RequestMapping("/delete")
    public String delete(Integer id){
        messageService.deleteById(id);
        return "redirect:/message/findBySql.action";
    }

    //前端
    /**
     * 跳转发表留言
     * @return
     */
    @RequestMapping("/add")
    public String add(){
        //任何人都可以留言(不论是否登录)
        return "message/add";
    }


    @RequestMapping("/exAdd")
    @ResponseBody
    public String exAdd(Message message){
        messageService.insert(message);
        JSONObject js = new JSONObject();
        js.put("message","添加成功");
        return js.toJSONString();
    }
}
