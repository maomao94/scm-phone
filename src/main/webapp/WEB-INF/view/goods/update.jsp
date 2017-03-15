<%@page contentType="text/html" %>
<%@page pageEncoding="UTF-8" %>
<%@include file="/common/common.jspf" %>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>update.jsp</title>
</head>

<body class="mybody">
<form id="ff" method="post" class="myfm">
    <div class="myftitle">请修改商品信息</div>
    <div class="myfitem">
        <div>
            <label for="goodsId">商品编号:</label> <input class="easyui-textbox" data-options="readonly: true"
                                                      name="goodsId"/>
        </div>
        <div>
            <label for="goodsName">商品名称:</label> <input class="easyui-textbox" data-options="required: true"
                                                        name="goodsName">
        </div>
        <div>
            <label for="goodsUnit">商品单位:</label> <input class="easyui-textbox" data-options="required: true"
                                                        name="goodsUnit"/>
        </div>
        <div>
            <label for="goodsType">类型:</label> <input class="easyui-textbox" data-options="required: true"
                                                      name="goodsType"/></div>
        <div>
            <label for="goodsColor">颜色:</label> <input class="easyui-textbox" data-options="required: true"
                                                       name="goodsColor"/>
        </div>
        <div>
            <label for="goodsStore">库存下限:</label> <input class="easyui-textbox" data-options="required: true"
                                                         name="goodsStore"/>
        </div>
        <div>
            <label for="goodsLimit">修改时间:</label> <input class="easyui-textbox" data-options="required: true"
                                                         name="goodsLimit"/>
        </div>
        <div>
            <label for="goodsCommission">提成:</label> <input class="easyui-textbox" data-options="required: true"
                                                            name="goodsCommission"/>
        </div>
        <div>
            <label for="goodsProducer">生产商:</label> <input class="easyui-textbox" data-options="required: true"
                                                           name="goodsProducer"/>
        </div>
        <div>
            <label for="goodsSelPrice">售价:</label> <input class="easyui-textbox" data-options="required: true"
                                                          name="goodsSelPrice"/>
        </div>
        <div>
            <label for="goodsBuyPrice">进价:</label> <input class="easyui-textbox" data-options="required: true"
                                                          name="goodsBuyPrice"/>
        </div>
        <div>
            <label for="goodsRemark">备注:</label>
            <input class="easyui-textbox" data-options="multiline:'true'" name="goodsRemark"/>
        </div>
        <div>
            <a id="btn_ok" class="easyui-linkbutton" data-options="">提交</a>
            <a id="btn_cancel" class="easyui-linkbutton" data-options="">取消</a>
        </div>
    </div>
</form>

<script type="text/javascript">
    $(function () {
        var win = parent.$("iframe[title='商品管理']").get(0).contentWindow; //返回ifram页面文档（window)
        var row = win.$('#dg').datagrid('getSelected');
        $('#ff').form('load', {
            goodsId: row.goodsId,
            goodsName: row.goodsName,
            goodsUnit: row.goodsUnit,
            goodsType: row.goodsType,
            goodsColor: row.goodsColor,
            goodsStore: row.goodsStore,
            goodsLimit: row.goodsLimit,
            goodsCommission: row.goodsCommission,
            goodsProducer: row.goodsProducer,
            goodsSelPrice: row.goodsSelPrice,
            goodsBuyPrice: row.goodsBuyPrice,
            goodsRemark: row.goodsRemark
        });

        $("#ff").form("disableValidation");

        $("#btn_ok").click(function () {
            $("#ff").form("enableValidation");
            if ($("#ff").form("validate")) {
                $('#ff').form('submit', {
                    url: '${proPath}/goods/update',
                    onSubmit: function () {
                        return true;
                    },
                    success: function (count) {
                        //可以定义为对应消息框
                        if (count > 0) {
                            win.$.messager.show({
                                title: '操作提示',
                                msg: '更新成功！！！---' + count + '条记录',
                                timeout: 4000,
                                showType: 'slide'
                            });
                        } else {
                            win.$.messager.show({
                                title: '操作提示',
                                msg: '更新失败！！！',
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