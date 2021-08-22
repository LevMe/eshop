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
    <title>购物指南</title>
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/user/css/style.css">
    <script src="${ctx}/resource/user/js/jquery-1.8.3.min.js"></script>
    <script src="${ctx}/resource/user/js/jquery.luara.0.0.1.min.js"></script>
</head>
<body>
    <%--引入通用头部--%>
    <%@include file="/common/uTop.jsp"%>


    <%--引入通用导航条--%>
    <%@include file="/common/navigationBar.jsp"%>


    <div class="width100 hidden_yh" style="background: #f0f0f0;padding-top: 34px;padding-bottom: 34px;">
        <div class="width1200 hidden_yh center_yh">
            <div id="vipRight" style="width: 1200px">
                <div class="font24" style="height: 60px;line-height: 60px;text-indent: 50px;background: #f5f8fa;border-bottom: 1px solid #ddd;">
                    购物指南
                </div>

                <div class="hidden_yh" style="padding: 20px;width: 898px;">
                    <c:forEach items="${pagers.datas}" var="data" varStatus="l">
                        <a href="${ctx}/news/view?id=${data.id}">
                            <div class="width100 hidden_yh" style="border-bottom: 1px dashed #ddd;padding-top: 10px;padding-bottom: 10px;">

                                <div class="left_yh" style="width: 580px;">
                                    <font color="red">${data.name}</font>
                                </div>
                                <div class="right_yh">
                                    <font color="black">
                                        <fmt:formatDate value="${data.addTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </font>
                                </div>

                            </div>
                        </a>
                    </c:forEach>
                </div>
            </div>

            <div class="pagelist">
                <%--分页开始--%>
                <pg:pager url="${ctx}/news/list" maxIndexPages="5" items="${pagers.total}" maxPageItems="15" export="curPage=pageNumber">
                    <pg:last>共${pagers.total}条记录,共${pageNumber}页</pg:last>
                    当前第${curPage}页
                    <pg:first>
                        <a href="${pageUrl}" style="color: black;">首页</a>
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
                                <%--不是当前页点击则跳到对应页--%>
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
                        <a href="${pageUrl}" style="color: black;">尾页</a>
                    </pg:last>
                </pg:pager>
            </div>
        </div>
    </div>





    <%@include file="/common/uFooter.jsp"%>
</body>
</html>
