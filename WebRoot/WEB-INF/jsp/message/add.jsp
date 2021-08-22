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
    <title>用户反馈</title>
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/user/css/style.css">
    <script src="${ctx}/resource/user/js/jquery-1.8.3.min.js"></script>
    <script src="${ctx}/resource/user/js/jquery.luara.0.0.1.min.js"></script>
</head>
<body>
    <%--引入通用头部--%>
    <%@include file="/common/uTop.jsp"%>


    <%--引入通用导航条--%>
    <%@include file="/common/navigationBar.jsp"%>




    <div class="width1200 center_yh hidden_yh font14" style="height: 40px;line-height: 40px;">
    </div>
    <div class="width100 hidden_yh" style="background: #f0f0f0;padding-top:34px;padding-bottom: 34px;">
        <div class="width1200 hidden_yh center_yh">
            <div id="vipRight" style="height: 60px;line-height: 60px;text-indent: 50px; background: #f5f8fa;width: 1200px;border:1px solid #ddd;">
                提交留言
            </div>
            <div class="bj_fff hidden_yh" style="width: 1200px;border: 1px solid #ddd; margin-top: 30px;padding: 50px;">
                <div class="width100" style="height: 32px;line-height: 32px;">
                    <div class="left_yh fon16 tright" style="width:120px;"><font class="red">*</font>姓名： </div>
                    <input type="text" id="name" style="width: 243px;border: 1px solid #ddd; outline: none;height: 30px;text-indent: 10px;">
                </div>
                <div class="width100" style="height: 32px;line-height: 32px;margin-top: 25px;">
                    <div class="left_yh fon16 tright" style="width:120px;"><font class="red">*</font>手机号： </div>
                    <input type="text" id="phone" style="width: 243px;border: 1px solid #ddd; outline: none;height: 30px;text-indent: 10px;">
                </div>
                <div class="width100" style="height: 100px;line-height: 100px;margin-top: 25px;">
                    <div class="left_yh fon16 tright" style="width:120px;"><font class="red">*</font>内容： </div>
                    <textarea rows="10" cols="60" id="content" style="width: 300px;border: 1px solid #ddd;outline: none;height: 100px;text-indent: 10px;"></textarea>
                </div>
                <div class="width100" style="height: 32px;line-height: 32px;margin-top: 25px;">
                    <a href="javascript:void(0)" class="left_yh block_yh font16 tcenter ff5802 con" style="width: 244px;height: 33px;line-height: 33px;margin-left:120px;">
                        提交
                    </a>
                </div>
            </div>
        </div>
    </div>

    <%@include file="/common/uFooter.jsp"%>

</body>
<script>
    $(".con").click(function(){
        var name = $("#name").val();
        var phone = $("#phone").val();
        var content = $("#content").val();
        if(name==null||name==''){
            alert("请输入姓名");
            return false;
        }
        if(phone==null||phone==''){
            alert("请输入手机号");
            return false;
        }
        if(content==null||content==''){
            alert("请输入留言");
            return false;
        }
        $.ajax({
            type:"POST",
            url:"${ctx}/message/exAdd.do",
            data:{
                "name":name,
                "phone":phone,
                "content":content
            },
            success:function (result) {
                alert("您的反馈很重要，谢谢！")
                window.location.href = "${ctx}/message/add";
            }
        });
    });
</script>
</html>
