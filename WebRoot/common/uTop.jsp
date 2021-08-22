<%--
  User: Liyunhan
  Date: 2021/5/3
  Time: 11:33
  Desc: 顶部页面,主页面的一部分
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<div class="width100" style="height: 25px;background: #f0f0f0;">
    <div class="width1200 center_yh font14 c_66" style="height: 25px;line-height: 25px">

        <%--1.最顶部内容--%>
        <font class="left_yh">Eshop二手电子设备交易平台</font>
        <div class="right_yh" id="fast_jump">
            <%--判断当前session中包含用户登录信息时--%>
            <c:if test="${userId!=null}">
                <img src="${ctx}/resource/images/user.jpg" style="display: inline;width: 18px;height: 18px;float: left;margin-top: 3px;">
                <a href="#">${username}</a>
                <b></b>
                <a href="${ctx}/login/uExit">退出</a>
                <b></b>
                <a href="${ctx}/car/findBySql">我的购物车</a>
                <b></b>
            </c:if>

            <%--当前session中不包含用户登录信息时--%>
            <c:if test="${userId==null}">
                <a href="${ctx}/login/uLogin">登录</a>
                <b></b>
                <a href="${ctx}/login/regist">注册</a>
                <b></b>
            </c:if>

            <a href="${ctx}/user/view">个人中心</a>
                <b></b>
            <a href="${ctx}/login/info">关于我们</a>
        </div>
    </div>
</div>

<div class="width100 hidden_yh">
    <div class="width1200 center_yh hidden_yh">
        <a href="${ctx}/login/uIndex" class="block_yh left_yh">
            <img src="${ctx}/resource/images/logo.png" alt="" style="height: 70px"/>
        </a>

        <div class="right_yh" style="height: 28px;width: 316px;border: 2px solid #dd0000;margin-top: 20px;">
                <%--搜索内容--%>
                <form action="${ctx}/item/shoplist" method="post">
                    <%--input内为模糊查询条件(条件可选)--%>
                    <input type="text" placeholder="关键词查询" class="search" name="condition" value="${condition}">
                    <input type="submit" class="btnSearch" value="搜索">
                </form>
        </div>
    </div>
</div>