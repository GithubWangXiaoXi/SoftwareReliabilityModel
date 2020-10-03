<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<!-- javabean:parameterinfo 默认参数信息-->
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="session"></jsp:useBean>
<%	String model=request.getParameter("model");		//提取上层页面提交的模型
	String[] parameter = new String[parameterinfo.getnumber(model)];	//根据模型声明参数个数
 	for(int i=0;i<parameter.length;i++)
 	{
 		parameter[i] = request.getParameter(model+"_parameter"+String.valueOf(i+1));
 	}
	parameterinfo.setparameter(model, parameter);		//修改默认参数信息
%>

<html>	
	<body>
		<input type="hidden" id="model" value=<%= model%>> 
		<!-- 执行完后跳转到parameter.jsp页面 -->
		<!-- flag，标志是从当前页面进入parameter.jsp -->
		<jsp:forward page="parameter.jsp">
			<jsp:param name="flag" value="1" />
		</jsp:forward>
	</body>
</html>