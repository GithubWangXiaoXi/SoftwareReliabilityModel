<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<!-- javabean:readtable读表数据-->
<jsp:useBean id="readtable" class="system.ReadTable" scope="application"></jsp:useBean>
<%
	String mode = request.getParameter("mode");	//提取数据模式
	String user = request.getParameter("user");	//提取用户名
	String password = request.getParameter("password");	//提取密码
	String choseDataBase = request.getParameter("choseDataBase");	//选择数据库
	String[] tablename=readtable.getTableName(user,password,choseDataBase);
	//System.out.println("表名长度："+tablename.length);
%>

<html>
	<head>
		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/table.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/jquery1.8.3.min.js"></script>
		<script type="text/javascript" src="../../JS/button/validate_dataformat.js" 
		charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/input.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/onload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/button/validate_fileinput.js" 
		charset="gb2312"></script>
	</head>

	<body onload="input_next('<%= mode%>');">
	<%if(tablename.length>0&&tablename!=null&&!"".equals(tablename[0])){ %>
	<div id="oracle1" style="text-align: center;">
						<br>
						<br>
						<br>
						<br>
						<br>
						<br>
						
	<form action="oracle.jsp" method="post" target="ORACLE" id="tableform">
	 						
						
						选择数据库：
							<select name="tablename"  onchange="getAndRenderTable(this.options[this.selectedIndex].value)"style="width:150px;height:35px;font-size:20px">
							<option>选择数据库</option>
							<%	for(int i=0;i<tablename.length;i++)
								{%>
									<option value="<%= tablename[i]%>" >
									<%= tablename[i]%></option>
							<%	}%>
							</select>
							选择数据表：
						<select id="realtablename"name="realtablename" style="width:150px;height:35px;font-size:20px">
							
						</select>
						<br><br>
							<%	if(password == null )
							{%>
								alert("请输入表名！")
						 <%	}%>	
							<input type="hidden" name="mode" value="oracle">
							<input type="hidden" name="user" value="<%=user%>">
							<input type="hidden" name="password" value="<%=password%>">
							<input type="hidden" name="choseDataBase" value="<%=choseDataBase%>">
							<input type="submit" class="button button-pill button-primary" value="确定">
						</form>
					</div>
					<div id="oracle2" style="display: none">
						<iframe name="ORACLE" src="oracle.jsp"></iframe>
					</div>
					<%}else{ %>
					<div class="subtitle2" style="text-align:center;height:3%;">
			数据库连接失败！<br/>
			<input type="button" class="button button-pill button-primary"
							onclick="input_return('<%= mode%>');" value="返回">
		</div>
		<%} %>
	</body>
	<script type="text/javascript">
		function getAndRenderTable(basename){
			//console.log(basename)
			$.ajax({
                type: "POST",
                url: "./getTableNames.jsp" ,
                data: $('#tableform').serialize(),
                success: function (result) {
                    	//console.log(result);
                    	var tables=JSON.parse(result);
                    	console.log(tables);
                    	var htmlStr="";
                    	for(var i=0;i<tables.length;i++){
                    		htmlStr+="<option value='"+tables[i]+"'>"+tables[i]+"</option>";
                    	}
                    	$('#realtablename').html(htmlStr);
                },
                error : function() {
                    alert("服务器异常！");
                }
            })
		}
	</script>
</html>