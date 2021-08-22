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
    <title>(管理员后台)商品详情</title>
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/css/pintuer.css">
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/css/admin.css">
    <script src="${ctx}/resource/js/jquery.js"></script>
    <script src="${ctx}/resource/js/pintuer.js"></script>
</head>
<body>
<div class="panel admin-panel">
    <%--信息表格--%>
    <table class="table table-hover text-center">
        <tr>
            <th>商品名称</th>
            <th>商品主图</th>
            <th>商品单价</th>
            <th>购买数量</th>
            <th>小计</th>
            <th>状态</th>
        </tr>
        <%--遍历从后台拿到的Pagers--%>
        <c:forEach items="${pagers.datas}" var="data" varStatus="1">
            <tr>
                <td>${data.item.name}</td>
                    <%--此处数据库存储的时图片的url,若要显示图片,要用img标签--%>
                <td><img src="${data.item.url1}" alt="" style="width: 100px;height: 100px"/> </td>
                <td>${data.item.price}</td>
                <td>${data.num}</td>
                <td>${data.total}</td>
                <td style="color: red">
                    <c:if test="${data.status==0}">未退货</c:if>
                    <c:if test="${data.status==1}">已退货</c:if>
                </td>

            </tr>
        </c:forEach>

        <%--表格底部翻页--%>
        <tr>
            <td colspan="8">
                <div class="pagelist">
                    <%--分页开始--%>
                    <pg:pager url="${ctx}/orderDetail/ulist?orderId=${obj.orderId}" maxIndexPages="5" items="${pagers.total}" maxPageItems="15" export="curPage=pageNumber">
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
