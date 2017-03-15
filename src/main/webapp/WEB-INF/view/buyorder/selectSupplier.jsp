<%@page contentType="text/html" %>
<%@page pageEncoding="UTF-8" %>
<%@include file="/common/common.jspf" %>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>supplierList.jsp</title>
    <script type="text/javascript">
        $(function () {
            var win = parent.$("iframe[title='商品入库']").get(0).contentWindow; //返回ifram页面文档（window)
            $('#dg').datagrid({
                //单个条件分页查询
                //url: '${proPath}/supplier/selectPage.action',
                //多个条件分页查询
                url: '${proPath}/supplier/selectPageUseDyc.action',
                striped: true,
                fitColumns: true,
                idField: 'supId',
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
                        var row = $('#dg').datagrid('getSelected');
                        if (row == null) {
                            $.messager.show({
                                title: '操作提示',
                                msg: '请选择供应商！！！',
                                timeout: 4000,
                                showType: 'slide'
                            });
                            return false;
                        }
                        win.$('#ff').form(
                            'load', {supId: row.supId, supName: row.supName}
                        );
                        parent.$('#win').window('close');
                    }
                }, '-', {
                    text: "<input id='supName' data-options='width:150' name='supName'>"
                }, {
                    text: "<input id='supAddress' data-options='width:150' name='supAddress'>"
                }],
                columns: [
                    [{
                        field: 'rownumber',
                        checkbox: true,
                        align: 'center'
                    }, {
                        field: 'supId',
                        title: '供应商编号',
                        width: 100,
                        align: 'center'
                    },
                        {
                            field: 'supName',
                            title: '供应商名称',
                            width: 100,
                            align: 'center'
                        },
                        {
                            field: 'supLinkman',
                            title: '联系人',
                            width: 100,
                            align: 'center'
                        },
                        {
                            field: 'supAddress',
                            title: '联系地址',
                            width: 100,
                            align: 'center'
                        },
                        {
                            field: 'supPay',
                            title: '期初应付',
                            width: 100,
                            align: 'center'
                        }, {
                        field: 'supType',
                        title: '供应商类型',
                        width: 100,
                        align: 'center'
                    }
                    ]
                ]
            });

            $('#supName').searchbox({
                searcher: function (value, name) {
                    $('#dg').datagrid('load', {
                        supAddress: likeParam($('#supAddress').val()),
                        supName: likeParam(value)
                    });
                },
                prompt: '请输入供应商名称'
            });
            $('#supAddress').searchbox({
                searcher: function (value, name) {
                    $('#dg').datagrid('load', {
                        supName: likeParam($('#supName').val()),
                        supAddress: likeParam(value)
                    });
                },
                prompt: '请输入供应商地址'
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
</body>

</html>