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
            $('#dg').datagrid({
                //单个条件分页查询
                //url: '${proPath}/supplier/selectPage',
                //多个条件分页查询
                url: '${proPath}/supplier/selectPageUseDyc',
                striped: true,
                fitColumns: true,
                idField: 'supId',
                pageSize: 10,
                pagination: true,
                pageList: [2, 5, 10, 15, 20],
                rownumbers: true,
                loadMsg: 'loading...',
                toolbar: [{
                    iconCls: 'icon-add',
                    text: '新增供应商',
                    handler: function () {
                        parent.$('#win').window({
                            width: 600,
                            height: 400,
                            modal: true,
                            title: '新增供应商',
                            minimizable: false,
                            maximizable: false,
                            collapsible: false,
                            content: "<iframe src='${proPath}/base/goURL/supplier/insert' height='100%' width='100%' frameborder='0' ></iframe>"
                        });
                    }
                }, '-', {
                    iconCls: 'icon-edit',
                    text: '修改供应商',
                    handler: function () {
                        var rows = $('#dg').datagrid('getSelections');
                        if (rows.length != 1) {
                            $.messager.show({
                                title: '操作提示',
                                msg: '请选择一条记录！！！',
                                timeout: 4000,
                                showType: 'slide'
                            });
                            return false;
                        }
                        parent.$('#win').window({
                            width: 600,
                            height: 400,
                            modal: true,
                            title: '修改供应商',
                            minimizable: false,
                            maximizable: false,
                            collapsible: false,
                            content: "<iframe src='${proPath}/base/goURL/supplier/update' height='100%' width='100%' frameborder='0' ></iframe>"
                        });
                    }
                }, '-', {
                    iconCls: 'icon-remove',
                    text: '删除供应商',
                    handler: function () {
                        /**
                         * 1.获取选择行，判断是否有选择
                         * 2.获取行中记录id的数组
                         * 3.确认是否删除
                         * 4.提交删除请求
                         * 5.刷新列表
                         */
                        var rows = $('#dg').datagrid('getSelections');
                        if (rows.length == 0) {
                            $.messager.show({
                                title: '操作提示',
                                msg: '请先选择要删除的记录！！！',
                                timeout: 4000,
                                showType: 'slide'
                            });
                            return false;
                        }

                        var ids = new Array();
                        for (var i = 0; i < rows.length; i++) {
                            ids[i] = rows[i].supId;
                        }
                        parent.$.messager.confirm('删除对话框', '您确认要删除吗？', function (r) {
                            if (r) {
                                $.ajax({
                                    url: "${proPath}/supplier/delete",
                                    type: "POST",
                                    //设置为传统方式传送参数
                                    traditional: true,
                                    data: {pks: ids},
                                    success: function (html) {
                                        if (html > 0) {
                                            $.messager.show({
                                                title: '操作提示',
                                                msg: '删除成功！！！---' + i + '条记录',
                                                timeout: 4000,
                                                showType: 'slide'
                                            });
                                            //重新刷新页面
                                            $("#dg").datagrid("reload");
                                            //请除所有勾选的行
                                            $("#dg").datagrid("clearSelections");
                                        } else {
                                            $.messager.show({
                                                title: '操作提示',
                                                msg: '删除失败！！！',
                                                timeout: 4000,
                                                showType: 'slide'
                                            });
                                        }
                                    },
                                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                                        $.messager.alert('删除错误！！！', '请联系管理员！', 'error');
                                    },
                                    dataType: 'json'
                                });
                            }
                        });
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
                            field: 'supPhone',
                            title: '联系电话',
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
                        align: 'center',
                        formatter: function (value, row, index) {
                            //console.info(value);
                            return valueToText("${applicationScope.sysParam.supType}", value);
                        }
                    }, {
                        field: 'supRemark',
                        title: '备注',
                        width: 100,
                        align: 'center',
                        formatter: function (value, row, index) {
                            return "<span title='" + value + "'>" + value + "</span>";
                        }
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

<body>
<table id="dg"></table>
</body>

</html>