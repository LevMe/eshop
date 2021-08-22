<%--
  User: Liyunhan
  Date: 2021/5/3
  Time: 11:33
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--引入标签库(自定义jsp)--%>
<%@include file="/common/taglibs.jsp"%>

<%--平台管理员登录验证信息页面--%>
<html>
<head>
    <title>Master Login</title>
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/ml/css/style.css">
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/css/pintuer.css">
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/css/admin.css">
    <script src="${ctx}/resource/js/jquery.js"></script>
    <script src="${ctx}/resource/js/pintuer.js"></script>
</head>
<body class="mbg">
    <%--背景颜色--%>


    <div class="container">
        <div class="line bouncein">
            <div class="xs6 xm4 xs3-move xm4-move">
                <%--调整样式--%>
                <div style="height: 150px;"></div>
                <div class="media media-y margin-big-bottom"></div>
                <%--表单--%>
                <form action="${ctx}/login/toLogin" method="post">
                    <div class="panel login-box">
                        <%--表单头部标题--%>
                        <div class="text-center margin-big padding-big-top">
                            <h1>管理员登录</h1>
                        </div>

                        <div class="panel-body" style="padding: 30px; padding-bottom: 10px; padding-top: 10px;">
                            <div class="form-group">
                                <%--右侧图标--%>
                                <div class="field field-icon-right">
                                    <input type="text" class="input input-big" name="userName" value="admin" placeholder="登录账户" data-validate="required:请填写账户">
                                    <span class="icon icon-user margin-small"></span>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="field field-icon-right">
                                    <input type="password" class="input input-big" name="passWord" value="111111" placeholder="登陆密码" data-validate="required:请填写密码">
                                    <span class="icon icon-key margin-small"></span>
                                </div>
                            </div>
                        </div>

                        <div style="padding: 30px;">
                            <input type="submit" class="button button-block bg-main text-big input-big" value="登录"/>
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>
</body>
</html>
