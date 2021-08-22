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
    <title>用户注册页</title>
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/user/css/style.css">
    <script src="${ctx}/resource/user/js/jquery-1.8.3.min.js"></script>
    <script src="${ctx}/resource/user/js/jquery.luara.0.0.1.min.js"></script>
</head>
<%@include file="/common/uTop.jsp"%>


<%--background="${ctx}/resource/images/background.jpg" style="background-repeat: no-repeat;background-size:121%;
margin-top: 50px;"
<%--引入通用头部--%>

<body background="${ctx}/resource/images/uRegistBg.png" style="background-attachment: fixed;background-size: 100%;background-repeat: no-repeat;position: center;">
    <div class="width100 hidden_yh" style="border-top: 1px solid #ddd;">
        <div class="width1200 hidden_yh center_yh" style="margin-top: 75px;">
            <form method="post" id="registForm" style="border: 2px solid #ddd;">
                <h1 style="text-align: center;margin-bottom: 25px;">用户注册</h1>
                <div class="center_yh hidden_yh" style="width: 600px;margin-bottom: 25px;margin-left: 362px;">
                    <span style="margin-right: 40px;height: 42px;line-height: 42px;width: 100px;" class="left_yh block_yh tright">用户名:</span>
                    <input type="text" id="userName" name="userName" placeholder="请输入用户名" style="border: 1px solid #c9c9c9;width: 292px;height: 42px;font-size: 16px;text-indent: 22px;" class="left_yh">
                    <span id="userNameSpan" style="color: red"></span>
                </div>

                <div class="center_yh hidden_yh" style="width: 600px;margin-bottom: 25px;margin-left: 362px;">
                    <span style="margin-right: 40px;height: 42px;line-height: 42px;width: 100px;" class="left_yh block_yh tright">设置密码:</span>
                    <input type="password" id="passWord" name="passWord" placeholder="建议至少使用两种密码组合" style="border: 1px solid #c9c9c9;width: 292px;height: 42px;font-size: 16px;text-indent: 22px;" class="left_yh">
                    <span id="passWordSpan" style="color: red"></span>
                </div>

                <div class="center_yh hidden_yh" style="width: 600px;margin-bottom: 25px;margin-left: 362px;">
                    <span style="margin-right: 40px;height: 42px;line-height: 42px;width: 100px;" class="left_yh block_yh tright">再次输入密码:</span>
                    <input type="password" id="rePassWord" name="rePassWord" placeholder="请再次输入您的密码" style="border: 1px solid #c9c9c9;width: 292px;height: 42px;font-size: 16px;text-indent: 22px;" class="left_yh">
                    <span id="rePassWordSpan" style="color: red"></span>
                </div>

                <div class="center_yh hidden_yh" style="width: 600px;margin-bottom: 25px;margin-left: 362px;">
                    <span style="margin-right: 40px;height: 42px;line-height: 42px;width: 100px;" class="left_yh block_yh tright">真实姓名:</span>
                    <input type="text" id="realName" name="realName" placeholder="真实姓名" style="border: 1px solid #c9c9c9;width: 292px;height: 42px;font-size: 16px;text-indent: 22px;" class="left_yh">
                    <span id="realNameSpan" style="color: red"></span>
                </div>

                <div class="center_yh hidden_yh" style="width: 600px;margin-bottom: 25px;margin-left: 362px;">
                    <span style="margin-right: 40px;height: 42px;line-height: 42px;width: 100px;" class="left_yh block_yh tright">手机号:</span>
                    <input type="text" id="phone" name="phone" placeholder="建议使用常用手机号" style="border: 1px solid #c9c9c9;width: 292px;height: 42px;font-size: 16px;text-indent: 22px;" class="left_yh">
                    <span id="phoneSpan" style="color: red"></span>
                </div>


                <div class="center_yh hidden_yh" style="width: 600px;margin-bottom: 15px;margin-left: 362px;">
                    <span style="margin-right: 40px;height: 42px;line-height: 42px;width: 100px;" class="left_yh block_yh tright">性别:</span>
                    <div style="width: 292px;height: 42px;font-size: 16px;margin-top: 11px;">
                        <input type="radio" id="sex" name="sex" value="男" checked> 男
                        <input type="radio" name="sex" value="女"> 女
                    </div>
                </div>

                <div class="center_yh hidden_yh" style="width: 600px;margin-bottom: 25px;margin-left: 362px;">
                    <span style="margin-right: 40px;height: 42px;line-height: 42px;width: 100px;" class="left_yh block_yh tright">收货地址:</span>
                    <input type="text" id="address" name="address" placeholder="请输入地址" style="border: 1px solid #c9c9c9;width: 292px;height: 42px;font-size: 16px;text-indent: 22px;" class="left_yh">
                </div>

                <div class="center_yh hidden_yh" style="width: 600px;margin-bottom: 25px;margin-left: 362px;">
                    <span style="margin-right: 40px;height: 42px;line-height: 42px;width: 100px;" class="left_yh block_yh tright">电子邮箱:</span>
                    <input type="text" id="email" name="email" placeholder="请输入邮箱" style="border: 1px solid #c9c9c9;width: 292px;height: 42px;font-size: 16px;text-indent: 22px;" class="left_yh">
                    <span id="emailSpan" style="color: red"></span>
                </div>

                <div class="center_yh hidden_yh" style="width: 600px;margin-bottom: 25px;margin-left: 362px;">
                    <span style="margin-right: 40px;height: 42px;line-height: 42px;width: 100px;" class="left_yh block_yh tright">验证码:</span>
                    <input type="text" id="checkCode" name="checkCode" placeholder="请输入验证码" style="border: 1px solid #c9c9c9;width: 146px;height: 42px;font-size: 16px;text-indent: 22px;" class="left_yh">
                    <img src="${ctx}/checkCode/printCode" height="42px" alt="" onclick="changeCheckCode(this)" id="image">
                    <script type="text/javascript">
                        //图片点击事件
                        function changeCheckCode(img) {
                            img.src="${ctx}/checkCode/printCode?"+new Date().getTime();
                        }
                    </script>
                </div>

                <p class="font14 c_66" style="text-indent: 500px;margin-top: 30px;">
                    <input type="checkbox" id="checkProtocol">我已阅读并同意<a href="#" class="red">《Eshop用户协议》</a>和<a href="#" class="red">《用户隐私保护政策》</a>
                </p>

                <input type="submit" value="提交" class="ipt_tj" style="width: 295px;height: 44px;margin-left: 500px;">
            </form>
        </div>
    </div>
</body>
    <%--引入底部--%>
    <%@include file="/common/uFooter.jsp"%>

<script>
    /*
        表单预校验
           1.用户名:单词字符,长度8-20位
           2.密码:单词字符,长度8-20位
           3.确认密码:再次输入密码
           4.Email:邮箱,正则格式
           5.realName:真实姓名
           6.手机号:手机号格式
           7.用户协议,必须勾选
           8.验证码:非空
    */
    //校验用户名
    function checkUsername() {
        //1.获取用户名的值
        var username = $("#userName").val();
        //2.定义正则表达式
        var reg_username = /^\w{8,20}$/;
        //3.判断,给出提示信息
        var flag = reg_username.test(username);
        if (flag) {
            //合法
            $("#userName").css("border","");
            $("#userNameSpan").html("");
        }else {
            //非法,加红色边框
            $("#userName").css("border","1px solid red");
            $("#userNameSpan").html("❌请正确填写用户名 (8-20位字符,数字)");
        }

        return flag;
    }

    //校验密码
    function checkPassword() {
        //1.获取密码的值
        var password = $("#passWord").val();
        //2.定义正则表达式
        var reg_password = /^\w{8,20}$/;
        //3.判断,给出提示信息
        var flag = reg_password.test(password);
        if (flag) {
            //合法
            $("#passWord").css("border","");
            $("#passWordSpan").html("");
        }else {
            //非法,加红色边框
            $("#passWord").css("border","1px solid red");
            $("#passWordSpan").html("❌输入密码格式错误 (8-20位字符,数字)");
        }

        return flag;
    }

    //校验二次输入密码 只需校验是否和第一次输入的一致即可
    function checkRePassword() {
        //1.获取第二次输入密码的值
        var password = $("#passWord").val();
        var repassword = $("#rePassWord").val();
        //2.判断两次密码是否一致(增强用户体验,忽略前导和后导空格)
        var flag = $.trim(password)==$.trim(repassword);
        if (flag) {
            //合法
            $("#rePassWord").css("border","");
            $("#rePassWordSpan").html("");
        }else {
            //非法,加红色边框
            $("#rePassWord").css("border","1px solid red");
            $("#rePassWordSpan").html("❌两次输入密码不一致");
        }

        return flag;
    }

    //校验邮箱
    function checkEmail(){
        //1.获取邮箱
        var email = $("#email").val();
        //2.定义正则(^-->start , $--> end)
        var reg_email = /^\w+@\w+\.\w+$/;

        //3.判断
        var flag = reg_email.test(email);
        if (flag){
            $("#email").css("border","");
            $("#emailSpan").html("");
        } else {
            $("#email").css("border","1px solid red");
            $("#emailSpan").html("❌输入邮箱格式错误 (xxxx@xx.com)");
        }
        return flag;
    }

    //校验姓名
    function checkName(){
        //1.获取真实姓名
        var name = $("#realName").val();
        //2.定义正则(^-->start , $--> end)
        var reg_name = /^[a-zA-Z0-9_\u4e00-\u9fa5]+$/;

        //3.判断
        var flag = reg_name.test(name);
        if (flag){
            $("#realName").css("border","");
            $("#realNameSpan").html("");
        } else {
            $("#realName").css("border","1px solid red");
            $("#realNameSpan").html("❌请正确填写您的姓名");
        }
        return flag;
    }

    //校验电话号码
    function checkTelephone(){
        //1.获取电话号码
        var telephone = $("#phone").val();
        //2.定义正则(^-->start , $--> end)
        var reg_telephone = /^\w{11}$/;

        //3.判断
        var flag = reg_telephone.test(telephone);
        if (flag){
            $("#phone").css("border","");
            $("#phoneSpan").html("");
        } else {
            $("#phone").css("border","1px solid red");
            $("#phoneSpan").html("❌请正确填写手机号 (11位数字)");
        }
        return flag;
    }

    //入口函数
    $(function () {
        //两种校验
        //当表单提交时,调用所有校验方法
        $("#registForm").submit(function () {
            //未勾选同意协议
            if (!$("#checkProtocol").prop('checked')) {
                alert("请勾选用户协议");
                return false;
            }
            //1.发送数据到服务器(检查验证码和用户名是否已被使用)
            if (checkUsername() && checkPassword() && checkPassword() && checkEmail() && checkName() && checkTelephone()) {
                //校验通过,发送Ajax请求,提交表单数据,表单序列化拿到key-value
                $.post("${ctx}/login/toRegist",$(this).serialize(),function (data) {
                    //处理服务器响应的数据 data(回调函数) json: {flag:true/false}

                    if (data.flag){
                        //注册成功,跳转登录页面重新登录
                        alert("注册成功!");
                        location.href = "${ctx}/login/uLogin";
                    } else {
                        //注册失败,给出提示信息
                        if (data.res == null) {
                           alert("验证码错误!");
                        }else {
                            alert("用户名已被占用!");
                            $("#userName").css("border","1px solid red");
                            $("#userNameSpan").html("❌该用户名已被占用");
                        }
                        //刷新验证码
                        $("#image").attr("src","${ctx}/checkCode/printCode?"+new Date().getTime());
                    }

                });
            }

            //2.跳转页面
            return false;
            //如果这个匿名方法返回为true(回调函数),则表单提交
        });


        //当某一个组件失去焦点时,调用对应的校验方法(传入的是函数对象,所以不加括号)
        $("#userName").blur(checkUsername);
        $("#passWord").blur(checkPassword);
        $("#rePassWord").blur(checkRePassword);
        $("#realName").blur(checkName);
        $("#phone").blur(checkTelephone);
        $("#email").blur(checkEmail);
    });

</script>
</html>
