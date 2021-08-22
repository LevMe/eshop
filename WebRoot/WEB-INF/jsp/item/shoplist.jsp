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
    <title>商品列表</title>
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/user/css/style.css">
    <script src="${ctx}/resource/user/js/jquery-1.8.3.min.js"></script>
    <script src="${ctx}/resource/user/js/jquery.luara.0.0.1.min.js"></script>
</head>
<body background="${ctx}/resource/images/uIndexBg.png" style="background-attachment: fixed;background-repeat: no-repeat">
    <%--引入通用头部--%>
    <%@include file="/common/uTop.jsp"%>

    <%--引入通用导航条--%>
    <%@include file="/common/navigationBar.jsp"%>

    <%--"顶部导航"--%>
    <div class="width1200 center_yh hidden_yh font14" style="height: 40px;line-height: 40px;">
        <span>当前位置:</span><a href="${ctx}/login/uIndex" class="c_66">首页</a>><a href="#" class="c_66">商品列表</a>
    </div>

    <%--排序--%>
    <div class="width1198 center_yh" style="height: 35px;background: #f0f0f0; border: 1px solid #ddd;margin-top: 25px;">
        <a href="${ctx}/item/shoplist?categoryIdTwo=${obj.categoryIdTwo}" class="mR">默认</a>
        <%--price这里 0 代表价格降序  1 代表价格升序--%>
        <a href="${ctx}/item/shoplist?price=${priceOrder}&categoryIdTwo=${obj.categoryIdTwo}"  class="mR">
            价格
            <img src="${ctx}/resource/images/pointer${priceOrder}.png" alt="" >
        </a>

        <a href="${ctx}/item/shoplist?gmNum=${gmOrder}&categoryIdTwo=${obj.categoryIdTwo}" class="mR">
            销量
            <img src="${ctx}/resource/images/pointer${gmOrder}.png" alt="" >
        </a>
    </div>


    <%--商品列表--%>
    <div class="width1200 center_yh hidden_yh" style="margin-top: 25px;">
        <ul class="listSs">
            <c:forEach items="${pagers.datas}" var="data" varStatus="l">
                <li>
                    <%--点击图片通向商品详情--%>
                    <a href="${ctx}/item/view?id=${data.id}" class="bjK"><img src="${data.url1}" alt=""></a>
                        <h3 class="spName">${data.name}</h3>
                        <p class="center_yh block_yh hidden_yh" style="width: 202px;">
                            <font class="left_yh red font16">￥${data.price}</font>
                                <c:if test="${data.zk!=null}">
                                    <font class="right_yh font14">
                                        <span style="color: red;">[二手折扣]:</span>
                                        ${data.zk}
                                    </font>
                                </c:if>
                        </p>

                        <div class="wCa">
                            <a href="${ctx}/sc/exAdd?itemId=${data.id}" class="fav">
                                <div class="wCa1">
                                    <b><img src="${ctx}/resource/user/images/star.png" alt=""></b>
                                    <font>收藏</font>
                                </div>
                            </a>

                                <%--异步模式--%>
                            <div class="wCa2" onclick="addcar('${data.id}')">
                                <b><img src="${ctx}/resource/user/images/sar.png" alt=""></b>
                                <font>加入购物车</font>
                            </div>

                        </div>
                </li>
            </c:forEach>
        </ul>
    </div>

    <div id="navs">
        <div class="pagelist">
            <%--分页开始--%>
            <pg:pager url="${ctx}/item/shoplist" maxIndexPages="5" items="${pagers.total}" maxPageItems="15" export="curPage=pageNumber">
                <pg:param name="categoryIdTwo" value="${obj.categoryIdTwo}"/>
                <pg:param name="price" value="${obj.price}"/>
                <pg:param name="gmNum" value="${obj.gmNum}"/>
                <pg:param name="condition" value="${condition}"/>
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
    </div>
    <%--引入底部--%>
    <%@include file="/common/uFooter.jsp"%>

    <script>
        function addcar(id) {
            $.ajax({
                type:"post",
                url:"${ctx}/car/exAdd?itemId="+id+"&num=1",
                success:function (result) {
                    if (result.res == 0) {
                        alert("请先登录");
                        //去登陆
                        window.location.href="${ctx}/login/uLogin";
                    }else {
                        //返回当前页面
                        window.location.href="${ctx}/item/shoplist";
                    }
                }
            });
        }

       <%--function getImgByRes(res) {--%>
           <%--if (res == "1") {--%>
               <%--$("#priceOrder").attr("src","${ctx}/resource/images/pointerUp.png");--%>
           <%--} else {--%>
               <%--$("#priceOrder").attr("src","${ctx}/resource/images/pointerDown.png");--%>
           <%--}--%>
       <%--}--%>

        <%--function changeImg(img) {--%>
            <%--if (img.src.equals("${ctx}/resource/images/pointerDown.png")) {--%>
                <%--img.src = "${ctx}/resource/images/pointerUp.png";--%>
            <%--}else {--%>
                <%--img.src = "${ctx}/resource/images/pointerDown.png";--%>
            <%--}--%>
        <%--}--%>

    </script>
</body>
</html>
