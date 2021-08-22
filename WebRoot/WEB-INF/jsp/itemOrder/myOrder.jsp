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
    <title>首页</title>
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
        <a href="#" class="c_66">个人中心</a>
        >
        <a href="#" class="c_66">我的订单</a>
    </div>


    <div class="width100 hidden_yh" style="background: #f0f0f0;padding-top: 34px;padding-bottom: 34px;">
        <%--左侧部分--%>
        <div class="width1200 hidden_yh center_yh">
            <div id="vipNav">
                <a href="${ctx}/user/view" >个人信息</a>
                <a href="${ctx}/itemOrder/myOrder" class="on">我的订单</a>
                <a href="${ctx}/sc/findBySql" >我的收藏</a>
                <a href="${ctx}/login/updatePassword" >修改密码</a>
            </div>
        <%--右侧内容--%>
            <div id="vipRight">
                <div style="width: 938px;border: 1px solid #ddd;background: #fff;">
                    <div class="width100 hidden_yh" style="height: 74px;line-height: 74px;background: #f5f8fa;border-bottom: 1px solid #ddd;" id="navLt">
                        <%--顶部nav(默认展示全部订单) (length计算数量)--%>
                        <span class="left_yh font20 width20 tcenter cursor onHover onorange select">全部订单(${fn:length(all)})</span>
                        <span class="left_yh font20 width20 tcenter cursor onHover onorange ">已取消(${fn:length(yqx)})</span>
                        <span class="left_yh font20 width20 tcenter cursor onHover onorange ">待发货(${fn:length(dfh)})</span>
                        <span class="left_yh font20 width20 tcenter cursor onHover onorange ">待收货(${fn:length(dsh)})</span>
                        <span class="left_yh font20 width20 tcenter cursor onHover onorange ">已收货(${fn:length(ysh)})</span>
                    </div>
                    <%--1.全部订单--%>
                    <%--默认展示全部订单内容,其他菜单项不展示--%>
                    <div class="allGoods width100 hidden_yh hhD" style="display: block;">
                        <c:forEach items="${all}" var="data" varStatus="l">
                            <div class="width100 hidden_yh font18 c_66" style="background: #faf5f5;text-indent: 47px;height: 50px;line-height: 50px;border-bottom: 1px solid #ddd;">
                                <fmt:formatDate value="${data.addTime}" type="both"/>&nbsp;&nbsp;订单号${data.code}&nbsp;&nbsp;
                                <c:if test="${data.status == 0}">待发货</c:if>
                                <c:if test="${data.status == 1}">已取消</c:if>
                                <c:if test="${data.status == 2}">待收货</c:if>
                                <c:if test="${data.status == 3}">已收货</c:if>
                            </div>
                            <%--遍历订单详情--%>
                            <c:forEach items="${data.details}" var="chil" varStatus="l">
                                <div style="width: 838px;border-bottom: 1px dashed #ddd;padding-top: 30px;padding-bottom: 30px;" class="hidden_yh center_yh">
                                    <%--商品缩略图--%>
                                    <img src="${chil.item.url1}" alt="" width="100" height="100" class="left_yh" style="padding-right: 10px;">
                                    <%--商品描述信息--%>
                                    <div class="left_yh" style="width: 580px;">
                                        <h3 class="font18 c_33 font100">${chil.item.name}</h3>
                                        <p class="c_66 font16" style="margin-top: 16px;">折扣:${chil.item.zk}</p>
                                        <p class="red" style="margin-top: 10px;">￥${chil.item.price}</p>
                                    </div>

                                    <div class="right_yh">
                                        <%--判断商品状态,已收货后可以评价--%>
                                        <c:if test="${data.status == 3}">
                                            <a href="${ctx}/itemOrder/pj?id=${chil.itemId}" class="onfff block_yh tcenter font16 onHover" style="margin-top: 10px;margin-right: 6px;">
                                                去评价
                                            </a>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>

                            <div style="width: 838px;padding-top: 30px;padding-bottom: 30px;" class="hidden_yh center_yh tleft">
                                <font class="font20">总金额</font>
                                <font class="font24 red">￥${data.total}</font>
                                <%--判断商品状态,未发货用户可以取消订单--%>
                                <c:if test="${data.status == 0}">
                                    <a href="javascript:confirmQx(${data.id});" class="c_33 onHover font20 onorange right_yh" style="margin-top: 10px;margin-right: 6px;">
                                        取消订单
                                    </a>
                                </c:if>
                                <%--判断商品状态,已取消直接显示信息供用户查看,不做其他操作--%>
                                <c:if test="${data.status == 1}">
                                    <a href="#" class="c_33 onHover font18 onorange right_yh" style="margin-top: 10px;margin-right: 6px;">
                                        已取消
                                    </a>
                                </c:if>
                                <%--判断商品状态,确认收货--%>
                                <c:if test="${data.status == 2}">
                                    <a href="javascript:confirmSh(${data.id});" class="c_33 onHover font18 onorange right_yh" style="margin-top: 10px;margin-right: 6px;">
                                        确认收货
                                    </a>
                                </c:if>
                                    <%--判断商品状态,已收货--%>
                                <c:if test="${data.status == 3}">
                                    <a href="#" class="c_33 onHover font18 onorange right_yh" style="margin-top: 10px;margin-right: 6px;">
                                        交易已完成
                                    </a>
                                </c:if>

                            </div>
                        </c:forEach>
                    </div>


                    <%--2.已取消订单(仅展示)--%>
                    <div class="allGoods width100 hidden_yh hhD" style="display: none;">
                        <c:forEach items="${yqx}" var="data" varStatus="l">
                            <div class="width100 hidden_yh font18 c_66" style="background: #faf5f5;text-indent: 47px;height: 50px;line-height: 50px;border-bottom: 1px solid #ddd;">
                                <fmt:formatDate value="${data.addTime}" type="both"/>&nbsp;&nbsp;订单号${data.code}&nbsp;&nbsp;
                                <c:if test="${data.status == 0}">待发货</c:if>
                                <c:if test="${data.status == 1}">已取消</c:if>
                                <c:if test="${data.status == 2}">待收货</c:if>
                                <c:if test="${data.status == 3}">已收货</c:if>
                            </div>
                            <%--遍历订单详情--%>
                            <c:forEach items="${data.details}" var="chil" varStatus="l">
                                <div style="width: 838px;border-bottom: 1px dashed #ddd;padding-top: 30px;padding-bottom: 30px;" class="hidden_yh center_yh">
                                        <%--商品缩略图--%>
                                    <img src="${chil.item.url1}" alt="" width="100" height="100" class="left_yh" style="padding-right: 10px;">
                                        <%--商品描述信息--%>
                                    <div class="left_yh" style="width: 580px;">
                                        <h3 class="font18 c_33 font100">${chil.item.name}</h3>
                                        <p class="c_66 font16" style="margin-top: 16px;">折扣:${chil.item.zk}</p>
                                        <p class="red" style="margin-top: 10px;">￥${chil.item.price}</p>
                                    </div>
                                </div>
                            </c:forEach>

                            <div style="width: 838px;padding-top: 30px;padding-bottom: 30px;" class="hidden_yh center_yh tleft">
                                <font class="font20">总金额</font>
                                <font class="font24 red">￥${data.total}</font>

                            </div>
                        </c:forEach>
                    </div>


                    <%--3.待发货--%>
                    <div class="allGoods width100 hidden_yh hhD" style="display: none;">
                        <c:forEach items="${dfh}" var="data" varStatus="l">
                            <div class="width100 hidden_yh font18 c_66" style="background: #faf5f5;text-indent: 47px;height: 50px;line-height: 50px;border-bottom: 1px solid #ddd;">
                                <fmt:formatDate value="${data.addTime}" type="both"/>&nbsp;&nbsp;订单号${data.code}&nbsp;&nbsp;
                                <c:if test="${data.status == 0}">待发货</c:if>
                                <c:if test="${data.status == 1}">已取消</c:if>
                                <c:if test="${data.status == 2}">待收货</c:if>
                                <c:if test="${data.status == 3}">已收货</c:if>
                            </div>
                            <%--遍历订单详情--%>
                            <c:forEach items="${data.details}" var="chil" varStatus="l">
                                <div style="width: 838px;border-bottom: 1px dashed #ddd;padding-top: 30px;padding-bottom: 30px;" class="hidden_yh center_yh">
                                        <%--商品缩略图--%>
                                    <img src="${chil.item.url1}" alt="" width="100" height="100" class="left_yh" style="padding-right: 10px;">
                                        <%--商品描述信息--%>
                                    <div class="left_yh" style="width: 580px;">
                                        <h3 class="font18 c_33 font100">${chil.item.name}</h3>
                                        <p class="c_66 font16" style="margin-top: 16px;">折扣:${chil.item.zk}</p>
                                        <p class="red" style="margin-top: 10px;">￥${chil.item.price}</p>
                                    </div>
                                </div>
                            </c:forEach>

                            <div style="width: 838px;padding-top: 30px;padding-bottom: 30px;" class="hidden_yh center_yh tleft">
                                <font class="font20">总金额</font>
                                <font class="font24 red">￥${data.total}</font>
                                    <%--未发货用户可以取消订单--%>
                                    <a href="javascript:confirmQx(${data.id});" class="c_33 onHover font18 onorange right_yh" style="margin-top: 10px;margin-right: 6px;">
                                        取消订单
                                    </a>
                            </div>
                        </c:forEach>
                    </div>


                    <%--4.待收货--%>
                    <div class="allGoods width100 hidden_yh hhD" style="display: none;">
                        <c:forEach items="${dsh}" var="data" varStatus="l">
                            <div class="width100 hidden_yh font18 c_66" style="background: #faf5f5;text-indent: 47px;height: 50px;line-height: 50px;border-bottom: 1px solid #ddd;">
                                <fmt:formatDate value="${data.addTime}" type="both"/>&nbsp;&nbsp;订单号${data.code}&nbsp;&nbsp;
                                <c:if test="${data.status == 0}">待发货</c:if>
                                <c:if test="${data.status == 1}">已取消</c:if>
                                <c:if test="${data.status == 2}">待收货</c:if>
                                <c:if test="${data.status == 3}">已收货</c:if>
                            </div>
                            <%--遍历订单详情--%>
                            <c:forEach items="${data.details}" var="chil" varStatus="l">
                                <div style="width: 838px;border-bottom: 1px dashed #ddd;padding-top: 30px;padding-bottom: 30px;" class="hidden_yh center_yh">
                                        <%--商品缩略图--%>
                                    <img src="${chil.item.url1}" alt="" width="100" height="100" class="left_yh" style="padding-right: 10px;">
                                        <%--商品描述信息--%>
                                    <div class="left_yh" style="width: 580px;">
                                        <h3 class="font18 c_33 font100">${chil.item.name}</h3>
                                        <p class="c_66 font16" style="margin-top: 16px;">折扣:${chil.item.zk}</p>
                                        <p class="red" style="margin-top: 10px;">￥${chil.item.price}</p>
                                    </div>

                                </div>
                            </c:forEach>

                            <div style="width: 838px;padding-top: 30px;padding-bottom: 30px;" class="hidden_yh center_yh tleft">
                                <font class="font20">总金额</font>
                                <font class="font24 red">￥${data.total}</font>
                                    <%--待收货状态商品可以确认收货--%>
                                    <a href="javascript:confirmSh(${data.id});" class="c_33 onHover font18 onorange right_yh" style="margin-top: 10px;margin-right: 6px;">
                                        确认收货
                                    </a>
                            </div>
                        </c:forEach>
                    </div>


                    <%--5.已收货--%>
                    <div class="allGoods width100 hidden_yh hhD" style="display: none;">
                        <c:forEach items="${ysh}" var="data" varStatus="l">
                            <div class="width100 hidden_yh font18 c_66" style="background: #faf5f5;text-indent: 47px;height: 50px;line-height: 50px;border-bottom: 1px solid #ddd;">
                                <fmt:formatDate value="${data.addTime}" type="both"/>&nbsp;&nbsp;订单号${data.code}&nbsp;&nbsp;
                                <c:if test="${data.status == 0}">待发货</c:if>
                                <c:if test="${data.status == 1}">已取消</c:if>
                                <c:if test="${data.status == 2}">待收货</c:if>
                                <c:if test="${data.status == 3}">已收货</c:if>
                            </div>
                            <%--遍历订单详情--%>
                            <c:forEach items="${data.details}" var="chil" varStatus="l">
                                <div style="width: 838px;border-bottom: 1px dashed #ddd;padding-top: 30px;padding-bottom: 30px;" class="hidden_yh center_yh">
                                        <%--商品缩略图--%>
                                    <img src="${chil.item.url1}" alt="" width="100" height="100" class="left_yh" style="padding-right: 10px;">
                                        <%--商品描述信息--%>
                                    <div class="left_yh" style="width: 580px;">
                                        <h3 class="font18 c_33 font100">${chil.item.name}</h3>
                                        <p class="c_66 font16" style="margin-top: 16px;">折扣:${chil.item.zk}</p>
                                        <p class="red" style="margin-top: 10px;">￥${chil.item.price}</p>
                                    </div>

                                    <div class="right_yh">
                                            <%--判断商品状态,已收货后可以评价--%>
                                        <c:if test="${data.status == 3}">
                                            <a href="${ctx}/itemOrder/pj?id=${chil.itemId}" class="onfff block_yh tcenter font16 onHover" style="margin-top: 10px;margin-right: 6px;">
                                                去评价
                                            </a>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>

                            <div style="width: 838px;padding-top: 30px;padding-bottom: 30px;" class="hidden_yh center_yh tleft">
                                <font class="font20">总金额</font>
                                <font class="font24 red">￥${data.total}</font>
                                    <%--判断商品状态,已收货--%>
                                    <a href="#" class="c_33 onHover font18 onorange right_yh" style="margin-top: 10px;margin-right: 6px;">
                                        交易已完成
                                    </a>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

        </div>
    </div>




    <%@include file="/common/uFooter.jsp"%>
    <%--切换顶部菜单--%>
    <script>
        $("#navLt span").click(function () {
           var t = $(this).index();
           $(this).addClass("select").siblings().removeClass("select");
           //切换
           $(".hhD").eq(t).css({display:"block"}).siblings(".hhD").css({display:"none"});
        });


        //确认收货
        function confirmSh(id) {
            if (confirm("您要确认收货吗,请确保收到货后进行操作!")) {
                alert("Eshop: 感谢您的支持!");
                window.location.href = "${ctx}/itemOrder/sh?id="+id;
            }
        }

        //取消订单
        function confirmQx(id) {
            if (confirm("您确认要取消此订单吗,取消后无法恢复!")) {
                window.location.href = "${ctx}/itemOrder/qx?id="+id;
            }
        }
    </script>

</body>
</html>
