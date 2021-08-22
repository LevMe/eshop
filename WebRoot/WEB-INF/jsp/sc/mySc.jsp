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
    <title>我的收藏</title>
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
        <a href="#" class="c_66">我的收藏</a>
    </div>

    <%--左侧部分--%>
    <div class="width1200 hidden_yh center_yh">
        <div id="vipNav">
            <a href="${ctx}/user/view" >个人信息</a>
            <a href="${ctx}/itemOrder/myOrder">我的订单</a>
            <a href="${ctx}/sc/findBySql" class="on">我的收藏</a>
            <a href="${ctx}/login/updatePassword" >修改密码</a>
        </div>
        <%--右侧内容--%>
        <div id="vipRight">
            <div class="hidden_yh bj_fff" style="width: 938px;border: 1px solid #ddd;">
                <div class="width100 font24" style="height: 60px;line-height: 60px;text-indent: 50px;background: #f5f8fa;border-bottom: 1px solid #ddd;">
                    最近收藏
                </div>

                <div class="hidden_yh" style="padding: 20px;width: 898px;">
                    <c:forEach items="${pagers.datas}" var="data" varStatus="l">
                        <a href="${ctx}/item/view?id=${data.itemId}">
                            <div class="width100 hidden_yh" style="border-bottom: 1px dashed #ddd;padding-top: 10px;padding-bottom: 10px;">
                                <%--左侧缩略图--%>
                                <img src="${data.item.url1}" alt="" width="100" height="100" class="left_yh" style="margin-right: 15px;">
                                <%--右侧描述--%>
                                <div class="left_yh" style="width: 580px;">
                                    <h3 class="font18 c_33 font100">${data.item.name}</h3>
                                    <p class="red" style="margin-top: 10px;">￥${data.item.price} </p>
                                </div>
                                <div class="right_yh">
                                    <a href="${ctx}/sc/delete?id=${data.id}" class="onfff block_yh tcenter font16" style="margin-top: 10px;padding: 6px;">取消收藏</a>
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>


    <%@include file="/common/uFooter.jsp"%>

</body>
</html>
