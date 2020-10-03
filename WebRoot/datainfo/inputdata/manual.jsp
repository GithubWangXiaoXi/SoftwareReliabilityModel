<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%
	String num = request.getParameter("number");
	String dimen = request.getParameter("dimension");
	int number=0;
	int dimension=0;
	if(num != null){number = Integer.parseInt(num);}
	if(dimen != null){dimension = Integer.parseInt(dimen);}
	String mode = request.getParameter("mode");	//提取数据模式
%>

<html>
	<head>
		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/table.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/button/validate_dataformat.js" 
		charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/input.js" charset="gb2312"></script>
	</head>

	<body onload="input_next('<%= mode%>');">
		<div class="subtitle">输入数据：总共<%= number%>个数据</div>
		<div class="scrollbox" align="center" style="height:80%">
			<form action="datasetup.jsp" method="post"
			target="DATASETUP" onsubmit="return validate_dataformat_manual(this);">
				<table style="width:600px; height:60px;">
					<tr>
						<th>序号</th>
					<%	for(int i=1; i<=dimension; i++)
						{%>
							<th>第<%= i%>列</th>
					<%	}%>
					</tr>
				<%	for(int i=1;i<=number;i++)
					{%>
						<tr <% if(i%2==1) {%>class="altrow"<%}%>>
							<td><%= i%></td>
						<%	for(int j=1; j<=dimension; j++)
							{%>
								<td>
									<input type="text" style="font-size:18px"
									name="data_<%= String.valueOf(i)%>_<%= String.valueOf(j)%>" 
									id="data_<%= String.valueOf(i)%>_<%= String.valueOf(j)%>"
									autocomplete="off">
								</td>
						<%	}%>
						</tr>
				<%	}%>
				</table>
				<br>
				<input type="hidden" name="number" value=<%= number%>>
				<input type="hidden" name="dimension" value=<%= dimension%>>
				<input type="submit" class="button button button-pill button-primary" value="提交">
				<input type="button" class="button button button-pill button-primary" 
				onclick="input_return('<%= mode%>');" value="取消">
			</form>
		</div>
	</body>
</html>