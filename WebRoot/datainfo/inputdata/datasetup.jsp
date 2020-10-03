<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page contentType="text/html;charset=utf-8"%>
<!-- javabean:predata 历史数据集-->
<jsp:useBean id="predata" class="system.HistoryData" scope="session"></jsp:useBean>
<jsp:useBean id="readtable" class="system.ReadTable" scope="application"></jsp:useBean>
<%
 String number1 = request.getParameter("number");
number1 = request.getParameter("number");
%>

<html>
	<head>
		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/table.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/inputdata.css">
		<script type="text/javascript" src="../../JS/button/validate_datasetup.js" 
		charset="gb2312"></script>
	</head>
	
	<body>
	<%	if(request.getParameter("number")==null)		//只有触发时才启动页面显示
		{%>
 			<div class="subtitle">暂无结果显示</div>
 	<%	}
 		else
 		{
 			java.text.DecimalFormat df = new java.text.DecimalFormat("#.00");	//定义数字格式
			int number = Integer.parseInt(request.getParameter("number"));	//提取数据长度
			int dimension = Integer.parseInt(request.getParameter("dimension"));//提取数据维度
			double[][] data = new double[number][dimension];
			String[] columnName=readtable.getColumnName();//获得列名
			for(int i = 0; i < number; i++)		//提取数据
			{
				for(int j=0; j<dimension; j++)
				{
					data[i][j] = Double.parseDouble(request.getParameter(
									"data_" + String.valueOf(i+1) + "_"+String.valueOf(j+1)));
					data[i][j] = Double.parseDouble(df.format(data[i][j])); //将数据保留两位小数
				}
			}
		%>
			<div class="subtitle">数据导入设置</div>
			<form action="input.jsp" method="post"
			target="MAIN" onsubmit="return validate_datasetup(this);">
				<div class="inputdatasetup">
					<div class="inputdatasetup_title">数据名称：</div>
					<div class="inputdatasetup_content">
						<input type="text" name="data_name" autocomplete="off"
							style="width:200px">
						(10个字以内)
					</div>
					<div class="inputdatasetup_title">数据类型：</div>
					<div class="inputdatasetup_content">
						<select name="data_type">
							<option value="0">经典模型失效数据</option>
							<option value="1">SOA模型失效数据</option>
						</select>
					</div>
					<div class="inputdatasetup_title">测试集比例:</div>
					<div class="inputdatasetup_content">
						<select name="data_testpercentage">
							<option value="0">0%</option>
							<option value="5">5%</option>
							<option value="10" selected>10%</option>
							<option value="15">15%</option>
							<option value="20">20%</option>
							<option value="25">25%</option>
							<option value="30">30%</option>
						</select>
					</div>
					<div class="inputdatasetup_title" style="height:15%">
						数据描述：<br>(100个字以内)
					</div>
					<div class="inputdatasetup_content" style="height:15%">
						<textarea name="data_description" cols="40" rows="3"></textarea>
					</div>
					<div class="inputdatasetup_scrollbox">
						<table>
							<caption><b>数据总数：<%= number%></b></caption>
							<tr>
								<th>序号</th>
							<%	for(int i=1;i<=dimension;i++)
								{%>
									<th>
										<input type="text" 
										name="colname<%= String.valueOf(i)%>" 
										id="colname<%= String.valueOf(i)%>" 
										value="序列<%= String.valueOf(i)%>"
										autocomplete="off">
										 
									</th>
							<%	}%>
							 <%-- <%	for(int i=1;i<= dimension;i++)
								{%>
								<th>
										<input type="text" 
										<%= columnName[i] %>
										autocomplete="off">
										</th>
								<%	}%>  --%>
							</tr>
						<%	for(int i=0;i<number;i++)
							{%>
								<tr>
									<td><%= i+1%></td>
								<%	for(int j=0;j<dimension;j++)
									{%>
										<td><%= data[i][j]%></td>
								<%	}%>
								</tr>
						<%	}%>
						</table>
					</div>
				<%	for(int i=1; i<=number; i++)
					{
						for(int j=1; j<=dimension; j++)
						{%>
							<input type="hidden" 
								name="data_<%= String.valueOf(i)%>_<%= String.valueOf(j)%>" 
								value="<%= data[i-1][j-1]%>">
					<%	}
					}%>
					<input type="hidden" name="flag" value="1">
					<input type="hidden" name="number" value="<%= number%>">
					<input type="hidden" name="dimension" value="<%= dimension%>">
					<input type="submit" class="button" value="导入">
					<input type="reset" class="button" value="重置">
				</div>
			</form>
 	<%}%>
	</body>
</html>
