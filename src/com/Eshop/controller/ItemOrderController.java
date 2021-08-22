package com.Eshop.controller;

import com.Eshop.base.BaseController;
import com.Eshop.pojo.*;
import com.Eshop.service.*;
import com.Eshop.utils.Consts;
import com.Eshop.utils.Pager;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @Description: 订单管理
 * @Author: Liyunhan
 * @Date: 2021/5/4 17:23
 */
@Controller
@RequestMapping("/itemOrder")
public class ItemOrderController extends BaseController {

    @Autowired
    private ItemOrderService itemOrderService;

    @Autowired
    private UserService userService;

    @Autowired
    private CarService carService;

    @Autowired
    private OrderDetailService orderDetailService;

    @Autowired
    private ItemService itemService;

    /**
     * 展示订单管理列表
     *
     * @param itemOrder
     * @param model
     * @return
     */
    @RequestMapping("/findBySql")
    public String findBySql(ItemOrder itemOrder, Model model) {
        //分页+模糊查询
        String sql = "select * from item_order where 1=1 ";
        if (!isEmpty(itemOrder.getCode())) {
            sql += " and code like '%" + itemOrder.getCode() + "%' ";
        }
        sql += " order by id desc";

        Pager<ItemOrder> pagers = itemOrderService.findBySqlRerturnEntity(sql);
        //将分页结果对象放到model里面传回前端
        model.addAttribute("pagers",pagers);
        //存储查询条件
        model.addAttribute("obj",itemOrder);

        return "itemOrder/itemOrder";
    }

    /**
     * 我的订单
     *
     * @param model
     * @param request
     * @return
     */

    @RequestMapping("/myOrder")
    public String my(Model model, HttpServletRequest request) {
        //从session获取用户信息
        Object attribute = request.getSession().getAttribute(Consts.USERID);
        if (attribute == null) {
            return "redirect:/login/uLogin";
        }
        Integer userId = Integer.valueOf(attribute.toString());
        //依次拿到顶部导航栏的每个列表
        //主键也是按时间(事件)先后顺序排序的(自增的)
        String sql1 = "select * from item_order where user_id=" + userId + " order by id desc";
        //拿到全部订单列表
        List<ItemOrder> all = itemOrderService.listBySqlReturnEntity(sql1);

        //待发货订单
        String sql2 = "select * from item_order where user_id=" + userId + " and status=0 order by id desc";
        //拿到全部待发货订单列表
        List<ItemOrder> dfh = itemOrderService.listBySqlReturnEntity(sql2);

        //已取消订单
        String sql3 = "select * from item_order where user_id=" + userId + " and status=1 order by id desc";
        //拿到全部已取消订单列表
        List<ItemOrder> yqx = itemOrderService.listBySqlReturnEntity(sql3);

        //已发货(待收货)订单
        String sql4 = "select * from item_order where user_id=" + userId + " and status=2 order by id desc";
        //拿到全部已发货订单列表
        List<ItemOrder> dsh = itemOrderService.listBySqlReturnEntity(sql4);

        //已收货订单
        String sql5 = "select * from item_order where user_id=" + userId + " and status=3 order by id desc";
        //拿到全部已发货订单列表
        List<ItemOrder> ysh = itemOrderService.listBySqlReturnEntity(sql5);

        model.addAttribute("all", all);
        model.addAttribute("dfh", dfh);
        model.addAttribute("dsh", dsh);
        model.addAttribute("yqx", yqx);
        model.addAttribute("ysh", ysh);


        return "itemOrder/myOrder";
    }


    /**
     * 执行购买操作  (借助CarDto 方便spring封装前端数据)
     * @param list
     * @param request
     * @return
     */
    @RequestMapping("/exAdd")
    @ResponseBody
    public String exAdd(@RequestBody List<CarDto> list, HttpServletRequest request) {
        //从session获取用户信息
        Object attribute = request.getSession().getAttribute(Consts.USERID);
        JSONObject js = new JSONObject();
        if (attribute == null) {
            js.put(Consts.USERID, 0);
            return js.toJSONString();
        }
        Integer userId = Integer.valueOf(attribute.toString());
        User byId = userService.getById(userId);
        if (StringUtils.isEmpty(byId.getAddress())) {
            js.put(Consts.RES, 2);
            return js.toJSONString();
        }
        ArrayList<Integer> ids = new ArrayList<>();
        //设置金额为两位小数,使用BigDecimal
        BigDecimal to = new BigDecimal(0);
        for (CarDto c :
                list) {
            ids.add(c.getId());
            Car load = carService.getById(c.getId());
            //相应商品库存减少
            Item item = load.getItem();
            item.setKcNum(item.getKcNum() - c.getNum());
            itemService.updateById(item);
            //Bigdecimal有自己的特有方法
            to = to.add(new BigDecimal(load.getPrice()).multiply(new BigDecimal(c.getNum())));
        }
        ItemOrder order = new ItemOrder();
        //已购买未发货,生成订单信息(这里一次购买多件商品生成一个订单号(算作一次交易))
        order.setStatus(0);
        order.setCode(getOrderNo());
        order.setIsDelete(0);
        //注意,bigDecimal需要截断
        order.setTotal(to.setScale(2,BigDecimal.ROUND_HALF_UP).toString());
        order.setUserId(userId);
        order.setAddTime(new Date());
        itemOrderService.insert(order);
        //在购物车里删掉 & 订单详情放入OrderDetail(插入订单详情表)
        if (!CollectionUtils.isEmpty(ids)){
            for (CarDto c :
                    list) {
                Car load = carService.load(c.getId());
                OrderDetail de = new OrderDetail();
                de.setItemId(load.getItemId());
                //insert时会自动生成id,所以是可以获取到的
                de.setOrderId(order.getId());
                de.setStatus(0);
                de.setNum(c.getNum());
                de.setTotal(String.valueOf(c.getNum()*load.getPrice()));
                orderDetailService.insert(de);
                //修改成交数量
                Item load2 = itemService.load(load.getItemId());
                load2.setGmNum(load2.getGmNum()+c.getNum());
                itemService.updateById(load2);
                //删除购物车
                carService.deleteById(c.getId());
            }
        }
        js.put(Consts.RES,1);
        return js.toJSONString();
    }

    //这些操作都是改状态
    /**
     * 取消订单
     * (减少的商品库存加回去)
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("/qx")
    public String qx(Integer id, Model model){
        ItemOrder obj = itemOrderService.getById(id);
        obj.setStatus(1);
        //补回库存
        List<OrderDetail> details = obj.getDetails();
        for (OrderDetail detail :
                details) {
            Item item = detail.getItem();
            item.setKcNum(item.getKcNum() + detail.getNum());
            itemService.updateById(item);
        }
        itemOrderService.updateById(obj);
        model.addAttribute("obj",obj);
        return "redirect:/itemOrder/myOrder";
    }

    /**
     * 管理员发货
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("/fh")
    public String fh(Integer id, Model model){
        ItemOrder obj = itemOrderService.load(id);
        obj.setStatus(2);
        itemOrderService.updateById(obj);
        model.addAttribute("obj",obj);
        return "redirect:/itemOrder/findBySql.action";
    }

    /**
     * 用户收货(确认收货)
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("/sh")
    public String sh(Integer id, Model model){
        ItemOrder obj = itemOrderService.load(id);
        obj.setStatus(3);
        itemOrderService.updateById(obj);
        model.addAttribute("obj",obj);
        return "redirect:/itemOrder/myOrder";
    }

    /**
     * 转向评价页面
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("/pj")
    public String pj(Integer id, Model model){
        model.addAttribute("id",id);
        return "itemOrder/pj";
    }


    private static String date;
    private static long orderNum = 0L;

    /**
     * 工具类 生成订单号(前面是时间)
     * @return
     */
    private static synchronized String getOrderNo() {
        String str = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
        if (date == null || date.equals(str)){
            date = str;
            orderNum = 0L;
        }
        orderNum++;
        long orderNO = Long.parseLong(date) * 10000;
        //组合起来
        orderNO += orderNum;
        return orderNO+"";
    }
}
