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
    <title>商品二级分类</title>
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/ml/css/style.css">
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/css/pintuer.css">
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/css/admin.css">
    <script src="${ctx}/resource/js/jquery.js"></script>
    <script src="${ctx}/resource/js/pintuer.js"></script>
</head>
<body>
    <div class="panel admin-panel">
        <%--添加按钮--%>
        <div class="padding border-bottom">
            <ul class="search" style="padding-left: 10px;">
                <li>
                    <a class="button border-main icon-plus-square-o" href="${ctx}/itemCategory/add2?pid=${obj.pid}">新增二级类目</a>
                </li>
            </ul>
        </div>
        <%--信息表格--%>
        <table class="table table-hover text-center">
            <tr>
                <th>ID</th>
                <th>类别名称</th>
                <th>操作</th>
            </tr>
            <%--遍历从后台拿到的Pagers--%>
            <c:forEach items="${pagers.datas}" var="data" varStatus="1">
                <tr>
                    <td>${data.id}</td>
                    <td>${data.name}</td>
                    <td>
                        <div class="button-group">

                            <a class="button border-main" href="${ctx}/itemCategory/update2?id=${data.id}">
                                <span class="icon-edit">修改</span>
                            </a>
                            <%--由于删除完之后还要返回二级页面,因此要把pid也传回去--%>
                            <a class="button border-red" href="${ctx}/itemCategory/delete2?id=${data.id}&pid=${data.pid}">
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
                        <pg:pager url="${ctx}/itemCategory/findBySql2" maxIndexPages="5" items="${pagers.total}" maxPageItems="15" export="curPage=pageNumber">
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
</html>
