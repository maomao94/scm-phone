<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="/common/common.jspf"%>
<!DOCTYPE html>
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>手机进销存系统(Alpha)</title>
		<script type="text/javascript">
			$(function() {
				$('#dd').dialog({
					title: '登陆',
					width: 250,
					height: 250,
					closed: false,
					cache: false,
					//href: 'get_content.php',
					modal: true,
					buttons: [{
						text: '登录',
						handler: function() {
							$('#ff').form('enableValidation');
							if($('#ff').form('validate')) {
								$('#ff').submit();
							}
						}
					}, {
						text: '重置',
						handler: function() {
							$('#ff').form('reset');
						}
					}]
				});

				$('#ff').form('disableValidation');
			});
		</script>

	</head>

	<body style="width: 100%;height: 100%">
		<div id="dd" style="" align="center">
			<form id="ff" action="${proPath}/account/login" method="post">
				<div style="padding: 20px;">
					<input name="accLogin" class="easyui-textbox" data-options="iconCls:'icon-man',required:true,prompt:'请输入登录名',iconAlign:'left',height:30" style="width:180px;" />
				</div>
				<div style="padding: 20px;">
					<input name="accPass" class="easyui-textbox" data-options="iconCls: 'icon-lock',required:true,prompt:'请输入密码',iconAlign:'left',height:30,type:'password'" style="width:180px;" />
				</div>
				<div style="color: red">${requestScope.errmsg}</div>
			</form>
		</div>
	</body>

</html>