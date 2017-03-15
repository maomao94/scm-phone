<%@page contentType="text/html" %>
<%@page pageEncoding="UTF-8" %>
<%@include file="/common/common.jspf" %>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>goodsList.jsp</title>
    <script type="text/javascript">
        $(function () {
            var win = parent.$("iframe[title='商品入库']").get(0).contentWindow; //返回ifram页面文档（window)
            $('#dg').datagrid({
                //单个条件分页查询
                //url: '${proPath}/supplier/selectPage.action',
                //多个条件分页查询
                url: '${proPath}/goods/selectPageUseDyc.action',
                striped: true,
                fitColumns: true,
                idField: 'goodsId',
                pageSize: 10,
                pagination: true,
                pageList: [2, 5, 10, 15, 20],
                rownumbers: true,
                singleSelect: true,
                loadMsg: 'loading...',
                toolbar: [{
                    iconCls: 'icon-ok',
                    text: '确定',
                    handler: function () {
                        $("#ff").form("enableValidation");
                        if ($("#ff").form("validate")) {
                            var row = $('#dg').datagrid('getSelected');
                            if (row == null) {
                                $.messager.show({
                                    title: '操作提示',
                                    msg: '请选择商品！！！',
                                    timeout: 4000,
                                    showType: 'slide'
                                });
                                return false;
                            }
                            win.$('#dg').datagrid('appendRow', {
                                goodsId: row.goodsId,
                                goodsName: row.goodsName,
                                goodsType: row.goodsType,
                                goodsUnit: row.goodsUnit,
                                goodsColor: row.goodsColor,
                                bodAmount: $('#bodAmount').val(),
                                bodBuyPrice: $('#bodBuyPrice').val(),
                                bodTotalPrice: $('#bodAmount').val() * $('#bodBuyPrice').val(),
                                bodImeiList: $('#bodImeiList').val()
                            });
                            parent.$('#win').window('close');
                        }
                    }
                }, '-',
                    {
                        text: "<input id='goodsName' data-options='width:150' name='goodsName'>"
                    }
                ],
                columns: [
                    [{
                        field: 'rownumber',
                        checkbox: true,
                        align: 'center'
                    }, {
                        field: 'goodsId',
                        title: '商品编号',
                        width: 100,
                        align: 'center'
                    }, {
                        field: 'goodsName',
                        title: '商品名称',
                        width: 100,
                        align: 'center'
                    }, {
                        field: 'goodsUnit',
                        title: '商品单位',
                        width: 100,
                        align: 'center'
                    }, {
                        field: 'goodsType',
                        title: '商品类型',
                        width: 100,
                        align: 'center'
                    }, {
                        field: 'goodsColor',
                        title: '商品颜色',
                        width: 100,
                        align: 'center'
                    }]
                ]
            });

            $("#ff").form("disableValidation");
            $('#goodsName').searchbox({
                searcher: function (value, name) {
                    $('#dg').datagrid('load', {
                        goodsName: likeParam(value)
                    });
                },
                prompt: '请输入商品名称'
            });
        });

        //过滤后台分页查询null 空字符串问题
        function likeParam(value) {
            if (value == "") {
                return "";
            } else {
                return '%' + value + '%';
            }
        }
    </script>
</head>

<body class="mybody">
<table id="dg"></table>
<form id="ff" method="post">
    <div class="myfitem">
        <div>
            数量：<input id='bodAmount' class='easyui-textbox' data-options='required:true' style='width: 120px;'>
        </div>
        <div>
            进价：<input id='bodBuyPrice' class='easyui-textbox' data-options='required:true' style='width: 120px;'>
        </div>
        <div>
            串号：<input id='bodImeiList' class='easyui-textbox' data-options='required:true' style='width: 120px;'>
        </div>
    </div>
</form>
</body>

</html>