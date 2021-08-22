<%--
  User: Liyunhan
  Date: 2021/5/3
  Time: 17:18
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--引入标签库(自定义jsp)--%>
<%@include file="/common/taglibs.jsp"%>

<html>
<head>
    <title>(管理员)修改用户信息</title>
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/ml/css/style.css">
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/css/pintuer.css">
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/css/admin.css">
    <script src="${ctx}/resource/js/jquery.js"></script>
    <script src="${ctx}/resource/js/pintuer.js"></script>
</head>
<body>
    <div class="panel admin-panel">
        <div class="panel-head" id="add">
            <strong>
                <span class="icon-pencil-square-o">管理员修改用户信息</span>
            </strong>
        </div>

        <div class="body-content">
            <form action="${ctx}/user/exmUpdate" method="post" class="form-x">
                <%--添加一个隐藏域,方便知道操作哪个对象id--%>
                <input type="hidden" name="id" value="${obj.id}"/>
                <div class="form-group">
                    <div class="label">
                        <label>用户名:</label>
                    </div>
                    <div class="field">
                        <input type="text" class="input w50" name="userName" data-validate="required:请输入" value="${obj.userName}">
                        <div class="tips"></div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label">
                        <label>密码:</label>
                    </div>
                    <div class="field">
                        <input type="text" class="input w50" name="passWord" data-validate="required:请输入" value="${obj.passWord}">
                        <div class="tips"></div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label">
                        <label>电话号码:</label>
                    </div>
                    <div class="field">
                        <input type="text" class="input w50" name="phone" data-validate="required:请输入" value="${obj.phone}">
                        <div class="tips"></div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label">
                        <label>真实姓名:</label>
                    </div>
                    <div class="field">
                        <input type="text" class="input w50" name="realName" data-validate="required:请输入" value="${obj.realName}">
                        <div class="tips"></div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label">
                        <label>性别:</label>
                    </div>
                    <div class="field">
                        <input type="text" class="input w50" name="sex" data-validate="required:请输入" value="${obj.sex}">
                        <div class="tips"></div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label">
                        <label>地址:</label>
                    </div>
                    <div class="field">
                        <input type="text" class="input w50" name="address" data-validate="required:请输入" value="${obj.address}">
                        <div class="tips"></div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label">
                        <label>电子邮箱:</label>
                    </div>
                    <div class="field">
                        <input type="text" class="input w50" name="email" data-validate="required:请输入" value="${obj.email}">
                        <div class="tips"></div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label"></div>
                    <div class="field">
                        <button class="button bg-main icon-check-square-o" type="submit">完成修改</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
