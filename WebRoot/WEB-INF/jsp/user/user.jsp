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
    <title>(管理员)用户管理</title>
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/ml/css/style.css">
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/css/pintuer.css">
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/css/admin.css">
    <script src="${ctx}/resource/js/jquery.js"></script>
    <script src="${ctx}/resource/js/pintuer.js"></script>
</head>
<body>
<div class="panel admin-panel">
    <form action="${ctx}/user/findBySql" id="listform" method="post">
        <div class="padding border-bottom">
            <ul class="search" style="padding-left: 10px;">
                <li>
                    <%--***--%>
                    <input type="text" placeholder="请输入用户名" name="userName" class="input" value="${obj.userName}"
                           style="width: 250px;line-height: 17px;display: inline-block">
                    <%--设置点击时不要转向任何页面--%>
                    <a href="javascript:void(0);" onclick="changeSearch()" class="button border-main icon-search">搜索</a>
                </li>
            </ul>
        </div>
    </form>
<%--添加按钮--%>
    <%--信息表格--%>
    <table class="table table-hover text-center">
        <tr>
            <th>用户名</th>
            <th>手机号</th>
            <th>真实姓名</th>
            <th>性别</th>
            <th>邮箱</th>
            <th>地址</th>
            <th>修改</th>
        </tr>
        <%--遍历从后台拿到的Pagers--%>
        <c:forEach items="${pagers.datas}" var="data" varStatus="1">
            <tr>
                <td>${data.userName}</td>
                <td>${data.phone}</td>
                <td>${data.realName}</td>
                <td>${data.sex}</td>
                <td>${data.email}</td>
                <td>${data.address}</td>
                <td>
                    <div class="button-group">
                        <a class="button border-main" href="${ctx}/user/mUpdate?id=${data.id}">
                            <span class="icon-edit">修改</span>
                        </a>
                        <a class="button border-red" href="javascript:confirmDel(${data.id});">
                            <span class="icon-edit">删除</span>
                        </a>
                    </div>
                </td>

            </tr>
        </c:forEach>

        <%--表格底部翻页--%>
        <tr>
            <td colspan="8">
                <div class="pagelist">
                    <%--分页开始--%>
                    <pg:pager url="${ctx}/user/findBySql" maxIndexPages="5" items="${pagers.total}" maxPageItems="15" export="curPage=pageNumber">
                        <pg:last>共${pagers.total}条记录,共${pageNumber}页</pg:last>
                        当前第${curPage}页
                        <pg:first>
                            <a href="${pageUrl}">首页</a>
                        </pg:first>

                        <%--pageUrl会自动对应(first or prev)--%>
                        <pg:prev>
                            <a href="${pageUrl}">上一页</a>
                        </pg:prev>

                        <%--中部页面 --%>
                        <pg:pages>
                            <c:choose>
                                <c:when test="${curPage eq pageNumber}">
                                    <%--是当前页则以红色标识--%>
                                    <font color="red">[${pageNumber}]</font>
                                </c:when>
                                <c:otherwise>
                                    <%--不是则跳到对应页--%>
                                    <a href="${pageUrl}">${pageNumber}</a>
                                </c:otherwise>
                            </c:choose>
                        </pg:pages>

                        <%--下一页--%>
                        <pg:next>
                            <a href="${pageUrl}">下一页</a>
                        </pg:next>

                        <%--最后一页--%>
                        <pg:last>
                            <%--<c:choose>--%>
                            <%--<c:when test="${curPage eq pageNumber}">--%>
                            <%--<font color="red">尾页</font>--%>
                            <%--</c:when>--%>
                            <%--<c:otherwise>--%>
                            <%--<a href="${pageUrl}">尾页</a>--%>
                            <%--</c:otherwise>--%>
                            <%--</c:choose>--%>
                            <a href="${pageUrl}">尾页</a>
                        </pg:last>
                    </pg:pager>
                </div>
            </td>

        </tr>

    </table>
</div>
</body>

<script>
    function changeSearch() {
        $("#listform").submit();
    }

    function confirmDel(id) {
        if (confirm("确定要删除该用户吗?")){
            window.location.href = "${ctx}/user/mDelete?id="+id;
        }
    }

</script>
</html>
