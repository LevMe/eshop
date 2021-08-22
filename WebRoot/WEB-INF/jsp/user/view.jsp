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
    <title>(用户)修改个人信息</title>
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
        <a href="${ctx}/user/view" class="c_66">个人中心</a>
        >
        <a href="#" class="c_66">个人信息</a>
    </div>


    <div class="width100 hidden_yh" style="background: #f0f0f0;padding-top: 34px;padding-bottom: 34px;">
        <%--左侧部分--%>
        <div class="width1200 hidden_yh center_yh">
            <div id="vipNav">
                <a href="${ctx}/user/view" class="on">个人信息</a>
                <a href="${ctx}/itemOrder/myOrder" >我的订单</a>
                <a href="${ctx}/sc/findBySql" >我的收藏</a>
                <a href="${ctx}/login/updatePassword" >修改密码</a>
            </div>

            <%--右侧部分--%>
            <div id="vipRight">
                <form action="${ctx}/user/exUpdate" method="post" id="myf">
                    <div class="hidden_yh bj_fff" style="width: 938px;border: 1px solid #ddd;">
                        <div class="width100 font24" style="height: 60px;line-height: 60px;text-indent: 50px; background: #f5f8fa;border-bottom: 1px solid #ddd;">基本信息</div>

                        <div class="width100" style="height: 32px;line-height: 32px;margin-top: 25px;">
                            <div class="left_yh font16 tright" style="width: 120px;">
                                <font class="red">*</font>真实姓名:
                            </div>
                            <input type="text" name="realName" value="${obj.realName}" style="width: 343px;border: 1px solid #ddd;outline: none;height: 34px;text-indent: 10px;">
                        </div>

                        <div class="width100" style="height: 32px;line-height: 32px;margin-top: 25px;">
                            <div class="left_yh font16 tright" style="width: 120px;">
                                <font class="red">*</font>性别:
                            </div>
                            <div style="width: 292px;height: 42px;font-size: 16px;margin-top: 11px;">
                                <input type="radio" name="sex" value="男" checked> 男
                                <input type="radio" name="sex" value="女"> 女
                            </div>
                        </div>

                        <div class="width100" style="height: 32px;line-height: 32px;margin-top: 25px;">
                            <div class="left_yh font16 tright" style="width: 120px;">
                                <font class="red">*</font>邮箱:
                            </div>
                            <input type="text" name="email" value="${obj.email}" style="width: 343px;border: 1px solid #ddd;outline: none;height: 34px;text-indent: 10px;">
                        </div>

                        <div class="width100" style="height: 32px;line-height: 32px;margin-top: 25px;">
                            <div class="left_yh font16 tright" style="width: 120px;">
                                <font class="red">*</font>手机号:
                            </div>
                            <input type="text" name="phone" value="${obj.phone}" style="width: 343px;border: 1px solid #ddd;outline: none;height: 34px;text-indent: 10px;">
                        </div>

                        <div class="width100" style="height: 32px;line-height: 32px;margin-top: 25px;">
                            <div class="left_yh font16 tright" style="width: 120px;">
                                <font class="red">*</font>地址:
                            </div>
                            <input type="text" name="address" value="${obj.address}" style="width: 343px;border: 1px solid #ddd;outline: none;height: 34px;text-indent: 10px;">
                        </div>

                        <div class="width100" style="height: 32px;line-height: 32px;margin-top: 70px;">
                            <a href="javascript:void(0);" class="left_yh block_yh font16 tcenter ff5802 sub" style="width: 244px;height: 33px;line-height: 33px;margin-left: 120px;margin-bottom: 10px;">保存</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>




    <%@include file="/common/uFooter.jsp"%>

    <script>
        $(function () {
            $(".sub").click(function () {
                alert("修改成功!");
                $("#myf").submit();
            });
        });
    </script>
</body>
</html>
