<%@page contentType="text/html" %>
<%@page pageEncoding="UTF-8" %>
<%@include file="/common/common.jspf" %>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>buyorder.jsp</title>
    <script type="text/javascript">
        $(function () {
            var win = parent.$("iframe[title='商品入库']").get(0).contentWindow; //返回ifram页面文档（window)
            var rowIndex = undefined;
            $('#dg').datagrid({
                //单个条件分页查询
                //url: '${proPath}/supplier/selectPage.action',
                //多个条件分页查询
                //url: '${proPath}/supplier/selectPageUseDyc.action',
                striped: true,
                fitColumns: true,
                //pageSize: 10,
                //pagination: true,
                //pageList: [2, 5, 10, 15, 20],
                //rownumbers: true,
                loadMsg: 'loading...',
                //设定是否换行显示数据， true为不换行
                nowrap: true,
                //指定主键字段
                //idField: 'goodsId',
                toolbar: [{
                    iconCls: 'icon-add',
                    text: '添加商品',
                    handler: function () {
                        parent.$('#win').window({
                            width: 610,
                            height: 340,
                            modal: true,
                            title: '添加商品',
                            minimizable: false,
                            maximizable: false,
                            collapsible: false,
                            content: "<iframe src='${proPath}/base/goURL/buyorder/selectGoods.action' height='100%' width='100%' frameborder='0' ></iframe>"
                        });
                    }
                }, '-', {
                    iconCls: 'icon-edit',
                    text: '删除商品',
                    handler: function () {
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
                        parent.$.messager.confirm('删除对话框', '您确认要删除吗？', function (r) {
                            if (r) {
                                //前台静态删除存在index问题，采用倒删除index模式
                                for (var i = rows.length - 1; i >= 0; i--) {
                                    var index = $('#dg').datagrid('getRowIndex', rows[i]);
                                    //alert(index);
                                    $('#dg').datagrid('deleteRow', index);
                                }
                                $('#dg').datagrid('clearChecked');
                            }
                        });
                    }
                }, '-', {
                    iconCls: 'icon-remove',
                    text: '商品入库',
                    handler: function () {
                        var data = $('#dg').datagrid('getData');
                        //alert(data);
                        //console.info(data);
                        var rows = data.rows;
                        //alert(rows);
                        //console.info(rows);
                        //alert(JSON.stringify(rows));
                        if (rows.length == 0) {
                            win.$.messager.show({
                                title: '操作提示',
                                msg: '未选择商品！！！',
                                timeout: 4000,
                                showType: 'slide'
                            });
                            return false;
                        }

                        $("#ff").form("enableValidation");
                        if ($("#ff").form("validate")) {
                            $('#ff').form('submit', {
                                url: '${proPath}/buyOrder/insert.action',
                                onSubmit: function (param) {
                                    param.rows = JSON.stringify(rows);
                                    return true;
                                },
                                success: function (count) {
                                    //可以定义为对应消息框
                                    if (count > 0) {
                                        win.$.messager.show({
                                            title: '操作提示',
                                            msg: '入库成功！！！---' + count + '条记录',
                                            timeout: 4000,
                                            showType: 'slide'
                                        });
                                    } else {
                                        win.$.messager.show({
                                            title: '操作提示',
                                            msg: '入库失败！！！',
                                            timeout: 4000,
                                            showType: 'slide'
                                        });
                                    }
                                }
                            });

                        }
                    }
                }],
                //建议加入商品编号
                columns: [
                    [
                        {field: 'rownumber', checkbox: true, align: 'center'},
                        {field: 'goodsId', title: '商品编号', width: 100},
                        {field: 'goodsName', title: '商品名称', width: 100},
                        {field: 'goodsType', title: '型号', width: 100},
                        {field: 'goodsUnit', title: '单位', width: 100},
                        {field: 'goodsColor', title: '颜色', width: 100},
                        {
                            field: 'bodAmount',
                            title: '数量',
                            width: 100,
                            editor: 'numberbox'
                        },
                        {
                            field: 'bodBuyPrice',
                            title: '进价（元）',
                            width: 100,
                            editor: {type: 'numberbox', options: {precision: 2}}
                        },
                        {
                            field: 'bodTotalPrice',
                            title: '总价（元）',
                            width: 100
                            //editor: {type: 'numberbox', options: {precision: 2}}
                        },
                        {field: 'bodImeiList', title: '串号', width: 100, align: 'right', editor: 'textarea'}
                    ]
                ],
                //双击单元格编辑
                onDblClickCell: function (index, field, value) {
                    if (rowIndex != undefined) {
                        var ed = $('#dg').datagrid('getEditor', {index: rowIndex, field: 'bodAmount'});
                        var bodAmount = $(ed.target).numberbox('getValue');
                        //alert(bodAmount);
                        var ed = $('#dg').datagrid('getEditor', {index: rowIndex, field: 'bodBuyPrice'});
                        var bodBuyPrice = $(ed.target).numberbox('getValue');
                        //计算修改后的总价
                        var bodTotalPrice = $.trim(bodAmount) * $.trim(bodBuyPrice);
                        var ed = $('#dg').datagrid('getEditor', {index: rowIndex, field: 'bodTotalPrice'});
                        $(ed.target).numberbox('setValue', bodTotalPrice);
                        $('#dg').datagrid('endEdit', rowIndex);
                        rowIndex = undefined;
                    }
                    $('#dg').datagrid('beginEdit', index);
                    var ed = $('#dg').datagrid('getEditor', {index: index, field: field});
                    rowIndex = index;
                },
                //单击结束单元格编辑
                onClickCell: function (index, field, value) {
                    if (rowIndex != undefined) {
                        var ed = $('#dg').datagrid('getEditor', {index: rowIndex, field: 'bodAmount'});
                        var bodAmount = $(ed.target).numberbox('getValue');
                        //alert(bodAmount);
                        var ed = $('#dg').datagrid('getEditor', {index: rowIndex, field: 'bodBuyPrice'});
                        var bodBuyPrice = $(ed.target).numberbox('getValue');
                        //计算修改后的总价
                        var bodTotalPrice = $.trim(bodAmount) * $.trim(bodBuyPrice);
                        //var ed = $('#dg').datagrid('getEditor', {index: rowIndex, field: 'bodTotalPrice'});
                        //$(ed.target).numberbox('setValue', bodTotalPrice);
                        $('#dg').datagrid('endEdit', rowIndex);
                        $('#dg').datagrid('updateRow', {
                            index: rowIndex,
                            row: {
                                bodTotalPrice: Number(bodTotalPrice).toFixed(2)//保留总价两位小数
                            }
                        });
                        rowIndex = undefined;
                    }
                }
            });

            $("#ff").form("disableValidation");
            $('#supName').searchbox({
                editable: false,
                searcher: function (value, name) {
                    parent.$('#win').window({
                        width: 800,
                        height: 500,
                        modal: true,
                        title: '选择供应商',
                        minimizable: false,
                        maximizable: false,
                        collapsible: false,
                        content: "<iframe src='${proPath}/base/goURL/buyorder/selectSupplier.action' height='100%' width='100%' frameborder='0' ></iframe>"
                    });
                },
                prompt: '请输入供应商名称'
            });
            var box = $('#supName').searchbox('textbox');//获取搜索框文本框对象
            box.attr('disabled', true);// 禁用文本框输入

            /* 数组转json
             * @param array 数组
             * @param type 类型 json array
             */
            function formatArray(array, type) {
                var dataArray = {};
                $.each(array, function () {
                    if (dataArray[this.name]) {
                        if (!dataArray[this.name].push) {
                            dataArray[this.name] = [dataArray[this.name]];
                        }
                        dataArray[this.name].push(this.value || '');
                    } else {
                        dataArray[this.name] = this.value || '';
                    }
                });
                return ((type == "json") ? JSON.stringify(dataArray) : dataArray);
            }
        });
    </script>
</head>
<!--bo_id                varchar(36) not null,
sup_id               int,
sh_id                varchar(10),
bo_date              date,
bo_payable           decimal(12,2),
bo_paid              decimal(12,2),
bo_arrears           decimal(12,2),
bo_original          varchar(20),
bo_remark            varchar(100),
bo_attn              varchar(20),
bo_operator          int,
primary key (bo_id)-->
<body class="mybody">
<form class="myfm" style="padding:10px;margin:0px;background:#eee;" id="ff" method="post">
    <div class="myftitle">请填写采购信息</div>
    <div class="myfitem2">
        <label>供应商：</label><input id="supName" class="easyui-searchbox" name="supName"/>
        <input type="hidden" id="supId" name="supId"/>
        <label>仓库类型：</label><select id="cc"
                                               class="easyui-combobox" name="shId">
        <c:forEach items="${applicationScope.sysParam.shId}"
                   var="sh">
            <option value="${sh.key}">${sh.key}--${sh.value}</option>
        </c:forEach>
    </select>
        <label>日期：</label><input type="text" id="boDate"
                                 class="easyui-datebox" name="oldBoDate" required="required"/>
    </div>

    <div class="myfitem2">
        <label> 应付：</label><input type="text" id="boPayable" name="boPayable"/>
        <label>已付：</label><input type="text" id="boPaid" name="boPaid"/>
        <label>欠款：</label><input type="text" id="boArrears" name="boArrears"/>
    </div>

    <div class="myfitem2">

        <label>原始单号：</label><input type="text" id="boOriginal" name="boOriginal"/>
        <label>经手人：</label><input type="text" id="boAttn" name="boAttn"/>
        <label>操作员：</label><input type="text" id="boOperator" name="boOperator"/>
    </div>

    <div class="myfitem2">
        <label>备注：</label><input type="text" id="boRemark" name="boRemark"/>
    </div>
</form>
<table id="dg"></table>
</body>

</html>