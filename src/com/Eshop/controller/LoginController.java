package com.Eshop.controller;

import com.Eshop.base.BaseController;
import com.Eshop.pojo.*;
import com.Eshop.service.ItemCategoryService;
import com.Eshop.service.ItemService;
import com.Eshop.service.ManageService;
import com.Eshop.service.UserService;
import com.Eshop.utils.Consts;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * @Description: 登录相关的控制器
 * @Author: Liyunhan
 * @Date: 2021/5/3 11:30
 */
@Controller
@RequestMapping("/login")
public class LoginController extends BaseController {

    //注入Service
    @Autowired
    private ManageService manageService;

    @Autowired
    private ItemCategoryService itemCategoryService;

    @Autowired
    private ItemService itemService;

    @Autowired
    private UserService userService;


    /**
     * 跳转站点信息jsp
     *
     * @return
     */
    @RequestMapping("/info")
    public String info() {
        return "websiteInfo/info";
    }


    //============================管理员登录==================================

    /**
     * 管理员登陆前 -->跳转到登录验证页面 jsp(需要一个页面填写表单)
     * 1.平台管理员入口
     *
     * @return
     */
    @RequestMapping("/login")
    public String login() {
        return "/login/mLogin";
    }

    /**
     * 登陆验证 (这里需要HttpServletRequest是因为登录成功后要把登陆的账户对象放到session中去)
     * @param manage
     * @param request
     * @return
     */
    @RequestMapping("/toLogin")
    public String toLogin(Manage manage, HttpServletRequest request) {
        Manage byEntity = manageService.getByEntity(manage);
        if (byEntity == null) {
            return "redirect:/login/mExit";
        }
        //设置session键值, 和后面管理员退出要对应
        request.getSession().setAttribute(Consts.MANAGE, byEntity);
        //登录成功跳转至mIndex页面
        return "/login/mIndex";
    }


    //============================管理员退出==================================

    /**
     * 管理员退出 -->直接退出,返回登录页面
     *
     * @param request
     * @return
     */
    @RequestMapping("/mExit")
    public String mExit(HttpServletRequest request) {
        //清空session信息
        request.getSession().setAttribute(Consts.MANAGE, null);
        //返回登录页面
        return "/login/mLogin";
    }


    //前台
    //============================**进入首页前的操作**==================================

    /**
     * 前端首页 (进入时将默认要展示的数据带过去)
     *
     * @param model
     * @return
     */
    @RequestMapping("/uIndex")
    public String uIndex(Model model) {
        //pid为null的一定不是子类,它也一定没有父类
        String sql = "select * from item_category where isDelete=0 and pid is null order by name";
        List<ItemCategory> fatherList = itemCategoryService.listBySqlReturnEntity(sql);
        //借助一个DTO(每一个一级分类和它的子分类(多个:列表))
        List<CategoryDto> list = new ArrayList<>();
        if (!CollectionUtils.isEmpty(fatherList)) {
            for (ItemCategory ic :
                    fatherList) {
                //每一个父类封装一个pojo
                CategoryDto dto = new CategoryDto();
                dto.setFather(ic);
                //查询二级类目
                String sql2 = "select * from item_category where isDelete=0 and pid=" + ic.getId();
                List<ItemCategory> childrens = itemCategoryService.listBySqlReturnEntity(sql2);
                dto.setChildrens(childrens);
                list.add(dto);
            }
            model.addAttribute("lbs", list);
        }
        //本店主营:二手笔记本电脑
        List<Item> nb = itemService.listBySqlReturnEntity("select * from item where isDelete=0 and category_id_one=82 order by price desc limit 0,10");
        model.addAttribute("nb", nb);
        //其他商品
        List<Item> ot = itemService.listBySqlReturnEntity("select * from item where isDelete=0 and category_id_one!=82 order by price desc limit 0,10");
        model.addAttribute("ot", ot);

        return "login/uIndex";
    }


    //============================用户注册==================================

    /**
     * 跳转普通用户注册页面
     *
     * @return
     */
    @RequestMapping("/regist")
    public String res() {
        return "login/regist";
    }

    /**
     * 执行普通用户注册
     *
     * @param user
     * @return
     */
    @RequestMapping("/toRegist")
    @ResponseBody
    public String toRegist(User user, String checkCode, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String checkcode_server = (String) session.getAttribute("CHECKCODE_SERVER");
        //为防止用户点后退,立刻将验证码从session移除,保证验证码只能用一次
        session.removeAttribute("CHECKCODE_SERVER");
        JSONObject js = new JSONObject();
        //先比对验证码
        if (checkcode_server == null || !checkcode_server.equalsIgnoreCase(checkCode)) {
            //验证码不正确或没有验证码
            js.put(Consts.FLAG, false);
            return js.toJSONString();
        }
        //检查用户名合法性(是否已被占用)
        String sql = "select * from user where userName='" + user.getUserName() + "'";
        User tUser = userService.getBySqlReturnEntity(sql);
        if (tUser != null){
            js.put(Consts.FLAG, false);
            js.put(Consts.RES,"invalid");
            return js.toJSONString();
        }

        //合法,将新用户信息写入数据库
        userService.insert(user);
        js.put(Consts.FLAG, true);
        return js.toJSONString();
    }


    //============================用户登录==================================

    /**
     * 普通用户登录 -->跳转到登录页面
     *
     * @return
     */
    @RequestMapping("/uLogin")
    public String uLogin() {
        return "login/uLogin";
    }

    /**
     * 校验普通用户登录
     *
     * @return
     */
    @RequestMapping("/utoLogin")
    @ResponseBody
    public String uLogin(String userName, String passWord, HttpServletRequest request) {
        //判断账户密码所属是否为一个人
        String sql = "select * from user where userName='" + userName + "'";
        User user = userService.getBySqlReturnEntity(sql);
        JSONObject js = new JSONObject();
        //判断(先要判断有没有此用户)
        if (user == null || !user.getPassWord().equals(passWord)) {
            //不匹配,登录失败
            js.put(Consts.FLAG, false);
        } else {
            //匹配,登录成功,将登录用户存入session
            request.getSession().setAttribute("role", 2);
            request.getSession().setAttribute(Consts.USERNAME, user.getUserName());
            request.getSession().setAttribute(Consts.USERID, user.getId());
            js.put(Consts.FLAG, true);
        }
        return js.toJSONString();
    }


    //============================用户退出==================================

    /**
     * 普通用户退出
     *
     * @param request
     * @return
     */
    @RequestMapping("/uExit")
    public String uExit(HttpServletRequest request) {
        //清空session
        HttpSession session = request.getSession();
        session.invalidate();
        return "redirect:/login/uIndex.action";
    }


    //============================用户修改密码==================================

    /**
     * 修改密码入口
     *
     * @param request
     * @return
     */
    @RequestMapping("/updatePassword")
    public String updatePassword(HttpServletRequest request) {
        //从session中取得用户的信息
        Object attribute = request.getSession().getAttribute(Consts.USERID);
        if (attribute == null) {
            return "redirect:/login/uLogin";
        }
        Integer userId = Integer.valueOf(attribute.toString());
        User load = userService.load(userId);
        request.setAttribute("obj", load);
        return "login/updatePassword";
    }


    /**
     * 执行修改密码
     *
     * @param request password
     * @return
     */
    @RequestMapping("/upass")
    @ResponseBody
    public String upass(String password, HttpServletRequest request) {
        //从session中取得用户的信息
        Object attribute = request.getSession().getAttribute(Consts.USERID);
        JSONObject js = new JSONObject();
        if (attribute == null) {
            js.put(Consts.RES, 0);
            return js.toJSONString();
        }
        Integer userId = Integer.valueOf(attribute.toString());
        User load = userService.load(userId);
        load.setPassWord(password);
        userService.updateById(load);
        js.put(Consts.RES, 1);
        return js.toJSONString();
    }
}
