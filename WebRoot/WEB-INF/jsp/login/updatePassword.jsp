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
        <a href="#" class="c_66">修改密码</a>
    </div>

    <%--左侧部分--%>
    <div class="width1200 hidden_yh center_yh">
        <div id="vipNav">
            <a href="${ctx}/user/view" >个人信息</a>
            <a href="${ctx}/itemOrder/myOrder">我的订单</a>
            <a href="${ctx}/sc/findBySql">我的收藏</a>
            <a href="${ctx}/login/updatePassword" class="on">修改密码</a>
        </div>
        <%--右侧内容--%>
        <div id="vipRight">
            <div class="font24" style="height: 60px;line-height: 60px;text-indent: 50px;background: #f5f8fa;border-bottom: 1px solid #ddd;">
                修改密码
            </div>
            <input type="hidden" id="yuan" value="${obj.passWord}">
            <div class="bj_fff hidden_yh" style="width: 838px;border: 1px solid #ddd;margin-top: 30px;padding: 50px;">
                <div class="width100" style="height: 32px;line-height: 32px;">
                    <div class="left_yh font16 tright" style="width: 120px;">
                        <font class="red">*</font>旧密码:
                    </div>
                    <input type="password" id="jiu" style="width: 243px;border: 1px solid #ddd; outline: none;height: 30px;text-indent: 10px;">
                </div>

                <div class="width100" style="height: 32px;line-height: 32px; margin-top: 25px;">
                    <div class="left_yh font16 tright" style="width: 120px;">
                        <font class="red">*</font>新密码:
                    </div>
                    <input type="password" id="xin" style="width: 243px;border: 1px solid #ddd; outline: none;height: 30px;text-indent: 10px;">
                </div>

                <div class="width100" style="height: 32px;line-height: 32px;margin-top: 25px;">
                    <div class="left_yh font16 tright" style="width: 120px;">
                        <font class="red">*</font>确认新密码:
                    </div>
                    <input type="password" id="que" style="width: 243px;border: 1px solid #ddd; outline: none;height: 30px;text-indent: 10px;">
                </div>

                <div class="width100" style="height: 32px;line-height: 32px;margin-top: 25px;">
                    <a href="javascript:void(0);" class="left_yh block_yh font16 tcenter ff5802 con" style="width: 244px;height: 33px;line-height: 33px;margin-left: 120px;">
                        保存
                    </a>
                </div>
            </div>
        </div>
    </div>


    <%@include file="/common/uFooter.jsp"%>

</body>
<script>
    $(".con").click(function () {
       var yuan = $("#yuan").val();
       var jiu = $("#jiu").val();
       var xin = $("#xin").val();
       var que = $("#que").val();
        if (jiu == null || jiu=='') {
           alert("旧密码不能为空!");
           return false;
        }
        if (xin == null || xin=='') {
            alert("新密码不能为空!");
            return false;
        }
        if (que == null || que=='') {
            alert("确认密码不能为空!");
            return false;
        }
        if (jiu != yuan) {
            alert("旧密码输入不正确!");
            return false;
        }
        if (xin == yuan) {
            alert("新密码不能与旧密码一样!");
            return false;
        }
        if (xin != que) {
            alert("两次密码输入不一致!");
            return false;
        }

        $.ajax({
           type:"post",
           url:"${ctx}/login/upass.do",
           data:{
               "password":xin
           } ,
            success:function (result) {
                if (result.res == 0) {
                    alert("请先登录");
                } else {
                    alert("修改成功!请重新登录");
                }
                //top -->到最顶级页面
                top.location.href = "${ctx}/login/uLogin";
            }
        });
    });
</script>
</html>
