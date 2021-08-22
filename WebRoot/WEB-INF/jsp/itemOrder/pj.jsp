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
    <title>评价</title>
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
                <div class="font24" style="height: 60px;line-height: 60px;text-indent: 50px;background: #f5f8fa;width: 938px;border: 1px solid #ddd;">
                    商品评价
                </div>
                <form action="${ctx}/comment/exAdd" method="post" id="myf">
                    <input type="hidden" name="itemId" value="${id}">
                    <div class="bj_fff hidden_yh" style="width: 838px;height: 120px;border: 1px solid #ddd;margin-top: 30px;padding: 50px;">
                        <div class="width100" style="height: 32px;line-height: 32px;">
                            <div class="left_yh font16 tright" style="width: 120px;">
                                <font class="red">*</font>评价内容:
                            </div>
                            <input type="text" name="content" style="width: 300px;border: 1px solid #ddd;outline: none;height: 100px;text-indent: 10px;">
                        </div>
                        <div class="width100" style="height: 32px;line-height: 32px;margin-top: 80px;">
                            <a href="javascript:void(0);" class="left_yh block_yh font16 tcenter ff5802 con"
                               style="width: 240px;height: 33px;line-height: 33px;margin-left: 120px;">保存</a>
                        </div>
                    </div>
                </form>
            </div>

        </div>
    </div>




    <%@include file="/common/uFooter.jsp"%>
    <%--切换顶部菜单--%>
    <script>
       $(function () {
           $(".con").click(function () {
                $("#myf").submit();
           });
       });
    </script>

</body>
</html>
