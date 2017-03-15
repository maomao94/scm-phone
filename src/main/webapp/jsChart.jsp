<%--
  Created by IntelliJ IDEA.
  User: 28773
  Date: 2017/3/11
  Time: 16:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/common.jspf" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Title</title>
    <script type="text/javascript">
        $(function () {
            var myData = new Array(["商品1", 20], ["商品2", 10], ["商品3", 30], ["商品4", 10],
                ["商品5", 5]);
            var myChart = new JSChart('chartcontainer', 'line');
            //myChart.setDataArray(myData);//通过js数组显示数据
            //myChart.setDataJSON("data.json");//通过json显示数据
            myChart.setDataXML("data.xml");
            myChart.draw();
        })
    </script>
</head>
<body>
<div id="chartcontainer">这里将用来显示图形报表</div>
</body>
</html>
