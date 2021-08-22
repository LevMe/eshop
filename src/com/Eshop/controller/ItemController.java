package com.Eshop.controller;

import com.Eshop.base.BaseController;
import com.Eshop.pojo.Item;
import com.Eshop.pojo.ItemCategory;
import com.Eshop.service.ItemCategoryService;
import com.Eshop.service.ItemService;
import com.Eshop.utils.Pager;
import com.Eshop.utils.SystemContext;
import com.Eshop.utils.UUIDUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * @Description: 商品Controller层
 * @Author: Liyunhan
 * @Date: 2021/5/4 10:13
 */
@Controller
@RequestMapping("/item")
public class ItemController extends BaseController {
    private static int priceOrder;
    private static int gmOrder;

    @Autowired
    private ItemService itemService;

    @Autowired
    private ItemCategoryService itemCategoryService;

    /**
     * 分类查询类目列表(与商品类目类似操作,先查一遍把数据传到前端)
     *
     * @param model
     * @param item
     * @return
     */
    @RequestMapping("/findBySql")
    public String findBySql(Model model, Item item) {
        String sql = "select * from item where isDelete=0 ";
        if (!isEmpty(item.getName())) {
            sql += " and name like '%" + item.getName() + "%' ";
        }
        sql += " order by id desc";  //新添加的商品在上面

        //拿到分页对象
        Pager<Item> pagers = itemService.findBySqlRerturnEntity(sql);
        model.addAttribute("pagers", pagers);
        model.addAttribute("obj", item);
        return "item/item";
    }


    //============================添加商品==================================

    /**
     * 添加商品入口
     * *先查询出所有的父类型,新添加的商品必须属于已有的父类型*
     *
     * @param model
     * @return
     */
    @RequestMapping("/add")
    public String add(Model model) {
        String sql = "select * from item_category where isDelete=0 and pid is not null order by id ";
        //一级类目List集合
        List<ItemCategory> listBySqlReturnEntity = itemCategoryService.listBySqlReturnEntity(sql);
        model.addAttribute("types", listBySqlReturnEntity);
        return "item/add";
    }

    /**
     * 执行添加商品
     *
     * @param item
     * @param files
     * @param request
     * @return
     * @throws IOException
     */
    @RequestMapping("/exAdd")
    public String exAdd(Item item, @RequestParam("file") CommonsMultipartFile[] files, HttpServletRequest request) throws IOException {
        //已抽取公共方法
        itemCommon(item, files, request);
        //设置商品初始购买数量(0),未删除(0),收藏数(0)
        item.setGmNum(0);
        item.setIsDelete(0);
        item.setScNum(0);
        itemService.insert(item);

        //保存完后重新查询列表(跳转到展示页面)
        return "redirect:/item/findBySql.action";

    }


    //============================修改商品==================================

    /**
     * 修改商品入口
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("/update")
    public String update(Integer id, Model model) {
        //拿到前台传来id
        Item obj = itemService.load(id);
        //也需要获得类目列表
        String sql = "select * from item_category where isDelete=0 and pid is not null order by id ";
        List<ItemCategory> listBySqlReturnEntity = itemCategoryService.listBySqlReturnEntity(sql);
        model.addAttribute("types", listBySqlReturnEntity);
        model.addAttribute("obj", obj);
        return "item/update";
    }


    /**
     * 执行修改商品
     *
     * @param item
     * @param files
     * @param request
     * @return
     * @throws IOException
     */
    @RequestMapping("/exUpdate")
    public String exUpdate(Item item, @RequestParam("file") CommonsMultipartFile[] files, HttpServletRequest request) throws IOException {
        itemCommon(item, files, request);

        itemService.updateById(item);

        //保存完后重新查询列表(跳转到展示页面)
        return "redirect:/item/findBySql.action";

    }


    //============================下架商品==================================

    /**
     * 下架商品
     *
     * @param id
     * @return
     */
    @RequestMapping("/delete")
    public String delete(Integer id) {
        //拿到前台传来id
        Item obj = itemService.load(id);
        obj.setIsDelete(1);
        //将修改更新回数据库
        itemService.updateById(obj);
        //再重新返回查询列表后的页面
        return "redirect:/item/findBySql.action";
    }


    //前台

    /**
     * 商品列表
     * 按关键字或者二级分类查询
     * 默认(或第一次进入)为默认排序
     *
     * @param item
     * @param condition
     * @param model
     * @return
     */
    @RequestMapping("/shoplist")
    public String shoplist(Item item, String condition, Model model) {
        String sql = "select * from item where isDelete=0 ";

        //排序条件if组
        //默认asc
        if (!isEmpty(item.getCategoryIdTwo())) {
            sql += " and category_id_two =" + item.getCategoryIdTwo();
        }
        if (!isEmpty(condition)) {
            sql += " and name like '%" + condition + "%' ";
            model.addAttribute("condition", condition);
        }
        //按价格或数量排序
        //由于数据库字段中price字段是varchar,因此排序时是按照字符串排序,因此将其转换为数字
        // 前台传来的price 0 代表降序 1 代表升序
        if (!isEmpty(item.getPrice()) && "0".equals(item.getPrice())) {
            sql += " order by (price+0) desc";
        }
        if (!isEmpty(item.getPrice()) && "1".equals(item.getPrice())) {
            sql += " order by (price+0) asc";
        }

        if (!isEmpty(item.getGmNum()) && item.getGmNum() == 0) {
            sql += " order by gmNum desc";
        }

        if (!isEmpty(item.getGmNum()) && item.getGmNum() == 1) {
            sql += " order by gmNum asc";
        }

        //二者前台传来数据均为空,则默认按一级类目排序
        if (isEmpty(item.getGmNum()) && isEmpty(item.getPrice())) {
            sql += " order by " + item.getCategoryIdOne();
            model.addAttribute("priceOrder", priceOrder);
            model.addAttribute("gmOrder", gmOrder);
        }

        Pager<Item> pagers = itemService.findBySqlRerturnEntity(sql);
        model.addAttribute("pagers", pagers);
        model.addAttribute("obj", item);


        //第一次进入或者传过来price = 0 图标为降序 (注意先判空) , 使用静态变量储存标志,保存下本次另一个不需要查的变量
        if (!isEmpty(item.getPrice()) && item.getPrice().equals("0")) {
            priceOrder = 1;
            model.addAttribute("priceOrder", priceOrder);
            model.addAttribute("gmOrder",gmOrder);
        } else if (!isEmpty(item.getPrice()) && item.getPrice().equals("1")) {
            priceOrder = 0;
            model.addAttribute("priceOrder", priceOrder);
            model.addAttribute("gmOrder",gmOrder);
        }

        if (!isEmpty(item.getGmNum()) && item.getGmNum() == 0) {
            gmOrder = 1;
            model.addAttribute("gmOrder", gmOrder);
            model.addAttribute("priceOrder", priceOrder);
        } else if (!isEmpty(item.getGmNum()) && item.getGmNum() == 1) {
            gmOrder = 0;
            model.addAttribute("gmOrder", gmOrder);
            model.addAttribute("priceOrder", priceOrder);
        }
        return "item/shoplist";
    }

    /**
     * 前往商品详情
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("/view")
    public String view(Integer id, Model model) {
        Item obj = itemService.load(id);
        model.addAttribute("obj", obj);
        return "item/view";
    }


    /**
     * 新增和修改的公共方法
     *
     * @param item
     * @param files
     * @param request
     * @throws IOException
     */
    private void itemCommon(Item item, @RequestParam("file") CommonsMultipartFile[] files, HttpServletRequest request) throws IOException {
        //先判断有没有传来的文件
        if (files.length > 0) {
            for (int s = 0; s < files.length; s++) {
                //先判断是不是全部修改了(没有修改的图片前台文件名会传空,不做改动)
                if (files[s].getOriginalFilename() == null || "".equals(files[s].getOriginalFilename())) continue;
                //生成唯一表示码(避免图片重名)
                String n = UUIDUtils.create();
                String path = SystemContext.getRealPath() + "/resource/ueditor/upload/" + n + files[s].getOriginalFilename();
                File file = new File(path);
                //通过CommonsMultipartFile的方法直接写文件到路径
                files[s].transferTo(file);
                //主图
                if (s == 0) {
                    item.setUrl1(request.getContextPath() + "/resource/ueditor/upload/" + n + files[s].getOriginalFilename());
                }
                //副图1
                if (s == 1) {
                    item.setUrl2(request.getContextPath() + "/resource/ueditor/upload/" + n + files[s].getOriginalFilename());
                }
                //副图2
                if (s == 2) {
                    item.setUrl3(request.getContextPath() + "/resource/ueditor/upload/" + n + files[s].getOriginalFilename());
                }
                //副图3
                if (s == 3) {
                    item.setUrl4(request.getContextPath() + "/resource/ueditor/upload/" + n + files[s].getOriginalFilename());
                }
                //副图4
                if (s == 4) {
                    item.setUrl5(request.getContextPath() + "/resource/ueditor/upload/" + n + files[s].getOriginalFilename());
                }
            }
        }

        //根据二级id拿到父id
        ItemCategory byId = itemCategoryService.getById(item.getCategoryIdTwo());
        //设置进去
        item.setCategoryIdOne(byId.getPid());
    }
}
