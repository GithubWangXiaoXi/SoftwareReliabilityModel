<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<!-- javabean:parameterinfo Ĭ�ϲ�����Ϣ-->
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="session"></jsp:useBean>
<%	String model=request.getParameter("model");		//��ȡ�ϲ�ҳ���ύ��ģ��
	String[] parameter = new String[parameterinfo.getnumber(model)];	//����ģ��������������
 	for(int i=0;i<parameter.length;i++)
 	{
 		parameter[i] = request.getParameter(model+"_parameter"+String.valueOf(i+1));
 	}
	parameterinfo.setparameter(model, parameter);		//�޸�Ĭ�ϲ�����Ϣ
%>

<html>	
	<body>
		<input type="hidden" id="model" value=<%= model%>> 
		<!-- ִ�������ת��parameter.jspҳ�� -->
		<!-- flag����־�Ǵӵ�ǰҳ�����parameter.jsp -->
		<jsp:forward page="parameter.jsp">
			<jsp:param name="flag" value="1" />
		</jsp:forward>
	</body>
</html>