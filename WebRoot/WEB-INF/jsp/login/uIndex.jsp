<%--
  User: Liyunhan
  Date: 2021/5/3
  Time: 11:33
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--引入标签库(自定义jsp)--%>
<%@include file="/common/taglibs.jsp"%>

<%--前台主页--%>
<html>
<head>
    <title>首页</title>
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/user/css/style.css">
    <script src="${ctx}/resource/user/js/jquery-1.8.3.min.js"></script>
    <script src="${ctx}/resource/user/js/jquery.luara.0.0.1.min.js"></script>
</head>
<body background="${ctx}/resource/images/uIndexBg.png" style="background-attachment: fixed;background-repeat: no-repeat">

<%--<div class="ubg"></div>--%>
    <%--引入通用头部--%>
    <%@include file="/common/uTop.jsp"%>


    <%--主题色 #ff8603--%>
    <%--导航条--%>
    <div class="width100" style="height: 45px;background: #ffc900;margin-top: 40px;position: relative;z-index: 100;">
        <%--中间的部分--%>
        <div class="width1200 center_yh relative_yh" style="height: 45px;">

            <%--1.列表导航--%>
            <div class="left_yh Selected" style="width: 230px;height: 45px;" id="hiddenShow">
                <%--头部图标--%>
                <img src="${ctx}/resource/user/images/cd.png" class="left_yh" style="margin-left: 24px;"/>
                <span class="block_yh left_yh fff" style="height: 45px;line-height: 44px;margin-left: 10px;color: black;">分类</span>
                <%--导航展开部分--%>
                <div class="downSlide">
                    <c:forEach items="${lbs}" var="data" varStatus="l">
                        <div class="n1Nav">
                            <font>${data.father.name}</font>
                            <img src="${ctx}/resource/user/images/jt.png">
                            <%--二级分类--%>
                            <div class="n2Nav">
                                <div class="n3Nav">
                                    <h3>${data.father.name}</h3>
                                    <c:forEach items="${data.childrens}" var="child" varStatus="ll">
                                        <a href="${ctx}/item/shoplist?categoryIdTwo=${child.id}">${child.name}</a>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <%--2.普通导航--%>
            <div class="left_yh font16" id="pageNav">
                <a href="${ctx}/login/uIndex"><font style="color: black;">首页</font></a>
                <a href="${ctx}/item/shoplist"><font style="color: black;">全部商品</font></a>
                <a href="${ctx}/news/list"><font style="color: black;">帮助服务</font></a>
                <a href="${ctx}/message/add"><font style="color: black;">反馈建议</font></a>
            </div>
        </div>

    </div>

    <%--轮播广告 使用jQuery luara制作滑动效果--%>
    <div class="width1200 center_yh hidden_yh" style="position: relative;z-index: 80;">
        <div class="example2" style="width: 1200px;height: 490px;overflow: hidden;margin-left: 230px">
            <ul>
                <li><img src="${ctx}/resource/images/banner2.png"></li>
                <li><img src="${ctx}/resource/images/banner1.png"></li>
                <li><img src="${ctx}/resource/images/banner3.png"></li>
                <li><img src="${ctx}/resource/images/banner4.png"></li>
            </ul>
        </div>
    </div>

    <script>
        $(function () {
            $(".example2").luara({width:"966",height:"490",interval:"4500",selected:"selected",deriction:"left"});
        });
    </script>

    <%--本店主营:二手笔记本电脑--%>
    <div class="width1200 center_yh hidden_yh">
        <div class="width100" style="height: 45px;line-height: 45px;border-bottom: 2px solid #dd4545; margin-top: 20px;">
            <font class="left_yh font20"><img src="${ctx}/resource/images/Icon2_laptop.png" style="display: inline;margin-bottom: -4px;">
                本店主营:二手笔记本电脑</font>
        </div>

        <div class="width100 hidden_yh" style="height: 480px;">
            <div class="normalPic">
                <c:forEach items="${nb}" var="data" varStatus="l">
                    <a href="${ctx}/item/view?id=${data.id}">
                        <img src="${data.url1}" alt="" width="145" height="150" style="margin: 0 auto">
                        <h3 class="yihang c_33 font14 font100" style="text-align: center;">${data.name}</h3>
                        <%--价格红色显示--%>
                        <p class="red font14" style="text-align: center;">￥${data.price}</p>
                    </a>
                </c:forEach>
            </div>
        </div>
    </div>


    <%--其他商品--%>
    <div class="width1200 center_yh hidden_yh">
        <div class="width100" style="height: 45px;line-height: 45px;border-bottom: 2px solid #dd4545; margin-top: 20px;">
            <font class="left_yh font20"><img src="${ctx}/resource/images/Icon1_favorite.png" style="display: inline;margin-bottom: -4px;">
                其他商品</font>
        </div>

        <div class="width100 hidden_yh" style="height: 480px;">
            <div class="normalPic">
                <c:forEach items="${ot}" var="data" varStatus="l">
                    <a href="${ctx}/item/view?id=${data.id}">
                        <img src="${data.url1}" alt="" width="145" height="150" style="margin: 0 auto">
                        <h3 class="yihang c_33 font14 font100" style="text-align: center;">${data.name}</h3>
                            <%--价格红色显示--%>
                        <p class="red font14" style="text-align: center;">￥${data.price}</p>
                    </a>
                </c:forEach>
            </div>
        </div>
    </div>

    <%--引入底部--%>
    <%@include file="/common/uFooter.jsp"%>
</body>
</html>
