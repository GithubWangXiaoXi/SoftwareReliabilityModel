<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="charts.*,java.io.*,system.*" %>
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<jsp:useBean id="calculate_PLR" class="calculate.CalculatePLR" scope="page"></jsp:useBean>
<jsp:useBean id="plrchart" class="charts.PLRChart" scope="page"></jsp:useBean>
<%
	
	ReadTable rt =new ReadTable();
	HistoryData historydata=new HistoryData();
	ArrayList<DataSet> list=rt.getDataSet(0);
	for(int i=0;i<list.size();i++){
		DataSet ds=list.get(i);	
		historydata.entry(ds.getData(), ds.getSetname(), ds.getColname(), ds.getSetinfo());
	
	}
	
		DataSet curds=list.get(list.size()-1);
		inputdata.setdata(curds.getData(),		//用备选数据集中的指定数据替换掉当前数据
		 			curds.getSetname(),
		 			curds.getColname(),
		  			curds.getPercent(),
					curds.getSetinfo());
%>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="../CSS/universal.css">
		<script type="text/javascript" src="../JS/onload.js" charset="gb2312"></script>
	</head>
	<body onload="onload();">
		<%	if(request.getParameter("model1")==null)		//只有触发时才启动页面显示
		{%>
 			<div class="subtitle">暂无结果显示</div>
 	<%	}	
 		else
 		{
 			int sequence = Integer.parseInt(request.getParameter("Sequence"));
 			String model1=request.getParameter("model1");
 			String model2=request.getParameter("model2");
 			String[] parameter1 = parameterinfo.getparameter(model1);
 			String[] parameter2 = parameterinfo.getparameter(model2);
 			calculate_PLR.inputdata(inputdata.getdata_train(sequence), model1, model2, parameter1,parameter2);
 			double[] x1 = calculate_PLR.getoutdata();
 			String filename,graphURL;
 			filename = plrchart.generateLineChart(x1, model1, model2, session, new PrintWriter(out));
		    graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;
		%>
		    <img src="<%= graphURL %>">
 	<%	}%>
	</body>
</html>