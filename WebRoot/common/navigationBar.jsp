<%--
  User: Liyunhan
  Date: 2021/5/12
  Time: 18:14
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--导航条--%>
<div class="width100" style="height: 45px;background: #ffc900;margin-top: 40px;position: relative;z-index: 100;">
    <%--中间的部分--%>
    <div class="width1200 center_yh relative_yh" style="height: 45px;">


        <%--2.普通导航--%>
        <div class="left_yh font16" id="pageNav">
            <a href="${ctx}/login/uIndex"><font style="color: black;">首页</font></a>
            <a href="${ctx}/item/shoplist"><font style="color: black;">全部商品</font></a>
            <a href="${ctx}/news/list"><font style="color: black;">帮助服务</font></a>
            <a href="${ctx}/message/add"><font style="color: black;">反馈建议</font></a>
        </div>
    </div>

</div>