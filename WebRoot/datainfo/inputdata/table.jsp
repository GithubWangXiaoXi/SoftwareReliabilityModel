<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<!-- javabean:readtable��������-->
<jsp:useBean id="readtable" class="system.ReadTable" scope="application"></jsp:useBean>
<%
	String mode = request.getParameter("mode");	//��ȡ����ģʽ
	String user = request.getParameter("user");	//��ȡ�û���
	String password = request.getParameter("password");	//��ȡ����
	String choseDataBase = request.getParameter("choseDataBase");	//ѡ�����ݿ�
	String[] tablename=readtable.getTableName(user,password,choseDataBase);
	//System.out.println("�������ȣ�"+tablename.length);
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
	 						
						
						ѡ�����ݿ⣺
							<select name="tablename"  onchange="getAndRenderTable(this.options[this.selectedIndex].value)"style="width:150px;height:35px;font-size:20px">
							<option>ѡ�����ݿ�</option>
							<%	for(int i=0;i<tablename.length;i++)
								{%>
									<option value="<%= tablename[i]%>" >
									<%= tablename[i]%></option>
							<%	}%>
							</select>
							ѡ�����ݱ�
						<select id="realtablename"name="realtablename" style="width:150px;height:35px;font-size:20px">
							
						</select>
						<br><br>
							<%	if(password == null )
							{%>
								alert("�����������")
						 <%	}%>	
							<input type="hidden" name="mode" value="oracle">
							<input type="hidden" name="user" value="<%=user%>">
							<input type="hidden" name="password" value="<%=password%>">
							<input type="hidden" name="choseDataBase" value="<%=choseDataBase%>">
							<input type="submit" class="button button-pill button-primary" value="ȷ��">
						</form>
					</div>
					<div id="oracle2" style="display: none">
						<iframe name="ORACLE" src="oracle.jsp"></iframe>
					</div>
					<%}else{ %>
					<div class="subtitle2" style="text-align:center;height:3%;">
			���ݿ�����ʧ�ܣ�<br/>
			<input type="button" class="button button-pill button-primary"
							onclick="input_return('<%= mode%>');" value="����">
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
                    alert("�������쳣��");
                }
            })
		}
	</script>
</html>