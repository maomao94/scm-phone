<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="/common/common.jspf"%>
<!DOCTYPE html>
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>goodsList.jsp</title>
		<script type="text/javascript">
			$(function() {
				$('#dg').datagrid({
					//单个条件分页查询
					//url: '${proPath}/supplier/selectPage',
					//多个条件分页查询
					url: '${proPath}/goods/selectPageUseDyc',
					striped: true,
					fitColumns: true,
					idField: 'goodsId',
					pageSize: 10,
					pagination: true,
					pageList: [2, 5, 10, 15, 20],
					rownumbers: true,
					loadMsg: 'loading...',
					toolbar: [{
						iconCls: 'icon-add',
						text: '新增商品',
						handler: function() {
							parent.$('#win').window({
								width: 600,
								height: 500,
								modal: true,
								title: '新增商品',
								minimizable: false,
								maximizable: false,
								collapsible: false,
								content: "<iframe src='${proPath}/base/goURL/goods/insert' height='100%' width='100%' frameborder='0' ></iframe>"
							});
						}
					}, '-', {
						iconCls: 'icon-edit',
						text: '修改商品',
						handler: function() {
							var rows = $('#dg').datagrid('getSelections');
							if(rows.length != 1) {
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
								height: 500,
								modal: true,
								title: '修改商品',
								minimizable: false,
								maximizable: false,
								collapsible: false,
								content: "<iframe src='${proPath}/base/goURL/goods/update' height='100%' width='100%' frameborder='0' ></iframe>"
							});
						}
					}, '-', {
						iconCls: 'icon-remove',
						text: '删除商品',
						handler: function() {
							/**
							 * 1.获取选择行，判断是否有选择
							 * 2.获取行中记录id的数组
							 * 3.确认是否删除
							 * 4.提交删除请求
							 * 5.刷新列表
							 */
							var rows = $('#dg').datagrid('getSelections');
							if(rows.length == 0) {
								$.messager.show({
									title: '操作提示',
									msg: '请先选择要删除的记录！！！',
									timeout: 4000,
									showType: 'slide'
								});
								return false;
							}

							var ids = new Array();
							for(var i = 0; i < rows.length; i++) {
								ids[i] = rows[i].goodsId;
							}
							parent.$.messager.confirm('删除对话框', '您确认要删除吗？', function(r) {
								if(r) {
									$.ajax({
										url: "${proPath}/goods/delete",
										type: "POST",
										//设置为传统方式传送参数
										traditional: true,
										data: { pks: ids },
										success: function(html) {
											if(html > 0) {
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
										error: function(XMLHttpRequest, textStatus, errorThrown) {
											$.messager.alert('删除错误！！！', '请联系管理员！', 'error');
										},
										dataType: 'json'
									});
								}
							});
						}
					}, '-', {
						text: "<input id='goodsName' data-options='width:150' name='goodsName'>"
					}],
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
						}, {
							field: 'goodsStore',
							title: '商品库存下限',
							width: 100,
							align: 'center'
						}, {
							field: 'goodsLimit',
							title: '修改时间',
							width: 100,
							align: 'center'
						}, {
							field: 'goodsCommission',
							title: '商品提成',
							width: 100,
							align: 'center'
						}, {
							field: 'goodsProducer',
							title: '商品生产商',
							width: 100,
							align: 'center'
						}, {
							field: 'goodsSelPrice',
							title: '商品售价',
							width: 100,
							align: 'center'
						}, {
							field: 'goodsBuyPrice',
							title: '商品进价',
							width: 100,
							align: 'center'
						}, {
							field: 'goodsRemark',
							title: '备注',
							width: 100,
							align: 'center'
						}]
					]
				});

				$('#goodsName').searchbox({
					searcher: function(value, name) {
						$('#dg').datagrid('load', {
							goodsName: likeParam(value)
						});
					},
					prompt: '请输入商品名称'
				});
			});

			//过滤后台分页查询null 空字符串问题
			function likeParam(value) {
				if(value == "") {
					return "";
				} else {
					return '%' + value + '%';
				}
			}
		</script>
	</head>

	<body style="width: 100%;height: 100%">
		<table id="dg"></table>
	</body>

</html>