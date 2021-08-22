package com.Eshop.controller;

import com.Eshop.pojo.Car;
import com.Eshop.pojo.Item;
import com.Eshop.service.CarService;
import com.Eshop.service.ItemService;
import com.Eshop.utils.Consts;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

/**
 * @Description: 购物车Controller层
 * @Author: Liyunhan
 * @Date: 2021/5/7 18:24
 */
@Controller
@RequestMapping("/car")
public class CarController {

    @Autowired
    private CarService carService;

    @Autowired
    private ItemService itemService;

    /**
     * 添加商品到购物车
     *
     * @param car
     * @param request
     * @return
     */
    @RequestMapping("/exAdd")
    @ResponseBody
    public String exAdd(Car car, HttpServletRequest request) {
        JSONObject js = new JSONObject();
        //从session中取得用户的信息
        Object attribute = request.getSession().getAttribute(Consts.USERID);
        if (attribute == null) {
            //0 即是失败 (未登录,不能添加到购物车)
            js.put(Consts.RES,0);
            return js.toJSONString();
        }
        //保存到购物车中
        Integer userId = Integer.valueOf(attribute.toString());
        car.setUserId(userId);
        Item item = itemService.load(car.getItemId());
        String price = item.getPrice();
        Double dPrice = Double.valueOf(price);
        car.setPrice(dPrice);
        if (item.getZk()!=null){
            dPrice = dPrice*item.getZk()/10;
            //精确到分,向上取整
            BigDecimal bigDecimal = new BigDecimal(dPrice).setScale(2, RoundingMode.UP);
            //折后价格
            car.setPrice(bigDecimal.doubleValue());
            dPrice = bigDecimal.doubleValue();
        }

        Integer num = car.getNum();
        //总价格
        Double t = dPrice * num;
        //取整
        BigDecimal bg = new BigDecimal(t).setScale(2, RoundingMode.UP);
        double doubleValue = bg.doubleValue();
        //将总价设置进去
        car.setTotal(doubleValue+"");
        //写入到持久化层
        carService.insert(car);
        js.put(Consts.RES,1);
        return js.toJSONString();
    }

    /**
     * 转向我的购物车页面
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/findBySql")
    public String findBySql(Model model, HttpServletRequest request){
        //从session中取得用户的信息
        Object attribute = request.getSession().getAttribute(Consts.USERID);
        if (attribute == null) {
            return "redirect:/login/toLogin";
        }

        Integer userId = Integer.valueOf(attribute.toString());
        String sql = "select * from car where user_id=" + userId + " order by id desc";
        List<Car> list = carService.listBySqlReturnEntity(sql);
        model.addAttribute("list",list);
        return "car/car";
    }

    /**
     * 删除购物车单件商品
     * @param id
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    public String delete(Integer id){
        carService.deleteById(id);
        return "success";
    }
}

