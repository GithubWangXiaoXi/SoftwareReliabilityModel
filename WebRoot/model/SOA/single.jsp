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
		<title>组合模型结果显示</title>
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
					<div class="subtitle">预测结果</div>
					<div class="setup" style="height:84%">
					 
							<div class="parametersetup_title">服务失效率:</div>
							<div class="parametersetup_content">
								<%=lamdaf %>
										(当前服务的服务失效率，取值0~1)
							</div>
							<div class="parametersetup_title">连接失效率:</div>
							<div class="parametersetup_content">
								<%=lamdac %>
										(当前服务的连接失效率，取值0~1)
							</div>
							<div class="parametersetup_title">总体失效率:</div>
							<div class="parametersetup_content">
								<%=lamda %>
										(当前服务的总体失效率，取值0~1)
							</div>
							
							<div class="parametersetup_title">当前预测值:</div>
							<div class="parametersetup_content">
								<%=rsp %>
										(假设其调用次数为离散的，保留三位小数)
							
						</div>  
							
						
						
						
					</div>	
					
			</div>
	</body>
</html>