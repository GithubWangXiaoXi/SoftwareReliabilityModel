<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="java.io.*,system.*"%>
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<jsp:useBean id="resolvechart" class="charts.ResolveChart" scope="page"></jsp:useBean>
<jsp:useBean id="calculate_mix_ln" class="calculate.CalculateMix_LN" 
scope="page"></jsp:useBean>
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
		<title>混合模型分解结果显示</title>
    	<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
  		<link rel="stylesheet" type="text/css" href="../../CSS/showtab.css">
  		<link rel="stylesheet" type="text/css" href="../../CSS/table.css">
  		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">	
  		
		<script type="text/javascript" src="../../JS/onload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/button/mix/validate_LN.js" 
		charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/button/mix/validate_merger.js" 
		charset="gb2312"></script>
	</head>
	<body onload="onload();">
	<%	if(request.getParameter("modelselect")==null)		//只有触发时才启动页面显示
		{%>
 			<div class="subtitle">暂无结果显示</div>
 	<%	}
 		else
 		{
 			int Sequence = Integer.parseInt(request.getParameter("Sequence"));
 			double data_train[] = inputdata.getdata_train(Sequence);	//提取当前数据训练集
 			String colname = inputdata.getcolname(Sequence);
 			String model = request.getParameter("modelselect");
 			int step = Integer.parseInt(request.getParameter("prestep")) +
 										inputdata.getlength_test();
 			String[] parameter_str = parameterinfo.getparameter(model);
 			double[] parameter = new double[parameter_str.length];
 			for(int i=0; i<parameter.length; i++)
 			{
 				parameter[i] = Double.parseDouble(parameter_str[i]);
 			}
 			double[][] resolvedata = calculate_mix_ln.inputdata(data_train, step, model, parameter);
 		%>
 			<div class="show_tab_menu">
 				<div style="width:100%;">
					<ul> 
						<li id="resultMix_ln_tab1" onClick="setTab('resultMix_ln',1,3)" class="hover">
							分解数据表
						</li> 
						<li id="resultMix_ln_tab2" onClick="setTab('resultMix_ln',2,3)">
							分解数据图
						</li> 
						<li id="resultMix_ln_tab3" onClick="setTab('resultMix_ln',3,3)">
							模型设置
						</li>
					</ul> 
				</div>
 			</div>
 			<div class="show_tab_content">
 				<div id="resultMix_ln_con1">
 					<div class="subtitle">残差序列分解表</div>
 					<div class="scrollbox">
 						<table>
 						 	<tr>
 								<th>序号</th>
 								<th><%= model%></th>
 								<th>残差序列</th>
 							</tr>
 						<%	for(int i=0; i<resolvedata[0].length; i++)
 							{%>
 								<tr <% if(i%2==0) {%>class="altrow"<%}%>>
 									<td><%= String.valueOf(i+1)%></td>
 									<td><%= resolvedata[0][i]%></td>
 									<td><%= resolvedata[1][i]%></td>
 								</tr>
 						<%	}%>
 						</table>
 					</div>
 				</div>
 				<div id="resultMix_ln_con2" style="display:none;text-align:center;">
 				<%	String filename,graphURL;
					filename= resolvechart.generateLineChart(resolvedata[0],model,colname,
																session,new PrintWriter(out));
     				graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;%>
					<img src="<%= graphURL%>">
				<%	filename= resolvechart.generateLineChart(resolvedata[1],"残差序列",colname,
															session,new PrintWriter(out));
     				graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;%>
					<img src="<%= graphURL%>">
 				</div>
 				<div id="resultMix_ln_con3" style="display:none;" align="center">
					<br><br>
					<form action="resultMix_LN_Merger.jsp" method="post"
									target="SHOWDATA_LN_MERGER"
									onsubmit="return validata_LN_merger(this);">
						残差模型：
						<select	name="modelselect">
							<option value="BPN" selected>BPN模型</option>
							<option value="RBFN">RBFN模型</option>
							<option value="GEP">GEP模型</option>
							<option value="GM">GM模型</option>
							<option value="SVM">SVM模型</option>
							<option value="ARIMA">ARIMA模型</option>
							<option value="JM">J_M模型</option>
							<option value="DUANE">DUANE模型</option>
							<option value="WEIBULL">Weibull模型</option>
							<option value="GammaSRM">GammaSRM模型</option>
							<option value="ExponentialSRM">ExponentialSRM模型</option>
							<option value="LogNormalSRM">LogNormalSRM模型</option>
							<option value="GO">G_O模型</option>
							<option value="SCHNEIDEWIND">Schneidewind模型</option>
							<option value="LogLogisticSRM">LogLogisticSRM模型</option>
							<option value="ParetoSRM">ParetoSRM模型</option>
							<option value="MO">M_O模型</option>
<!-- **********************************增加模型接口********************************** -->
<!-- **********************************增加模型接口********************************** -->
<!-- **********************************增加模型接口********************************** -->
<!-- **********************************增加模型接口********************************** -->
<!-- **********************************增加模型接口********************************** -->
						</select>
						<br><br>
						<input type="hidden" name="model" value="<%= model%>">
						<input type="hidden" name="Sequence" value="<%= Sequence%>">
						<input type="submit" class="button button-pill button-primary" value="预测">
					</form>
 				</div>
 			</div>
 	<%	}%>
	</body>
</html>