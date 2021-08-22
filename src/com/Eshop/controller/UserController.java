package com.Eshop.controller;

import com.Eshop.base.BaseController;
import com.Eshop.pojo.User;
import com.Eshop.service.UserService;
import com.Eshop.utils.Consts;
import com.Eshop.utils.Pager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * @Description: 用户controller层
 * @Author: Liyunhan
 * @Date: 2021/5/3 21:45
 */
@Controller
@RequestMapping("/user")
public class UserController extends BaseController {

    @Autowired
    private UserService userService;


    /**
     * 首次到访无条件查询以及后续带条件查询
     * @param model
     * @param user
     * @return
     */
    @RequestMapping("/findBySql")
    public String findBySql(Model model, User user){
        String sql = "select * from user where 1=1 " ;
        //模糊查询
        if (!isEmpty(user.getUserName())){
            sql += " and userName like '%"+user.getUserName()+"%' ";
        }

        sql+="order by id";
        Pager<User> pagers = userService.findBySqlRerturnEntity(sql);
        model.addAttribute("pagers",pagers);
        model.addAttribute("obj",user);
        return "user/user";
    }


    //============================(管理员)修改用户信息==================================

    /**
     * (管理员)转到修改用户信息页面
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("/mUpdate")
    public String mUpdate(Integer id, Model model){
        User user = userService.getById(id);
        //将完整对象传回前端
        model.addAttribute("obj",user);
        return "user/update";
    }

    /**
     * (管理员)执行修改用户信息
     * @param user
     * @return
     */
    @RequestMapping("/exmUpdate")
    public String exmUpdate(User user){
        userService.updateById(user);
        return "redirect:/user/findBySql.action";
    }


    //============================(管理员)删除用户账户==================================

    /**
     * (管理员)删除用户账户
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("/mDelete")
    public String mDelete(Integer id, Model model){
//        User user = userService.getById(id);
        userService.deleteById(id);
        return "redirect:/user/findBySql.action";
    }



    //前台
    /**
     * 跳转查看用户信息页面
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/view")
    public String view(Model model, HttpServletRequest request){
        //从session获取用户信息
        Object attribute = request.getSession().getAttribute(Consts.USERID);
        if (attribute==null){
            return "redirect:/login/uLogin";
        }
        Integer userId = Integer.valueOf(attribute.toString());
        User obj = userService.load(userId);
        model.addAttribute("obj",obj);
        //拿到完整user对象后就可以去展示页面
        return "user/view";

    }

    /**
     * 执行更新用户信息的操作
     * @param user
     * @param request
     * @return
     */
    @RequestMapping("/exUpdate")
    public String exUpdate(User user, HttpServletRequest request){
        //从session获取用户信息(未登录要求先登录)
        Object attribute = request.getSession().getAttribute(Consts.USERID);
        if (attribute==null){
            return "redirect:/login/uLogin";
        }
        user.setId(Integer.valueOf(attribute.toString()));
        userService.updateById(user);
        return "redirect:/user/view.action";
    }

}
