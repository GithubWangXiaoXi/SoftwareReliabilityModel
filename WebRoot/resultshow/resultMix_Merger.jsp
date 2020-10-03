<%@page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="java.io.*,system.*" %>
<!-- javabean:inputdata 当前使用数据 | contrastdata 对比数据集 | index 性能参数计算方法实例 
				parameterinfo 默认参数信息 | resolve 分解数据集 | assemble 组合方法接口
				bpn BPN模型方法接口 | rbfn RBFN模型方法接口 | gep GEP模型方法接口
				svm SVM模型方法接口 | gm GM模型方法接口 | arima ARIMA模型方法接口
				threestepchart 三步图输出方法接口 | rechart 误差百分比图输出方法接口 -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="contrastdata" class="system.ContrastData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<jsp:useBean id="ks" class="system.KS" scope="page"></jsp:useBean>
<jsp:useBean id="resolve" class="system.Resolve" scope="page"></jsp:useBean>
<jsp:useBean id="index" class="system.IndexCalculation" scope="page"></jsp:useBean>
<jsp:useBean id="uychart" class="charts.UYChart" scope="page"></jsp:useBean>
<jsp:useBean id="kschart" class="charts.KSChart" scope="page"></jsp:useBean>
<jsp:useBean id="threestepchart" class="charts.ThreeStepChart" scope="page"></jsp:useBean>
<jsp:useBean id="rechart" class="charts.REChart" scope="page"></jsp:useBean>
<jsp:useBean id="calculate_mix_merger" class="calculate.CalculateMix_Merger" 
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
		<title>混合模型结果显示</title>
    	<link rel="stylesheet" type="text/css" href="../CSS/universal.css">
  		<link rel="stylesheet" type="text/css" href="../CSS/showtab.css">
  		<link rel="stylesheet" type="text/css" href="../CSS/table.css">
  		<link rel="stylesheet" type="text/css" href="../CSS/buttons.css">	
  		<script type="text/javascript" src="../JS/onload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../JS/tab.js" charset="gb2312"></script>
	</head>
	
	<body onload="onload_merger();">
	<%	if(request.getParameter("model")==null)
		{%>
 			<div class="subtitle">暂无结果显示</div>
 	<%	}	
 		else
 		{
 			double[][] data_resolve=resolve.getdata();			//提取分解的数据
 			int sequence = Integer.parseInt(request.getParameter("Sequence"));
 			double data_train[] = inputdata.getdata_train(sequence);	//提取当前数据训练集
 			double data_test[] = inputdata.getdata_test(sequence);		//提取当前数据测试集
 			String colname = inputdata.getcolname(sequence);
 			String model = request.getParameter("model");
 			int step = Integer.parseInt(request.getParameter("prestep"))+inputdata.getlength_test();
 			//提取需要预测的总步长
	 		double[][] parameter=new double[data_resolve.length][];	//声明变量，用于存储各模型参数
	 		String[] model_resolve = new String[data_resolve.length];
	 		for(int i=0; i<data_resolve.length; i++)
	 		{
	 			model_resolve[i]=request.getParameter("modelselect"+String.valueOf(i+1));
	 			String[] parameter_Str=parameterinfo.getparameter(model_resolve[i]);
	 			parameter[i] = new double[parameter_Str.length];
	 			for(int j=0;j<parameter_Str.length;j++)
	 			{
	 				parameter[i][j]=Double.parseDouble(parameter_Str[j]);
	 			}
	 		}
	 		calculate_mix_merger.inputdata(data_resolve, step, model_resolve, parameter);
	 		double[] outdata = calculate_mix_merger.getoutdata();
	 		double[] fitness = new double[1];
			String info = calculate_mix_merger.getparameterinfo();
			String date = calculate_mix_merger.getdate();
			if(data_test.length!=0)
			{
	 			index.calculation(data_test,outdata);		//计算各性能参数
	 			ks.inputdata(data_test, outdata);
	    		contrastdata.entry(sequence,model,outdata,data_test.length,date,info,
	    							index.getMSE(),index.getR_Square(),
	    							index.getAE(),index.getMSPE());	//将执行信息存入对比数据集
	    	}
%>			
			<div class="show_tab_menu">
    			<div style="width:100%;">
					<ul> 
						<li id="resultAssemble_tab1" onClick="setTab('resultAssemble',1,4)" class="hover">
							预测数据
						</li> 
						<li id="resultAssemble_tab2" onClick="setTab('resultAssemble',2,4)">
							性能参数
						</li> 						
						<li id="resultAssemble_tab3" onClick="setTab('resultAssemble',3,4)">
							残差分析
						</li>
						<li id="resultAssemble_tab4" onClick="setTab('resultAssemble',4,4)">
							拟合-预测图
						</li>
					</ul> 
				</div>
				<div class="subtitle">
					完成时间:<br>
				<%= date%>
				</div>
    		</div>
    		<div class="show_tab_content">
				<div id="resultAssemble_con1">
					<div class="subtitle">预测数据</div>
					<div class="scrollbox">
						<table>
    						<tr>
  	 							<th>序号</th>
  	 							<th>真实数据</th>
  	 							<th>测试数据</th>
  	 						</tr>
  	 					<% 	int i=0;
  	 						for(int k=inputdata.getlength_train()+1;
  	 						i<inputdata.getlength_test();i++,k++)
							{%>
  	 						<tr <% if(i%2==0) {%>class="altrow"<%}%>>
  	 							<td><%= k%></td>
  	 							<td><%= data_test[i]%></td>
  	 							<td><%= outdata[i]%></td>
  	 						</tr>
  	 					<%	}%>
  	 					</table>
    					<table>
    						<tr>
  	 							<th>预测步数</th>
  	 							<th>预测数据</th>
  	 						</tr>
    					<%	for(int k=1;i<step;i++,k++)
    						{%>
    						<tr <% if(k%2==1) {%>class="altrow"<%}%>>
    							<td>第<%= k%>步</td>
  	 							<td><%= outdata[i]%></td>
  	 						</tr>
    					<%	}%>
    					</table>
					</div>
    			</div>
				<div id="resultAssemble_con2" style="display:none">
					<div class="subtitle">性能参数</div>
					<br><br>
					<div class="note">
						<table style="width:80%">
							<tr>
								<th>参数名</th>
								<th>MSE</th>
								<th>R_Square</th>
								<th>AE</th>
								<th>MSPE</th>
							</tr>
							<tr>
								<th>中文描述</th>
								<td>均值误差平方和</td>
								<td>修正可决系数</td>
								<td>均值误差</td>
								<td>均方百分比误差</td>
							</tr>
							<tr>
								<th>公式</th>
								<td><img src="../IMAGE/formula/MSE.png" 
									height="100%" width="100%"/></td>
								<td><img src="../IMAGE/formula/R_Square.png" 
									height="100%" width="100%"/></td>
								<td><img src="../IMAGE/formula/AE.png" 
									height="100%" width="100%"/></td>
								<td><img src="../IMAGE/formula/MSPE.png" 
									height="100%" width="100%"/></td>
							</tr>
							<tr class="altrow">
								<th>值</th>
								<td>
								<%	if(data_test.length==0) { out.print("-");}
									else { out.print(index.getMSE());} %>
								</td>
								<td>
								<%	if(data_test.length==0) { out.print("-");}
									else { out.print(index.getR_Square());} %>
								</td>
								<td>
								<%	if(data_test.length==0) { out.print("-");}
									else { out.print(index.getAE());} %>
								</td>
								<td>
								<%	if(data_test.length==0) { out.print("-");}
									else { out.print(index.getMSPE());} %>
								</td>
							</tr>
						</table>
						<br>
						(<b>注：</b>公式中，<i>y<sub>i</sub></i>表示数据的实际值，
						<i>y'<sub>i</sub></i>表示数据的预测值，
					 	<i>y<sub>ave</sub></i>表示观测数据<i>y<sub>i</sub></i>的均值。)
					</div>
				</div> 
			 <%	String filename,graphURL;%>
				<div id="resultAssemble_con3" style="display:none;text-align:center;">
				<%	if(data_test.length==0)
					{%>
						<div class="subtitle">无测试集数据！</div>
				<%	}
					else
					{					
						filename = rechart.generateLineChart(index.getRE(),data_train.length,
															session,new PrintWriter(out));
		     			graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;
		     	%>
						<img src="<%= graphURL %>">
				<%	}%>
				</div>
				<div id="resultAssemble_con4" style="display:none;text-align:center;">
			    <% 	filename = threestepchart.generateLineChart(data_train,data_test,outdata,fitness,
				    											model,colname,session,new PrintWriter(out));
     				graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;%>
					<img src="<%= graphURL %>">
				</div>
			</div>					
 	<%	}%>
	</body>
</html>