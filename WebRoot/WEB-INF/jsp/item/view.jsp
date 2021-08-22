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
    <title>(前台)商品详情</title>
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
        <a href="${ctx}/item/shoplist" class="c_66">商品列表</a>
        >
        <a href="#" class="c_66">商品详情</a>
    </div>

    <%--大小图展示--%>
    <div class="width1198 center_yh" style="height: 420px;">
        <div class="left_yh" style="width: 350px;height: 420px;">
            <input type="hidden"  id="id" value="${obj.id}">
            <div id="preview">
                <div>
                    <img src="${obj.url1}" alt="main pic" height="350px" width="350px" id="mainPic">
                </div>
                <div id="spec-list" style="margin-top: 5px;">
                    <ul class="list-h">
                        <li><img src="${obj.url1}" alt="" id="pic1"></li>
                        <li><img src="${obj.url2}" alt="" id="pic2"></li>
                        <li><img src="${obj.url3}" alt="" id="pic3"></li>
                        <li><img src="${obj.url4}" alt="" id="pic4"></li>
                        <li><img src="${obj.url5}" alt="" id="pic5"></li>
                    </ul>
                </div>
            </div>
        </div>
                <div class="left_yh" style="height: 420px;width: 486px;margin-left: 42px">
                    <h3 class="font20 font100">${obj.name}</h3>
                    <p class="font16 c_66" style="margin-top: 25px;">
                        <font style="margin-right: 20px;">价格:</font>
                        <font class="red font20">
                            ￥${obj.price}
                        </font>
                    </p>
                    <c:if test="${obj.zk!=null}">
                        <p class="font16 c_66" style="margin-top: 25px;">
                            <font style="margin-right: 20px;">二手折:</font>
                            <font>
                                ${obj.zk}
                                <span style="color: red">折</span>
                            </font>
                        </p>
                    </c:if>
                    <p class="font16 c_66 likeColor" style="margin-top: 25px;">
                        <font style="margin-right: 20px;">数量</font>
                        <%--默认一件(只提供"加减")--%>
                        <a href="javascript:void(0);" id="min_s">-</a>
                        <input type="text" value="1" readonly id="t_a">
                        <a href="javascript:void(0);" id="add_s">+</a>


                        <font class="font14 c_99" style="margin-left: 20px;">库存:${obj.kcNum}</font>
                    </p>
                    <div class="buyFor">
                        <a href="${ctx}/sc/exAdd?itemId=${obj.id}" class="mstBuy">收藏</a>
                        <a href="javascript:void(0);" class="addCar">加入购物车</a>
                    </div>
                </div>
        </div>
    <%--详情与评价--%>
    <div class="width1200 hidden_yh center_yh" style="margin-top: 40px;">
        <div class="right_yh" style="width: 1200px;">
            <div class="hidden_yh" id="spXqpj">
                <%--默认显示--%>
                <a href="javascript:void(0);" class="on">商品详情</a>
                <a href="javascript:void(0);">商品评价</a>
            </div>

            <div class="width100 hidden_yh">
                <div id="spDetail">
                    ${obj.ms}
                </div>
                <div id="spPj">
                    <%--商品评价(可能有多个用户评价)--%>
                    <div class="width100 hidden_yh" style="padding-bottom: 20px;border-bottom: 1px dashed #ddd;margin-bottom: 10px;">
                        <c:forEach items="${obj.pls}" var="data" varStatus="l">
                            <div style="width: 790px;float: right;overflow: hidden;margin-top: 20px;">
                                <img src="${ctx}/resource/user/images/x.jpg" alt="" style="width: 40px;
                                height: 40px;border-radius: 50%;float: left;border: 1px solid #ddd;margin-top: 20px;margin-right: 30px;">

                                <h3 class="font16 c_33 font100" style="color: red;font-weight: bold;">${data.user.userName}</h3>
                                <%--日期--%>
                                <p class="font14 c_99" style="margin-top: 6px;">
                                    <fmt:formatDate value="${data.addTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                </p>
                                <%--评价内容--%>
                                <p class="font16 c_33" style="margin-top: 6px;" >
                                    ${data.content}
                                </p>
                                <%--间距--%>
                                <div class="width100 hidden_yh" style="padding-bottom: 20px;border-bottom: 1px dashed #ddd;margin-bottom: 10px;"></div>

                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>



    <%@include file="/common/uFooter.jsp"%>

    <script>

        var tr = $("#t_a").val();
        //判断库存
        if (${obj.kcNum} == 0){
            $("#t_a").val(0);
        }

        $("#min_s").click(function () {
            tr--;
            //购买数量不可以小于1
            if (tr < 1 && ${obj.kcNum} != 0) {
                $("#t_a").val(1);
                tr = 1;
            }else if (${obj.kcNum} == 0){
                $("#t_a").val(0);
            } else {
                $("#t_a").val(tr);
            }
        });

        $("#add_s").click(function () {
            tr++;
            //购买数量不能大于库存量
            if (tr > ${obj.kcNum}) {
                $("#t_a").val(${obj.kcNum});
                tr = ${obj.kcNum};
            } else {
                $("#t_a").val(tr);
            }
        });


        //点击事件
        $("#spXqpj a").click(function () {
            $(this).addClass("on").siblings().removeClass("on");
        });
        $("#spXqpj a").eq(0).click(function () {
            $("#spDetail").css({display:"block"}).siblings().css({display:"none"}); //这个显示其他的不显示
        });
        $("#spXqpj a").eq(1).click(function () {
            $("#spPj").css({display:"block"}).siblings().css({display:"none"}); //这个显示其他的不显示
        });




        $(function () {
            $(".addCar").click(function () {
                var id = $("#id").val();
                var num = $("#t_a").val();
                //当前商品已售罄 (售罄收藏功能仍可以使用)
                if (num == 0) {
                    if (confirm("当前商品已售罄,请看看其他商品吧!")) {
                        window.location.href = "${ctx}/item/shoplist";
                    }
                    return false;
                }
                $.ajax({
                    type:"post",
                    url:"${ctx}/car/exAdd?itemId="+id+"&num="+num,
                    success:function (result) {
                        if (result.res == 0) {
                            alert("请先登录");
                            //去登陆
                            window.location.href="${ctx}/login/uLogin";
                        }else {
                            //让用户选择去购物车结算或者继续购物
                            if (confirm("是否前往购物车进行结算?")) {
                                window.location.href = "${ctx}/car/findBySql";
                            } else {
                                window.location.href = "${ctx}/item/shoplist";
                            }

                        }
                    }
                });
            });

            //商品缩略图主副切换
            $("#pic1").click(function () {
                $("#mainPic").attr("src","${obj.url1}");
            });

            $("#pic2").click(function () {
                $("#mainPic").attr("src","${obj.url2}");
            });

            $("#pic3").click(function () {
                $("#mainPic").attr("src","${obj.url3}");
            });

            $("#pic4").click(function () {
                $("#mainPic").attr("src","${obj.url4}");
            });

            $("#pic5").click(function () {
                $("#mainPic").attr("src","${obj.url5}");
            });
        });





    </script>
</body>
</html>
