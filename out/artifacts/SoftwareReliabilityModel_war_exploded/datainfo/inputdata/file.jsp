<%@ page language="java" import="java.util.*,java.io.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<!-- javabean:readfile ���ļ����ݼ�-->
<jsp:useBean id="readfile" class="system.ReadFile" scope="session"></jsp:useBean>
<%
	String mode = request.getParameter("mode");		//��ȡģʽ��ʽ
	String filename = request.getParameter("fileinput");	//��ȡ�ļ���
	File file = null;
	String extension = null;
	if(filename != null){
		filename = new String(filename.getBytes("ISO8859_1"),"GBK");	//ת�������ʽ
		extension = filename.substring(filename.lastIndexOf(".")+1);	//��ȡ�ļ���׺��
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
		<div class="subtitle">�ļ���������</div>
		<div class="subtitle2" style="text-align:center;height:3%;">
			�ļ�·����<%= filename%>
		</div>
	<%	if(file == null || !file.exists())
		{%>
			<div class="subtitle">
				�ļ������ڣ�����<br>
				<input type="button" class="button" 
				onclick="input_return('<%= mode%>');" value="����">
			</div>
	<%	}
		else
		{
			readfile.read(filename, extension);
			if(readfile.getexist()==0)
			{%>
				<div class="subtitle">
					���ļ�Ϊ�գ�����<br>
					<input type="button" class="button"
					onclick="input_return('<%= mode%>');" value="����">
				</div>
		<%	}
			else
			{
				String[][] readdata=readfile.getreaddata();
				String[][] columnname=readfile.getreaddata();%>
				<div class="scrollbox" align="center" style="height:80%;">
					<table>
						<tr>
							<th>���</th>
						<%	for(int i=1;i<readfile.getmaxcol();i++)
							{%>
								<th>��<%= i%>��</th>
						<%	}%>
						</tr>
						<tr>
							<th>ѡ��</th>
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
							<th>��ȡ</th>
							<th colspan="<%= readfile.getmaxcol()%>">
								��
								<select id="Interception_head">
								<%	for(int i=1;i<=readdata.length;i++)
									{%>
										<option value="<%= String.valueOf(i)%>" 
										<%if(i==1) {%>selected<%}%>><%= i%></option>
								<%	}%>
								</select>
								��
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
						<input type="submit" class="button" value="�ύ">
						<input type="button" class="button"
							onclick="input_return('<%= mode%>');" value="����">
					</form>
				</div>
		<%	}
		}%>	
 	</body>
 </html>