<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="charts.*,java.io.*" %>
<jsp:useBean id="inputdata" class="system.InputData" scope="session"></jsp:useBean>
<jsp:useBean id="contrastdata" class="system.ContrastData" scope="session"></jsp:useBean>
<jsp:useBean id="singleServie" class="model.soar.SingleServiceModel" scope="page"></jsp:useBean>
<%
	String lamdaf="";
	String lamdac="";
	//String display="none";
	double lamda=0;
	double rsp=0;
	if(request.getParameter("lamdaf")!=null && !request.getParameter("lamdaf").equals("")){
		lamdaf=request.getParameter("lamdaf");
		lamdac=request.getParameter("lamdac");
		//display="";
		singleServie.setLamdaf(Double.parseDouble(lamdaf));
		singleServie.setLamdac(Double.parseDouble(lamdac));
		singleServie.setTime(1);
		lamda=singleServie.getLamda();
		rsp=singleServie.calcReliability();
		
		//System.out.print(Double.parseDouble(lamdaf)+" "+rsp);
	}
	
%>

<html>
	<head>    
		<title>���ģ�ͽ����ʾ</title>
    	<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/onload.js" charset="gb2312"></script>	
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/addsubmodel.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/button/combination/validate_Combination.js" 
  		charset="gb2312"></script>
	</head>
	<body onload="onload()" >
	
 			<div id="DW_con3" >
					<div class="subtitle">Ԥ����</div>
					<div class="setup" style="height:84%">
					 
							<div class="parametersetup_title">����ʧЧ��:</div>
							<div class="parametersetup_content">
								<%=lamdaf %>
										(��ǰ����ķ���ʧЧ�ʣ�ȡֵ0~1)
							</div>
							<div class="parametersetup_title">����ʧЧ��:</div>
							<div class="parametersetup_content">
								<%=lamdac %>
										(��ǰ���������ʧЧ�ʣ�ȡֵ0~1)
							</div>
							<div class="parametersetup_title">����ʧЧ��:</div>
							<div class="parametersetup_content">
								<%=lamda %>
										(��ǰ���������ʧЧ�ʣ�ȡֵ0~1)
							</div>
							
							<div class="parametersetup_title">��ǰԤ��ֵ:</div>
							<div class="parametersetup_content">
								<%=rsp %>
										(��������ô���Ϊ��ɢ�ģ�������λС��)
							
						</div>  
							
						
						
						
					</div>	
					
			</div>
	</body>
</html>