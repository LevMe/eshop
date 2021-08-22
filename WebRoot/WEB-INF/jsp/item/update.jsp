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
    <title>(管理员)商品修改</title>
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/ml/css/style.css">
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/css/pintuer.css">
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/css/admin.css">
    <script src="${ctx}/resource/js/jquery.js"></script>
    <script src="${ctx}/resource/js/pintuer.js"></script>
    <%--引入富文本 ueditor(需要先引入config)--%>
    <script type="text/javascript" src="${ctx}/resource/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="${ctx}/resource/ueditor/ueditor.all.min.js"></script>

</head>
<body>
    <div class="panel admin-panel">
        <div class="panel-head" id="add">
            <strong>
                <span class="icon-pencil-square-o">商品维护</span>
            </strong>
        </div>

        <div class="body-content">
            <%--表单支持上传文件--%>
            <form action="${ctx}/item/exUpdate" method="post" class="form-x" enctype="multipart/form-data">
                <input type="hidden" name="id" value="${obj.id}"/>
                <div class="form-group">
                    <div class="label">
                        <label>商品名称:</label>
                    </div>
                    <div class="field">
                        <%--修改时数据回显,增强体验--%>
                        <input type="text" class="input w50" name="name" data-validate="required:请输入商品名称" value="${obj.name}">
                        <div class="tips"></div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label">
                        <label>商品价格:</label>
                    </div>
                    <div class="field">
                        <%--必填--%>
                        <input type="text" class="input w50" name="price" data-validate="required:请输入商品价格" value="${obj.price}">
                        <div class="tips"></div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label">
                        <label>商品折扣:</label>
                    </div>
                    <div class="field">
                        <%--必填--%>
                        <input type="text" class="input w50" name="zk" data-validate="required:请输入商品折扣" value="${obj.zk}">
                        <div class="tips"></div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label">
                        <label>商品库存:</label>
                    </div>
                    <div class="field">
                        <%--必填--%>
                        <input type="text" class="input w50" name="kcNum" data-validate="required:请输入商品库存" value="${obj.kcNum}">
                        <div class="tips"></div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label">
                        <label>商品类别:</label>
                    </div>
                    <div class="field">
                        <select name="categoryIdTwo" id="" class="input w50">
                            <c:forEach items="${types}" var="data" varStatus="1">
                                <%--三元表达式,如果obj.categoryIdTwo==data.id 则设为选中状态--%>
                                <option value="${data.id}" ${obj.categoryIdTwo==data.id?"selected":""}>${data.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label">
                        <label>商品主图:</label>
                    </div>
                    <div class="field">
                        <input type="file" class="input w50" name="file" >
                        <div class="tips"><img src="${obj.url1}" alt="${obj.url1}"></div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label">
                        <label>商品副图1:</label>
                    </div>
                    <div class="field">
                        <input type="file" class="input w50" name="file" >
                        <div class="tips"><img src="${obj.url2}" alt="${obj.url2}"></div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label">
                        <label>商品副图2:</label>
                    </div>
                    <div class="field">
                        <input type="file" class="input w50" name="file" >
                        <div class="tips"><img src="${obj.url3}" alt="${obj.url3}"></div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label">
                        <label>商品副图3:</label>
                    </div>
                    <div class="field">
                        <input type="file" class="input w50" name="file" >
                        <div class="tips"><img src="${obj.url4}" alt="${obj.url4}"></div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label">
                        <label>商品副图4:</label>
                    </div>
                    <div class="field">
                        <input type="file" class="input w50" name="file" >
                        <div class="tips"><img src="${obj.url5}" alt="${obj.url5}"></div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label">
                        <label>商品描述:</label>
                    </div>
                    <div class="field">
                        <%--富文本上传--%>
                        <script type="text/plain" id="remark_txt_1" name="ms" style="width: 100%;height: 300px;">${obj.ms}</script>
                            <script type="text/javascript">
                                var editor = UE.getEditor('remark_txt_1');
                                UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
                                UE.Editor.prototype.getActionUrl = function (action) {
                                if(action == 'uploadimage' || action == 'uploadscrawl' || action == 'uploadvideo'){
                                return '${ctx}/ueditor/saveFile';
                            }else{
                                return this._bkGetActionUrl.call(this,action);
                            }
                            }
                            </script>
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
