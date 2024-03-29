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
    <title>新增二级类目</title>
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
                <span class="icon-pencil-square-o">新增二级类目</span>
            </strong>
        </div>

        <div class="body-content">
            <form action="${ctx}/itemCategory/exAdd" method="post" class="form-x">
                <input type="hidden" name="pid" value="${pid}">
                <div class="form-group">
                    <div class="label">
                        <label>二级类目名称:</label>
                    </div>
                    <div class="field">
                        <%--必填--%>
                        <input type="text" class="input w50" name="name" data-validate="required:请输入名称">
                        <div class="tips"></div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label"></div>
                    <div class="field">
                        <button class="button bg-main icon-check-square-o" type="submit">提交</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
