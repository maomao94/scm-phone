<%@page contentType="text/html" %>
<%@page pageEncoding="UTF-8" %>
<%@include file="/common/common.jspf" %>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>insert.jsp</title>
</head>

<body class="mybody">
<form id="ff" method="post" class="myfm">
    <div class="myftitle">请修改供应商信息</div>
    <div class="myfitem">
        <div>
            <label for="supId">供应商编号:</label>
            <input class="easyui-textbox"
                   data-options="required: true,missingMessage: '请填写供应商编号！'"
                   name="supId"/>
        </div>
        <div>
            <label for="supName">供应商:</label>
            <input class="easyui-textbox"
                   data-options="required: true,missingMessage: '请填写供应商！'"
                   name="supName">
        </div>
        <div>
            <label for="supLinkman">联系人:</label>
            <input class="easyui-textbox"
                   data-options="required: true,missingMessage: '请联系人！'"
                   name="supLinkman"/>
        </div>
        <div>
            <label for="supPhone">联系电话:</label>
            <input class="easyui-textbox"
                   data-options="required: true,missingMessage: '请填写联系电话！'"
                   name="supPhone"/></div>
        <div>
            <label for="supAddress">联系地址:</label>
            <input class="easyui-textbox"
                   data-options="required: true,missingMessage: '请填写联系地址！'"
                   name="supAddress"/>
        </div>
        <div>
            <label for="supPay">期初应付:</label>
            <input class="easyui-textbox" name="supPay"/>
        </div>
        <div>
            <label for="supType">供应商类型：</label>
            <select id="cc" class="easyui-combobox" data-options="required: true,missingMessage: '请填写供应商类型！'"
                    name="supType"
                    style="width:200px;">
                <c:forEach items="${applicationScope.sysParam.supType}" var="supType">
                    <option value="${supType.key}">${supType.value}</option>
                </c:forEach>
            </select>
        </div>
        <div>
            <label for="supRemark">备注:</label>
            <input class="easyui-textbox" data-options="multiline:'true'" name="supRemark"/>
        </div>
        <div>
            <a id="btn_ok" class="easyui-linkbutton" data-options="">提交</a>
            <a id="btn_cancel" class="easyui-linkbutton" data-options="">取消</a>
        </div>
    </div>
</form>


<script type="text/javascript">
    $(function () {
        var win = parent.$("iframe[title='供应商管理']").get(0).contentWindow; //返回ifram页面文档（window)

        //禁用验证
        $("#ff").form("disableValidation");

        $("#btn_ok").click(function () {
            $("#ff").form("enableValidation");
            if ($("#ff").form("validate")) {
                $('#ff').form('submit', {
                    url: '${proPath}/supplier/insert',
                    onSubmit: function () {
                        return true;
                    },
                    success: function (count) {
                        //可以定义为对应消息框
                        if (count > 0) {
                            win.$.messager.show({
                                title: '操作提示',
                                msg: '增加成功！！！---' + count + '条记录',
                                timeout: 4000,
                                showType: 'slide'
                            });
                        } else {
                            win.$.messager.show({
                                title: '操作提示',
                                msg: '增加失败！！！',
                                timeout: 4000,
                                showType: 'slide'
                            });
                        }
                        parent.$("#win").window("close");
                        win.$("#dg").datagrid("reload");
                    }
                });

            }

        });

        $("#btn_cancel").click(function () {
            parent.$("#win").window("close");
        });
    });
</script>
</body>

</html>