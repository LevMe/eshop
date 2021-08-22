package com.Eshop.controller;

import com.Eshop.base.BaseController;
import com.Eshop.pojo.ItemCategory;
import com.Eshop.service.ItemCategoryService;
import com.Eshop.utils.Pager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @Description: 类目controller层
 * @Author: Liyunhan
 * @Date: 2021/5/3 17:09
 */
@Controller
@RequestMapping("/itemCategory")
public class ItemCategoryController extends BaseController {
    @Autowired
    private ItemCategoryService itemCategoryService;

    /**
     * 分类查询类目列表
     * @param model
     * @param itemCategory
     * @return
     */
    @RequestMapping("/findBySql")
    public String findBySql(Model model,ItemCategory itemCategory){
        //拿到所有父id是空的(他没有父类因此是一级分类),默认(包括第一次进展示一级分类)
        String sql = "select * from item_category where isDelete=0 and pid is null order by id";
        //拿到分页对象
        Pager<ItemCategory> pagers = itemCategoryService.findBySqlRerturnEntity(sql);
        model.addAttribute("pagers",pagers);
        model.addAttribute("obj",itemCategory);
        return "itemCategory/itemCategory";
    }


    //============================新增一级分类==================================
    /**
     * 转向到新增一级分类页面
     * @return
     */
    @RequestMapping("/add")
    public String add(){
        return "itemCategory/add";
    }

    /**
     * 新增一级分类保存功能(执行)
     * @param itemCategory "从前端传来的对象"
     * @return
     */
    @RequestMapping("/exAdd")
    public String exAdd(ItemCategory itemCategory){
        //未删除
        itemCategory.setIsDelete(0);
        itemCategoryService.insert(itemCategory);
        //直接重定向到本类中的方法:分类查询类目列表,然后经该方法查询后打印列表
        return "redirect:/itemCategory/findBySql.action";
    }


    //============================修改一级分类==================================
    /**
     * 转向到修改一级分类页面
     * @return
     */
    @RequestMapping("/update")
    public String update(Integer id,Model model){
        //根据id获取到此完整对象
        ItemCategory obj = itemCategoryService.load(id);
        //将完整对象传回前端
        model.addAttribute("obj",obj);
        return "itemCategory/update";
    }

    /**
     * 执行修改一级类目
     * @param itemCategory
     * @return
     */
    @RequestMapping("/exUpdate")
    public String exUpdate(ItemCategory itemCategory){
        //只要id传过来,其他内容传过来什么改什么
        itemCategoryService.updateById(itemCategory);
        //修改完重新查询打印列表
        return "redirect:/itemCategory/findBySql.action";
    }

    //============================删除分类==================================
    /**
     * 删除类目(假删除)
     * @param id
     * @return
     */
    @RequestMapping("/delete")
    public String delete(Integer id){
        //根据id拿到完整对象
        ItemCategory load = itemCategoryService.load(id);
        //假删除(仅仅将IsDelete属性改为1)
        load.setIsDelete(1);
        //将"带有假删除属性的完整对象写回数据库"
        itemCategoryService.updateById(load);
        //如果有子类,将下级也删除
        String sql = "update item_category set isDelete=1 where pid=" + id;
        itemCategoryService.updateBysql(sql);
        //再返回重新查询页面
        return "redirect:/itemCategory/findBySql.action";
    }


    /**
     * 查看二级分类
     * @param itemCategory
     * @param model
     * @return
     */
    @RequestMapping("/findBySql2")
    public String findBySql2(ItemCategory itemCategory, Model model){
        String sql = "select * from item_category where isDelete=0 and pid=" + itemCategory.getPid() + " order by id";
        //分页查询
        Pager<ItemCategory> pagers = itemCategoryService.findBySqlRerturnEntity(sql);
        model.addAttribute("pagers",pagers);
        model.addAttribute("obj",itemCategory);
        //跳转到二级分类展示
        return "itemCategory/itemCategory2";
    }


    //============================新增二级分类==================================
    /**
     * 转向到新增二级分类页面
     * @return
     */
    @RequestMapping("/add2")
    public String add2(int pid, Model model){
        //再将pid传到新的jsp
        model.addAttribute("pid",pid);
        return "itemCategory/add2";
    }

    /**
     * 新增二级类目保存功能(执行)
     * @param itemCategory "从前端传来的对象"
     * @return
     */
    @RequestMapping("/exAdd2")
    public String exAdd2(ItemCategory itemCategory){
        //未删除
        itemCategory.setIsDelete(0);
        itemCategoryService.insert(itemCategory);
        //直接重定向到本类中的方法:分类查询类目列表,然后经该方法查询后打印列表
        return "redirect:/itemCategory/findBySql2.action?pid="+itemCategory.getPid();
    }



    //============================修改二级分类==================================
    /**
     * 转向到修改二级类目页面
     * @return
     */
    @RequestMapping("/update2")
    public String update2(Integer id,Model model){
        //根据id获取到此完整对象
        ItemCategory obj = itemCategoryService.load(id);
        //将完整对象传回前端
        model.addAttribute("obj",obj);
        return "itemCategory/update2";
    }

    /**
     * 执行修改二级类目
     * @param itemCategory
     * @return
     */
    @RequestMapping("/exUpdate2")
    public String exUpdate2(ItemCategory itemCategory){
        //只要id传过来,其他内容传过来什么改什么
        itemCategoryService.updateById(itemCategory);
        //修改完重新查询打印列表
        return "redirect:/itemCategory/findBySql2.action?pid="+itemCategory.getPid();
    }



    //============================删除二级分类==================================
    /**
     * 删除二级类目(假删除)
     * @param id
     * @return
     */
    @RequestMapping("/delete2")
    public String delete2(Integer id, Integer pid){
        //根据id拿到完整对象
        ItemCategory load = itemCategoryService.load(id);
        //假删除(仅仅将IsDelete属性改为1)
        load.setIsDelete(1);
        //将"带有假删除属性的完整对象写回数据库"
        itemCategoryService.updateById(load);

        //再返回重新查询页面
        return "redirect:/itemCategory/findBySql2.action?pid="+pid;
    }

}
