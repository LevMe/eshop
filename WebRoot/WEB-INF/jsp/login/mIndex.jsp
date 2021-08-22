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
    <title>管理员后台主页</title>
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/css/pintuer.css">
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/css/admin.css">
    <script src="${ctx}/resource/js/jquery.js"></script>
    <script src="${ctx}/resource/js/pintuer.js"></script>
</head>
<%--背景色--%>
<body style="background-color: #f2f9fd">
    <div class="header bg-main">
        <%--顶部页面标题--%>
        <div class="logo margin-big-left fadein-top">
            <h1>Eshop后台管理</h1>
        </div>

        <div class="head-l">
            <a class="button button-little bg-green" href="${ctx}/login/uIndex" >
                <%--小房子图标--%>
                <span class="icon-home">前台首页</span>
            </a>

            <a class="button button-little bg-red" href="javascript:confirmExit();" >
                <%--退出登录图标--%>
                <span class="icon-power-off">退出登录</span>
            </a>
        </div>
    </div>

    <%--左侧navigation: **主要业务** --%>
    <div class="leftnav">
        <div class="leftnav-title">
            <span class="icon-list">菜单列表</span>
        </div>

        <h2><span class="icon-user">基本设置</span></h2>
        <ul style="display: block">
            <%--目标展示位置都对应right(target),对应下面的iframe(内置窗口)--%>
            <li>
                <a href="${ctx}/itemCategory/findBySql" target="right">
                    <span class="icon-caret-right">类目管理</span>
                </a>
            </li>

            <li>
                 <a href="${ctx}/user/findBySql" target="right">
                     <span class="icon-caret-right">用户管理</span>
                 </a>
            </li>

            <li>
                <a href="${ctx}/item/findBySql" target="right">
                    <span class="icon-caret-right">商品管理</span>
                </a>
            </li>

            <li>
                <a href="${ctx}/itemOrder/findBySql" target="right">
                    <span class="icon-caret-right">订单管理</span>
                </a>
            </li>

            <li>
                <a href="${ctx}/news/findBySql" target="right">
                    <span class="icon-caret-right">帮助管理</span>
                </a>
            </li>

            <li>
                <a href="${ctx}/message/findBySql" target="right">
                    <span class="icon-caret-right">留言管理</span>
                </a>
            </li>
        </ul>
    </div>


    <%--右侧:左侧功能展示--%>
    <%--"iframe 顶部home键"--%>
    <ul class="bread">
        <li>
            <a href="${ctx}/login/toLogin" class="icon-home">首页</a>
        </li>

        <li>
            <a href="${ctx}/login/info" target="right">网站信息</a>
        </li>

        <li>
            <b>当前语言:</b>
            <span style="color: red">中文</span>
        <%--实际上不支持切换语言--%>
        &nbsp;&nbsp;&nbsp;&nbsp;切换语言:<a href="#">中文</a>&nbsp;&nbsp;<a href="#">English</a>
        </li>
    </ul>

    <div class="admin">
        <%--一页展示不下自动调用滚轮--%>
        <iframe name="right" scrolling="auto" frameborder="0" width="100%" height="100%"></iframe>
    </div>
</body>

<script>
    function confirmExit() {
        if (confirm("确认要退出吗?")) {
            window.location.href = "${ctx}/login/mExit";
        }
    }
</script>
</html>
