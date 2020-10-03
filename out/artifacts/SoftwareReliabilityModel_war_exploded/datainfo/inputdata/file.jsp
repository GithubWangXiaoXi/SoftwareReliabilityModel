<%@ page language="java" import="java.util.*,java.io.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<!-- javabean:readfile 读文件数据集-->
<jsp:useBean id="readfile" class="system.ReadFile" scope="session"></jsp:useBean>
<%
	String mode = request.getParameter("mode");		//提取模式方式
	String filename = request.getParameter("fileinput");	//提取文件名
	File file = null;
	String extension = null;
	if(filename != null){
		filename = new String(filename.getBytes("ISO8859_1"),"GBK");	//转换字体格式
		extension = filename.substring(filename.lastIndexOf(".")+1);	//提取文件后缀名
		file = new File(filename);
	}
 %>
 <html>
 	<head>
		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/table.css">
		<script type="text/javascript" src="../../JS/button/validate_dataformat.js?v=1" 
		charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/input.js" charset="gb2312"></script>
	</head>
 	<body onload="input_next('<%= mode%>');">
		<div class="subtitle">文件导入数据</div>
		<div class="subtitle2" style="text-align:center;height:3%;">
			文件路径：<%= filename%>
		</div>
	<%	if(file == null || !file.exists())
		{%>
			<div class="subtitle">
				文件不存在！！！<br>
				<input type="button" class="button" 
				onclick="input_return('<%= mode%>');" value="返回">
			</div>
	<%	}
		else
		{
			readfile.read(filename, extension);
			if(readfile.getexist()==0)
			{%>
				<div class="subtitle">
					该文件为空！！！<br>
					<input type="button" class="button"
					onclick="input_return('<%= mode%>');" value="返回">
				</div>
		<%	}
			else
			{
				String[][] readdata=readfile.getreaddata();
				String[][] columnname=readfile.getreaddata();%>
				<div class="scrollbox" align="center" style="height:80%;">
					<table>
						<tr>
							<th>序号</th>
						<%	for(int i=1;i<readfile.getmaxcol();i++)
							{%>
								<th>第<%= i%>列</th>
						<%	}%>
						</tr>
						<tr>
							<th>选择</th>
						<%	for(int i=1;i<=readfile.getmaxcol();i++)
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
							<% 	for(int j=0;j<readfile.getmaxcol();j++)
								{%>
									<td>
										<input type="text" 
										id="predata_<%= String.valueOf(i+1)%>_<%= String.valueOf(j+1)%>"  
										value="<%= readdata[i][j]%>">
									</td>
							<%	}%>
								</tr>
						<%	}%>
						<tr>
							<th>截取</th>
							<th colspan="<%= readfile.getmaxcol()%>">
								从
								<select id="Interception_head">
								<%	for(int i=1;i<=readdata.length;i++)
									{%>
										<option value="<%= String.valueOf(i)%>" 
										<%if(i==1) {%>selected<%}%>><%= i%></option>
								<%	}%>
								</select>
								至
								<select id="Interception_tail">
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
							for(int j=1; j<=readfile.getmaxcol(); j++)
							{%>
								<input type="hidden" 
								id="data_<%= String.valueOf(i)%>_<%= String.valueOf(j)%>"
								name="data_<%= String.valueOf(i)%>_<%= String.valueOf(j)%>">
						<%	}
						}%>
						<input type="hidden" name="number">
						<input type="hidden" name="dimension">
						<input type="submit" class="button" value="提交">
						<input type="button" class="button"
							onclick="input_return('<%= mode%>');" value="返回">
					</form>
				</div>
		<%	}
		}%>	
 	</body>
 </html>