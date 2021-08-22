package com.Eshop.controller;

import com.Eshop.base.BaseController;
import com.Eshop.pojo.News;
import com.Eshop.service.NewsService;
import com.Eshop.utils.Pager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Date;

/**
 * @Description: 帮助服务信息管理controller
 * @Author: Liyunhan
 * @Date: 2021/5/5 10:07
 */
@Controller
@RequestMapping("/news")
public class NewsController extends BaseController {

    @Autowired
    private NewsService newsService;
    /**
     * 帮助服务信息列表查询展示
     * @param news
     * @param model
     * @return
     */
    @RequestMapping("/findBySql")
    public String findBySql(News news, Model model) {
        String sql = "select * from news where 1=1 ";
        //有参数传过来就模糊查询,没有查询全部
        if (!isEmpty(news.getName())) {
            sql += " and name like '%" + news.getName() + "%' ";
        }
        sql += " order by id desc";

        Pager<News> pagers = newsService.findBySqlRerturnEntity(sql);
        model.addAttribute("pagers",pagers);
        model.addAttribute("obj",news);

        return "news/news";
    }

    //============================新增帮助服务信息==================================
    /**
     * 跳转到添加页面
     * @return
     */
    @RequestMapping("/add")
    public String add(){
        return "news/add";
    }

    /**
     * 执行添加
     * @param news
     * @return
     */
    @RequestMapping("/exAdd")
    public String exAdd(News news){
        //设置为当前时间
        news.setAddTime(new Date());
        newsService.insert(news);
        return "redirect:/news/findBySql.action";
    }


    //============================修改帮助服务信息==================================
    /**
     * 跳转到修改页面
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("/update")
    public String update(Integer id, Model model){
        News obj = newsService.load(id);
        model.addAttribute("obj",obj);
        return "news/update";
    }

    /**
     * 执行修改
     * @param news
     * @return
     */
    @RequestMapping("/exUpdate")
    public String exUpdate(News news){
        newsService.updateById(news);
        return "redirect:/news/findBySql.action";
    }


    //============================删除信息==================================
    /**
     * 删除信息
     * @param id
     * @return
     */
    @RequestMapping("/delete")
    public String delete(Integer id){
        newsService.deleteById(id);
        return "redirect:/news/findBySql.action";
    }

    /**
     * 前端帮助服务信息列表
     * @param model
     * @return
     */
    @RequestMapping("/list")
    public String list(Model model){
        //不需要查询条件
        Pager<News> pagers = newsService.findByEntity(new News());
        model.addAttribute("pagers",pagers);
        return "news/list";
    }


    /**
     * 跳转到帮助服务信息详情页面
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("/view")
    public String view(Integer id, Model model){
        News obj = newsService.load(id);
        model.addAttribute("obj",obj);
        return "news/view";
    }
}
