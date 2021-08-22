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
    <title>(管理员)商品订单信息</title>
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/ml/css/style.css">
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/css/pintuer.css">
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/css/admin.css">
    <script src="${ctx}/resource/js/jquery.js"></script>
    <script src="${ctx}/resource/js/pintuer.js"></script>
</head>
<body>
<div class="panel admin-panel">
    <form action="${ctx}/itemOrder/findBySql" id="listform" method="post">
        <div class="padding border-bottom">
            <ul class="search" style="padding-left: 10px;">
                <li>
                    <%--***--%>
                    <input type="text" placeholder="订单号" name="code" class="input" value="${obj.code}"
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
            <th>订单号</th>
            <th>下单时间</th>
            <th>总金额</th>
            <th>下单用户</th>
            <th>订单状态</th>
            <th>操作</th>
        </tr>
        <%--遍历从后台拿到的Pagers--%>
        <c:forEach items="${pagers.datas}" var="data" varStatus="1">
            <tr>
                <td>${data.code}</td>
                    <%--此处数据库存储的是图片的url,若要显示图片,要用img标签--%>
                <td><fmt:formatDate value="${data.addTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                <td>${data.total}</td>
                <%--使用关联的数据(user)--%>
                <td>${data.user.userName}</td>
                <td style="color: red">
                    <c:if test="${data.status==0}">待发货</c:if>
                    <c:if test="${data.status==1}">已取消</c:if>
                    <c:if test="${data.status==2}">待收货</c:if>
                    <c:if test="${data.status==3}">已收货</c:if>
                </td>
                <td>
                    <a class="button border-main" href="${ctx}/orderDetail/ulist?orderId=${data.id}">
                        <span class="icon-edit">查看购买商品</span>
                    </a>
                    <c:if test="${data.status==0}">
                        <a class="button border-red" href="${ctx}/itemOrder/fh?id=${data.id}">
                            <span class="icon-send">去发货</span>
                        </a>
                    </c:if>
                </td>

            </tr>
        </c:forEach>

        <%--表格底部翻页--%>
        <tr>
            <td colspan="8">
                <div class="pagelist">
                    <%--分页开始--%>
                    <pg:pager url="${ctx}/itemOrder/findBySql" maxIndexPages="5" items="${pagers.total}" maxPageItems="15" export="curPage=pageNumber">
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

</script>
</html>
