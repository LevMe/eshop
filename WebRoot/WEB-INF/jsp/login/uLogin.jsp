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
    <title>用户登录</title>
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/user/css/style.css">
    <script src="${ctx}/resource/user/js/jquery-1.8.3.min.js"></script>
    <script src="${ctx}/resource/user/js/jquery.luara.0.0.1.min.js"></script>
</head>
<body background="${ctx}/resource/user/images/uLoginBg.png" style="background-attachment: fixed;background-repeat: no-repeat">
    <div class="width100 hidden_yh" >
        <div class="width1200 hidden_yh center_yh" style="margin-top: 75px;">
            <div style="width: 408px;height: 438px;margin-left: 408px;">
                <form action="${ctx}/login/utoLogin" method="post" id="loginForm" style="border: 2px solid #ddd;">
                    <h3 class="tcenter font40 c_33" style="font-weight: 100;margin-top: 36px;margin-bottom: 72px;">账户登陆</h3>
                        <div class="center_yh hidden_yh" style="width: 336px;">
                            <div class="width100 box-sizing hidden_yh" style="height: 44px;border: 1px solid #c9c9c9;margin-bottom: 34px;">
                                 <img src="${ctx}/resource/user/images/rw.jpg" class="left_yh" width="42" height="42">
                                 <input type="text" placeholder="请输入用户名或手机号" name="userName" value="" style="border: 0;width: 292px;height: 42px; font-size: 16px;text-indent: 22px">
                            </div>

                            <div class="width100 box-sizing hidden_yh" style="height: 44px;border: 1px solid #c9c9c9;margin-bottom: 6px;">
                                <img src="${ctx}/resource/user/images/pass.jpg" class="left_yh" width="42" height="42">
                                <input type="password" placeholder="请输入密码" name="passWord" value="" style="border: 0;width: 292px;height: 42px; font-size: 16px;text-indent: 22px">
                            </div>

                            <div style="text-align: center;margin-bottom: 30px;margin-right: -228px;font-size: 10px;">
                                <font>没有账户?<a href="${ctx}/login/regist" style="color: red;">点我注册</a></font>
                            </div>
                            <input type="submit" value="登录" class="center_yh" style="width: 100%;height: 43px;font-size: 16px;background: #dd4545;outline: none;border: 0;color: #fff; cursor:pointer;margin-bottom: 10px;">
                    </div>
                </form>
            </div>
        </div>
    </div>

    <%--&lt;%&ndash;引入底部&ndash;%&gt;--%>
    <%--<%@include file="/common/uFooter.jsp"%>--%>
</body>
<%--异步验证--%>
<script>
    $(function () {
        //当表单提交时,校验用户名和密码
        $("#loginForm").submit(function () {
            $.post("${ctx}/login/utoLogin",$(this).serialize(),function (data) {
                //处理服务器响应的数据 data(回调函数) json: {flag:true/false}
                if (data.flag){
                    //注册成功,跳转登录页面重新登录
                    alert("登录成功!");
                    location.href = "${ctx}/login/uIndex";
                } else {
                    //登录失败,给出提示信息
                    alert("用户名或密码错误!");
                }

            });

            //2.跳转页面
            return false;
            //如果这个匿名方法返回为true(回调函数),则表单提交
        });
    });
</script>
</html>
