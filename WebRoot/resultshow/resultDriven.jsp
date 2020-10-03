<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="charts.*,java.io.*,system.*" %>
<!-- javabean:inputdata 当前使用数据 | contrastdata 对比数据集 | index 性能参数计算方法实例 
				parameterinfo 默认参数信息 | bpn BPN模型方法接口 | rbfn RBFN模型方法接口
				gep GEP模型方法接口 | svm SVM模型方法接口 | gm GM模型方法接口
				arima ARIMA模型方法接口 | threestepchart 三步图输出方法接口
				rechart 误差百分比图输出方法接口 -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="contrastdata" class="system.ContrastData" scope="page"></jsp:useBean>
<jsp:useBean id="index" class="system.IndexCalculation" scope="page"></jsp:useBean>
<jsp:useBean id="ks" class="system.KS" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<jsp:useBean id="kschart" class="charts.KSChart" scope="page"></jsp:useBean>
<jsp:useBean id="threestepchart" class="charts.ThreeStepChart" scope="page"></jsp:useBean>
<jsp:useBean id="rechart" class="charts.REChart" scope="page"></jsp:useBean>
<jsp:useBean id="calculate_datadriven" class="calculate.CalculateDataDriven" scope="session"></jsp:useBean>
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
		<title>数据驱动模型结果显示</title>
    	<link rel="stylesheet" type="text/css" href="../CSS/universal.css">
  		<link rel="stylesheet" type="text/css" href="../CSS/showtab.css">
  		<link rel="stylesheet" type="text/css" href="../CSS/table.css">
		<script type="text/javascript" src="../JS/onload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../JS/tab.js" charset="gb2312"></script>
	</head>
	
	<body onload="onload();">
	<%	if(request.getParameter("model")==null)		//只有触发(预测按钮)时才启动页面显示
		{%>
 			<div class="subtitle">暂无结果显示</div>
 	<%	}	
 		else
 		{
 			//将inputdata内容保存在当前页面变量中
 			int sequence = Integer.parseInt(request.getParameter("Sequence"));
 			double data_train[] = inputdata.getdata_train(sequence);	//提取当前数据训练集
 			double data_test[] = inputdata.getdata_test(sequence);		//提取当前数据测试集
 			String colname = inputdata.getcolname(sequence);
 			int step = Integer.parseInt(request.getParameter("prestep"))
 						+inputdata.getlength_test();			//提取预测总步数
 			String model=request.getParameter("model");			//提取模型名
 			double[] parameter=new double[parameterinfo.getnumber(model)];
 			//声明页面变量，用于暂存模型参数
 			for(int i=0;i<parameter.length;i++)
 			{
 				parameter[i]=Double.parseDouble(
 							request.getParameter(model+"_parameter"+String.valueOf(i+1)));
 			}
			calculate_datadriven.inputdata(data_train, model, step, parameter);
			double[] outdata = calculate_datadriven.getoutdata();  //得到预测数据‘
			double[] fitness = calculate_datadriven.getfitness();  //得到拟合数据‘
 			String process = calculate_datadriven.getprocess();
 			String str_parameterinfo = calculate_datadriven.getparameterinfo();
 			String date = calculate_datadriven.getdate();
 			ks.inputdata(data_train, fitness);
			if(data_test.length!=0)
			{
 				index.calculation(data_test,outdata);		//计算各性能参数
    			contrastdata.entry(sequence,model,outdata,data_test.length,date,str_parameterinfo,
    							index.getMSE(),index.getR_Square(),
    							index.getAE(),index.getMSPE());	//将执行信息存入对比数据集
    		}
    	%>
 			<div class="show_tab_menu">
    			<div style="width:100%;">
					<ul> 
						<li id="resultD_tab1" onClick="setTab('resultD',1,7)" class="hover">预测数据</li>
						<li id="resultD_tab2" onClick="setTab('resultD',2,7)">拟合数据</li>
						<li id="resultD_tab3" onClick="setTab('resultD',3,7)">K-S检验</li>
						<li id="resultD_tab4" onClick="setTab('resultD',4,7)">模型参数</li> 
						<li id="resultD_tab5" onClick="setTab('resultD',5,7)">性能参数</li>
						<li id="resultD_tab6" onClick="setTab('resultD',6,7)">残差分析</li>
						<li id="resultD_tab7" onClick="setTab('resultD',7,7)">拟合-预测图</li>
					</ul> 
				</div>
				<div class="subtitle">
					完成时间:<br>
				<%= date%>
				</div>
    		</div>
    		<div class="show_tab_content">
				<div id="resultD_con1">
					<div class="subtitle">预测数据</div>
					<div class="scrollbox">
						<table>
    						<tr>
  	 							<th>序号</th>
  	 							<th>真实数据</th>
  	 							<th>测试数据</th>
  	 						</tr>
  	 					<% 	int i=0;
  	 						for(int k=inputdata.getlength_train()+1;i<inputdata.getlength_test();i++,k++)
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
    			<div id="resultD_con2" style="display:none">
					<div class="subtitle">拟合数据</div>
					<div class="scrollbox">
						<table>
    						<tr>
  	 							<th>序号</th>
  	 							<th>真实数据</th>
  	 							<th>拟合数据</th>
  	 						</tr>
  	 					<% 	for(int j=0;j<data_train.length;j++)
							{%>
  	 						<tr <% if(j%2==0) {%>class="altrow"<%}%>>
  	 							<td><%= j+1%></td>
  	 							<td><%= data_train[j]%></td>
  	 							<td>
  	 							<%	if(fitness[j]==0.001) out.print("-");
  	 								else out.print(fitness[j]);%>
  	 							</td>
  	 						</tr>
  	 					<%	}%>
  	 					</table>
					</div>
    			</div>
    			<%	String filename,graphURL;%>
    			<div id="resultD_con3" style="display:none;text-align:center;">
				<%	filename = kschart.generateLineChart(ks.getFn1(),ks.getFn2(),
																session,new PrintWriter(out));
		     		graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;
		     	%>
					<img src="<%= graphURL %>">
					<br><br>
					<div class="note" style="font-weight:bold;font-size:20px;">
						KS距离：<%= ks.getD()%>，p值：<%= ks.getp()%>
					</div>
				</div>
				<div id="resultD_con4" style="display:none">
					<div class="subtitle">过程参数</div>
					<% 
						process = process.replaceAll("\n", "<br>");
					%>
					
					<div class="scrollbox"><%= process%></div>
				</div>
				<div id="resultD_con5" style="display:none">
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
								<td>回归曲线方程的相关指数</td>
								<td>均值误差</td>
								<td>均方百分比误差</td>
							</tr>
							<tr>
								<th>公式</th>
								<td><img src="../IMAGE/formula/MSE.png" height="100%" width="100%"/></td>
								<td><img src="../IMAGE/formula/R_Square.png" height="100%" width="100%"/></td>
								<td><img src="../IMAGE/formula/AE.png" height="100%" width="100%"/></td>
								<td><img src="../IMAGE/formula/MSPE.png" height="100%" width="100%"/></td>
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
				<div id="resultD_con6" style="display:none;text-align:center;">
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
				<div id="resultD_con7" style="display:none;text-align:center;">
			    <% 	filename = threestepchart.generateLineChart(data_train,data_test,outdata,fitness,model,
			    											colname,session,new PrintWriter(out));
     				graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;%>
					<img src="<%= graphURL %>">
				</div>
			</div>
	<%	}%>
	</body>
</html>