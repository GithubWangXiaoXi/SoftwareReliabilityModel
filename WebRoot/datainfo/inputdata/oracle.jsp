<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<!-- javabean:readtable读表数据-->
<jsp:useBean id="readtable" class="system.ReadTable" scope="application"></jsp:useBean>
<%
	String mode = request.getParameter("mode");	//提取数据模式
	String database = request.getParameter("tablename");
	String tablename = request.getParameter("realtablename");		//提取表名
	//System.out.println(database+tablename);
	String user = request.getParameter("user");	//提取用户名
	String password = request.getParameter("password");	//提取密码
	String choseDataBase = request.getParameter("choseDataBase");	//提取密码
	//String dimension = request.getParameter("dimension");	//提取列数
	//String sum = request.getParameter("sum");	//提取条数
%>

<html>
	<head>
		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/table.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/button/validate_dataformat.js" 
		charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/input.js" charset="gb2312"></script>
	</head>

	<body onload="input_next('<%= mode%>');">
		<div class="subtitle">从数据表： <%=tablename%> 导入数据</div>
	<%	if(tablename!=null){
	
		int columncount=readtable.readtable2(tablename,user,password,choseDataBase,database);//返回列数
		String[][] readdata=readtable.getreaddata();
		String[] columnName=readtable.getColumnName();//获得列名
		System.out.print("获得的列名：");
		for(int w=0;w<columnName.length;w++){
		System.out.print(columnName[w]+" ");
		}
		System.out.println();
				System.out.println("表中总共有"+readdata.length+"条数据；共"+columncount+"列");
		%>
		<div class="scrollbox" align="center" style="height:80%;font-size:20px;">
					<table>
						<tr>
							<th>列名</th>
						<%	for(int i=0;i<columncount;i++)
							{%>
								<th style="font-size:20px">
								
								<%= columnName[i] %>
								</th>
						<%	}%>
						</tr>
						<tr>
							<th>选择</th>
						<%	for(int i=1;i<=columncount;i++)
							{%>
								<th>
									<input type="checkbox" name="check"
									value="<%= String.valueOf(i)%>">
								</th>
						<%	}%>
						</tr>
						<%	for(int i=0;i<readdata.length;i++)
							{%>
								<tr>
								<td><%= i+1%></td>
							<% 	for(int j=0;j<columncount;j++)
								{%>
									<td>
										<input type="text" style="font-size:18px;"
										id="predata_<%= String.valueOf(i+1)%>_<%= String.valueOf(j+1)%>"  
										value="<%= readdata[i][j]%>">
									</td>
							<%	}%>
								</tr>
						<%	}%>
						<tr>
							<th>截取</th>
							<th colspan="<%= columncount%>">
								从
								<select id="Interception_head" style="width:80px;height:30px; font-size: 18px" >
								<%	for(int i=1;i<=readdata.length;i++)
									{%>
										<option value="<%= String.valueOf(i)%>" 
										<%if(i==1) {%>selected<%}%>><%= i%></option>
								<%	}%>
								</select>
								至
								<select id="Interception_tail" style="width:80px;height:30px; font-size: 18px" >
								<%	for(int i=1;i<=readdata.length;i++)
									{%>
										<option value="<%= String.valueOf(i)%>" 
										<%if(i==readdata.length) {%>selected<%}%>><%= i%></option>
								<%	}%>
								</select>
							</th>
						</tr>
					</table>
					<br>
					<form action="datasetup.jsp" method="post"
					target="DATASETUP" onsubmit="return validate_dataformat_file(this);">
					<%	for(int i=1;i<=readdata.length;i++)
						{
							for(int j=1; j<=columncount; j++)
							{%>
								<input type="hidden" 
								id="data_<%= String.valueOf(i)%>_<%= String.valueOf(j)%>"
								name="data_<%= String.valueOf(i)%>_<%= String.valueOf(j)%>">
						<%	}
						}%>
						<input type="hidden" name="number">
						<input type="hidden" name="dimension">
						<input type="submit" class="button button-pill button-primary" value="导入">
						<input type="button" class="button button-pill button-primary"
							onclick="input_return('<%= mode%>');" value="返回">
					</form>
				</div>
		<%}else{ %>
		<!--  <script type="text/javascript">
        alert("表名不能为空！");
      </script>-->
        <%}%>
	</body>
</html>