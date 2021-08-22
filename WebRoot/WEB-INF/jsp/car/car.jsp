<%--
  User: Liyunhan
  Date: 2021/5/3
  Time: 11:33
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--引入标签库(自定义jsp)--%>
<%@include file="/common/taglibs.jsp"%>

<html>
<head>
    <title>我的购物车</title>
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/user/css/style.css">
    <script src="${ctx}/resource/user/js/jquery-1.8.3.min.js"></script>
    <script src="${ctx}/resource/user/js/jquery.luara.0.0.1.min.js"></script>
</head>
<body>
    <%--引入通用头部--%>
    <%@include file="/common/uTop.jsp"%>


    <%--引入通用导航条--%>
    <%@include file="/common/navigationBar.jsp"%>

    <%--"顶部导航"--%>
    <div class="width1200 center_yh hidden_yh font14" style="height: 40px;line-height: 40px;">
        <span>当前位置:</span>
        <a href="${ctx}/login/uIndex" class="c_66">首页</a>
        >
        <a href="#" class="c_66">我的购物车</a>
    </div>
    <%--1.商品数量--%>
    <div class="width1200 hidden_yh center_yh font20">全部商品<font class="red">(${fn:length(list)})</font> </div>

    <%--2.商品详情--%>
    <div class="width1198 hidden_yh center_yh" style="border: 1px solid #ddd;margin-top: 18px;min-height: 300px;">
        <div class="width100 hidden_yh font14" style="height: 32px;line-height: 32px;
        background: #f0f0f0;text-indent: 21px;color: #000;font-weight: 600;border-bottom: 1px solid #ddd;">
            商品详情
        </div>
        <%--表头标题--%>
        <div class="width100 hidden_yh font14" style="height: 42px;line-height: 42px;border-bottom: 1px solid #ddd;">
            <div class="left_yh tcenter font14" style="width: 486px;">商品</div>
            <div class="left_yh tcenter font14" style="width: 175px;">价格</div>
            <div class="left_yh tcenter font14" style="width: 175px;">数量</div>
            <div class="left_yh tcenter font14" style="width: 175px;">小计</div>
            <div class="left_yh tcenter font14" style="width: 175px;">操作</div>
        </div>
        <%--内容--%>
        <c:forEach items="${list}" var="data" varStatus="l">
            <div class="speCific" data-id = "${data.id}">
                <%--选择按钮--%>
                <div class="xzWxz">
                    <b><img src="${ctx}/resource/user/images/xzwxz.png"></b>
                </div>
                <%--商品简图--%>
                <div class="xzSp">
                    <img src="${data.item.url1}" alt="">
                    <div class="xzSpIn">
                        <h3 class="font16 c_33 font100">${data.item.name}</h3>
                    </div>
                </div>
                <%--商品价格--%>
                <div class="xzJg">
                    ￥<font>${data.price}</font>
                </div>
                <%--数量控制--%>
                <div class="xzSl">
                    <div class="xzSlIn">
                        <input type="text" value="${data.num}" readonly class="cont" style="margin-left: 25px;">
                    </div>
                </div>
                <%--小计--%>
                <div class="xzXj">￥<font></font></div>
                <%--操作--%>
                <div class="xzCz">
                    <div class="xzCzIn">
                        <a href="javascript:void(0);" class="Dels" data-id="${data.id}" style="text-align: center;">删除</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="width1198 center_yh" style="height: 60px; background: #f0f0f0;border: 1px solid #ddd;margin-top: 40px;">
        <div class="center_yh hidden_yh" style="width: 1178px;height: 60px;margin-left: 20px;">
            <%--"全选"功能--%>
            <div class="ifAll"><b><img src="${ctx}/resource/user/images/xzwxz.png"></b><font>全选</font></div>


            <div class="ifDel">删除选中</div>
            <div class="sXd">
                <div class="sXd1">已选商品(<font style="color: #cb1c20;">0</font> )</div>
                <div class="sXd2">合计(不含运费):￥<font style="color: #cb1c20;" id="zjJg">0</font> </div>
                <a href="javascript:void(0)" class="ifJs" onclick="ifJs()">结算</a>
            </div>
        </div>
    </div>




    <%@include file="/common/uFooter.jsp"%>

<script>
    //总商品(子项)数量
    var es = $(".speCific").length;
    (function cx() {
        for (var a = 0; a < es; a++) {
            //(eq(a):对循环每一次的第a个jq对象进行操作)
            var lt = $(".xzJg").eq(a).find("font").html();
            var num = $(".xzSl").eq(a).find("input").val();
            var xj = lt*num;
            $(".xzXj").eq(a).find("font").html(sswr(xj));
        }
    })();

    //选择对勾框点击事件
    $(".xzWxz").click(function () {
        if ($(this).hasClass("on")){
            $(this).removeClass("on");

        } else {
            $(this).addClass("on");
        }
        //"打勾了的"数量
        var ty = $(".xzWxz.on").length;
        //给class sXd1内的font赋值
        $(".sXd1").find("font").html(ty);

        //如果ty = "商品的数量",则全选按钮勾上
        if (ty==es){
            $(".ifAll").addClass("on");
        } else {
            $(".ifAll").removeClass("on");
        }
        jsZj();
    });

    //计算总计
    function jsZj() {
        var total = 0;
        $(".xzWxz.on").each(function () {
            var price = $(this).parent().find(".xzJg").find("font").html();
            var num = $(this).parent().find(".xzSl").find("input").val();
            total += num*price;
        });
        //设置总价格
        $("#zjJg").html(sswr(total));
    }

    //保留两位小数函数
    function sswr(num) {
        return num.toFixed(2);
    }

    //全选按钮事件
    $(".ifAll").click(function () {
        //如果已经选中了,那就取消选中
        if ($(".ifAll").hasClass("on")) {
            $(".ifAll").removeClass("on");
            $(".xzWxz").removeClass("on");
            $(".sXd1").find("font").html(0);
        }else {
            $(".ifAll").addClass("on");
            $(".xzWxz").addClass("on");
            $(".sXd1").find("font").html(es);
        }
        jsZj();
    });

    //单项商品删除事件控制
    $(".Dels").click(function () {
       var id = $(this).attr("data-id");
       $.ajax({
           type:"post",
           url:"${ctx}/car/delete?id="+id,
           contentType:"application/json",
           success:function (result) {
           }
       });
        alert("删除成功");
        $(this).parent().parent().parent().remove();
        jsZj();
    });

    //删除选中功能(批量删除)
    $(".ifDel").click(function () {
        $(".xzWxz.on").each(function () {
            var id = $(this).parent().attr("data-id");
            $.ajax({
                type:"post",
                url:"${ctx}/car/delete?id="+id,
                contentType:"application/json",
                success:function (result) {
                }
            });
        });

        alert("删除成功");
        $(".xzWxz.on").parent().remove();
        jsZj();
    });


    //结算功能:一个用户(账户)不论多少商品都有一个订单号(item_order),然后可以有多个order_detail (结算后相应商品库存要减少)
    function ifJs() {
        var arr = new Array();
        $(".xzWxz.on").each(function () {
            var $id = $(this).parent().attr("data-id");
            var $num = $(this).parent().find(".xzSl").find("input").val();
            var obj = new Object();
            obj.id = $id;
            obj.num = $num;
            arr.push(obj);
        });
        if (arr.length == 0) {
            alert("请至少选择一件商品进行结算！");
            return false;
        }
        $.ajax({
           type:"post",
           url:"${ctx}/itemOrder/exAdd",
           data:JSON.stringify(arr),
           contentType:"application/json",
           success:function (result) {
               if (result.res == 0) {
                   alert("请先登录");
                   window.location.href="${ctx}/login/uLogin";
               }else if (result.res == 2) {
                   alert("请编辑收货地址");
               }else {
                   alert("购买成功!");
                   window.location.reload();
               }
           }
        });
    }
</script>

</body>
</html>
