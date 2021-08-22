package com.Eshop.controller;

import com.Eshop.pojo.Item;
import com.Eshop.pojo.Sc;
import com.Eshop.service.ItemService;
import com.Eshop.service.ScService;
import com.Eshop.utils.Consts;
import com.Eshop.utils.Pager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * @Description: 收藏Controller层
 * @Author: Liyunhan
 * @Date: 2021/5/7 18:24
 */
@Controller
@RequestMapping("/sc")
public class ScController {

    @Autowired
    private ScService scService;

    @Autowired
    private ItemService itemService;

    /**
     * 添加用户收藏的商品到该用户账户中
     *
     * @param sc
     * @param request
     * @return
     */
    @RequestMapping("/exAdd")
    public String exAdd(Sc sc, HttpServletRequest request) {
        //从session中取得用户的信息
        Object attribute = request.getSession().getAttribute(Consts.USERID);
        if (attribute == null) {
            return "redirect:/login/uLogin";
        }
        //保存到收藏表中
        Integer userId = Integer.valueOf(attribute.toString());
        sc.setUserId(userId);
        scService.insert(sc);
        //商品收藏数+1
        Item item = itemService.load(sc.getItemId());
        item.setScNum(item.getScNum() + 1);
        itemService.updateById(item);

        return "redirect:/sc/findBySql.action";
    }

    /**
     * 收藏列表查询展示
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/findBySql")
    public String findBySql(Model model, HttpServletRequest request){
        //从session中取得用户的信息
        Object attribute = request.getSession().getAttribute(Consts.USERID);
        if (attribute==null){
            return "redirect:/login/uLogin";
        }
        Integer userId = Integer.valueOf(attribute.toString());
        String sql = "select * from sc where user_id=" + userId + " order by id desc";
        Pager<Sc> pagers = scService.findBySqlRerturnEntity(sql);
        model.addAttribute("pagers",pagers);
        return "sc/mySc";
    }


    @RequestMapping("/delete")
    public String delete(Integer id,HttpServletRequest request){
        //从session中取得用户的信息
        Object attribute = request.getSession().getAttribute(Consts.USERID);
        if (attribute==null){
            return "redirect:/login/uLogin";
        }
        scService.deleteById(id);
        return "redirect:/sc/findBySql.action";
    }
}
