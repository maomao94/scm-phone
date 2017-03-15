<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="/common/common.jspf"%>
<!DOCTYPE html>
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>首页</title>
		<script type="text/javascript">
			$(function() {
				$('a[title]').click(function() {
					var title = this.title;
					var href = this.href;
					//判断选项是否存在
					if($('#tt').tabs('exists', title)) {
						$('#tt').tabs('select', title)
					} else {
						$('#tt').tabs('add', {
							title: title,
							selected: true,
							content: 909090,
							closable: true,
							content: "<iframe src='" + href + "' title='" + this.title + "' height='100%' width='100%' frameborder='0' ></iframe>"
						});
					}
					return false;
				});

			});
		</script>

	</head>

	<body class="easyui-layout">
		<div data-options=" region: 'north',title: '手机进销存系统',collapsible:false" style="height:50px; ">欢迎您：${sessionScope.account.accLogin}</div>
		<div data-options="region:'south',title:'软件版权或公司联系信息',collapsible:false" style="height:20px;"></div>
		<div data-options="region:'east',collapsible:false,iconCls:'icon-reload',title:'公告或新闻'" style="width:120px;"></div>
		<div data-options="region: 'west',iconCls: 'icon-reload',title: '导航菜单'" style="width:125px; ">
			<div id="aa" class="easyui-accordion" style="width:120px;height:200px;">
				<div title="数据录入" data-options="" style="overflow:auto;padding:10px;">
					<ul style="list-style: none;padding: 0px;margin:0px;">
						<li style="padding: 6px;">
							<a class="easyui-linkbutton" button href="${proPath}/base/goURL/supplier/supplierList.action" title="供应商管理" style="font-weight: bold;">供应商管理</a>
						</li>
						<li style="padding: 6px;">
							<a class="easyui-linkbutton" href="${proPath}/base/goURL/goods/goodsList.action" title="商品管理" style="font-weight: bold;">商品管理</a>
						</li>
					</ul>
				</div>
				<div title="入库管理" data-options="" style="overflow:auto;padding:10px;">
					<ul style="list-style: none;padding: 0px;margin:0px;">
						<li style="padding: 6px;">
							<a class="easyui-linkbutton" href="${proPath}/base/goURL/buyorder/buyOrderList.action" title="商品入库" style="font-weight: bold;">商品入库</a>
						</li>
					</ul>
				</div>
				<div title="出库管理" style="overflow:auto;padding:10px;">
					<ul style="list-style: none;padding: 0px;margin:0px;">
						<li style="padding: 6px;">
							<a class="easyui-linkbutton" href="${proPath}/base/goURL/buyorder/buyOrderList.action" title="商品出库" style="font-weight: bold;">商品出库</a>
						</li>
					</ul>
				</div>
				<div title="报表管理" style="overflow:auto;padding:10px;">
					<ul style="list-style: none;padding: 0px;margin:0px;">
						<li style="padding: 6px;">
							<a class="easyui-linkbutton" href="${proPath}/base/goURL/datareport/selectSupplierPayable.action" title="供应商报表" style="font-weight: bold;">供应商报表</a>
						</li>
					</ul>
				</div>
			</div>
		</div>

		<div data-options="region: 'center',title: '主要内容' " style="padding:2px;background:#eee; ">
			<div id="tt" data-options="fit:true" class="easyui-tabs" style="width:500px;height:250px;">
				<div title="系统简介" data-options="" style="">手机进销存</div>
			</div>
		</div>

		<div id="win"></div>
	</body>

</html>