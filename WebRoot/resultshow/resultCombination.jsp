<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="charts.*,java.io.*,system.*" %>
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="contrastdata" class="system.ContrastData" scope="page"></jsp:useBean>
<jsp:useBean id="index" class="system.IndexCalculation" scope="page"></jsp:useBean>
<jsp:useBean id="ks" class="system.KS" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<jsp:useBean id="kschart" class="charts.KSChart" scope="page"></jsp:useBean>
<jsp:useBean id="threestepchart" class="charts.ThreeStepChart" scope="page"></jsp:useBean>
<jsp:useBean id="rechart" class="charts.REChart" scope="page"></jsp:useBean>
<jsp:useBean id="calculate_combination" class="calculate.CalculateCombination" scope="page"></jsp:useBean>
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
		<title>组合模型结果显示</title>
    	<link rel="stylesheet" type="text/css" href="../CSS/universal.css">
  		<link rel="stylesheet" type="text/css" href="../CSS/showtab.css">
  		<link rel="stylesheet" type="text/css" href="../CSS/table.css">
   		<link rel="stylesheet" type="text/css" href="../CSS/buttons.css">	
		<script type="text/javascript" src="../JS/onload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../JS/tab.js" charset="gb2312"></script>
	</head>
	<body onload="onload();">
	<%	if(request.getParameter("model")==null)		//只有触发时才启动页面显示
		{%>
 			<div class="subtitle">暂无结果显示</div>
 	<%	}	
 		else
 		{
 			//将inputdata内容保存在当前页面变量中
 			String model=request.getParameter("model");			//提取模型名
 			int number = Integer.parseInt(request.getParameter("number"));
 			String[] modelselect = new String[number];
 			double[][] parameter = new double[number][];
 			if(model.equals("LW")||model.equals("NLW"))
 			{
 				modelselect = new String[number+1];
 				parameter = new double[number+1][];
 			}
 			if(model.equals("BCM"))
 			{
 				parameter = new double[number+1][];
 			}
 			for(int i=0;i<number;i++)
 			{
 				modelselect[i] = request.getParameter("modelselect"+String.valueOf(i+1));
 				parameter[i] = new double[parameterinfo.getnumber(modelselect[i])];
 				String[] parameter_String = parameterinfo.getparameter(modelselect[i]);
 				for(int j=0;j<parameter[i].length;j++)
 				{
 					parameter[i][j] = Double.parseDouble(parameter_String[j]);
 				}
 			}
 			if(model.equals("LW")||model.equals("NLW"))
 			{
 				modelselect[number] = request.getParameter("modelselect_combination");
 				parameter[number] = new double[parameterinfo.getnumber(modelselect[number])];
 				String[] parameter_String = parameterinfo.getparameter(modelselect[number]);
 				for(int j=0;j<parameter[number].length;j++)
 				{
 					parameter[number][j] = Double.parseDouble(parameter_String[j]);
 				}
 			}
 			if(model.equals("BCM"))
 			{
 				parameter[number] = new double[1];
 				parameter[number][0] = Double.parseDouble(request.getParameter("type"));
 			}
 			int sequence = Integer.parseInt(request.getParameter("Sequence"));
 			double data_train[] = inputdata.getdata_train(sequence);	//提取当前数据训练集
 			double data_test[] = inputdata.getdata_test(sequence);		//提取当前数据测试集
 			String colname = inputdata.getcolname(sequence);
 			int step = Integer.parseInt(request.getParameter("prestep"))
 						+inputdata.getlength_test();			//提取预测总步数
 			//定义时间格式
 			calculate_combination.inputdata(data_train, model, step, modelselect, parameter);
 			double[] outdata = calculate_combination.getoutdata();
 			double[][] predictdata = calculate_combination.getpredictdata();
 			double[] fitnessdata_combination = calculate_combination.getfitnessdata_combination();
 			double[][] fitnessdata = calculate_combination.getfitnessdata();
 			String process = calculate_combination.getprocess();
 			String str_parameterinfo = calculate_combination.getparameterinfo();
 			String date = calculate_combination.getdate();
 			ks.inputdata(data_train, fitnessdata_combination);
 			if(data_test.length!=0)
			{
 				index.calculation(data_test,outdata);		//计算各性能参数
    			contrastdata.entry(sequence ,model,outdata,data_test.length,date,str_parameterinfo,
    							index.getMSE(),index.getR_Square(),
    							index.getAE(),index.getMSPE());	//将执行信息存入对比数据集
    		}
		%>	
 			<div class="show_tab_menu">
    			<div style="width:100%;">
					<ul> 
						<li id="resultCombination_tab1" onClick="setTab('resultCombination',1,8)" class="hover">组合预测数据</li>
						<li id="resultCombination_tab2" onClick="setTab('resultCombination',2,8)">单模型预测数据</li>
						<li id="resultCombination_tab3" onClick="setTab('resultCombination',3,8)">拟合数据</li>
						<li id="resultCombination_tab4" onClick="setTab('resultCombination',4,8)">组合模型参数</li> 
						<li id="resultCombination_tab5" onClick="setTab('resultCombination',5,8)">K-S检验</li> 
						<li id="resultCombination_tab6" onClick="setTab('resultCombination',6,8)">性能参数</li>
						<li id="resultCombination_tab7" onClick="setTab('resultCombination',7,8)">残差分析</li>
						<li id="resultCombination_tab8" onClick="setTab('resultCombination',8,8)">拟合-预测图</li>
					</ul> 
				</div>
				<div class="subtitle">
					完成时间:<br>
				<%= date%>
				</div>
    		</div>
    		<div class="show_tab_content">
				<div id="resultCombination_con1">
					<div class="subtitle">组合预测数据</div>
					<div class="scrollbox">
						<table>
    						<tr>
  	 							<th>序号</th>
  	 							<th>真实数据</th>
  	 							<th>测试数据</th>
  	 						</tr>
  	 					<% 	int ii=0;
  	 						for(int k=inputdata.getlength_train()+1;ii<inputdata.getlength_test();ii++,k++)
							{%>
  	 						<tr <% if(ii%2==0) {%>class="altrow"<%}%>>
  	 							<td><%= k%></td>
  	 							<td><%= data_test[ii]%></td>
  	 							<td><%= outdata[ii]%></td>
  	 						</tr>
  	 					<%	}%>
  	 					</table>
    					<table>
    						<tr>
  	 							<th>预测步数</th>
  	 							<th>预测数据</th>
  	 						</tr>
    					<%	for(int k=1;ii<step;ii++,k++)
    						{%>
    						<tr <% if(k%2==1) {%>class="altrow"<%}%>>
    							<td>第<%= k%>步</td>
  	 							<td><%= outdata[ii]%></td>
  	 						</tr>
    					<%	}%>
    					</table>
					</div>
    			</div>
    			<div id="resultCombination_con2" style="display:none">
    				<div class="subtitle">单模型预测数据</div>
					<div class="scrollbox">
						<table>
							<tr>
								<th>序号</th>
							<%	for(int i=0; i<number; i++)
								{%>
									<th>模型<%= String.valueOf(i+1)%>：<%= modelselect[i]%></th>
							<%	}%>
								<th>组合后的预测数据</th>
							</tr>
							<%	for(int i=0; i<step; i++)
								{%>
									<tr <% if(i%2==0) {%>class="altrow"<%}%>>
										<td><%= String.valueOf(i+1)%></td>
									<%	for(int j=0; j<number; j++)
										{%>
											<td><%= predictdata[j][i]%></td>
									<%	}%>
										<td><%= outdata[i]%></td>
									</tr>
							<%	}%>
						</table>
					</div>
    			</div>
    			<div id="resultCombination_con3" style="display:none">
    				<div class="subtitle">拟合数据</div>
    				<div class="scrollbox">
    					<table>
    						<tr>
    							<th>序号</th>
    						<%	for(int i=0;i<number;i++)
    							{%>
    								<th>模型<%= i+1%>：<%= modelselect[i]%></th>
    						<%	}%>
    							<th>组合后的拟合值</th>
    							<th>真实数据</th>
    						</tr>
    						<%	for(int i=0;i<fitnessdata.length;i++)
    							{%>
	    							<tr <% if(i%2==0) {%>class="altrow"<%}%>>
	    								<td><%= i+1%></td>
	    							<%	for(int j=0;j<fitnessdata[i].length;j++)
	    								{%>
	    									<td>
	    									<%	if(fitnessdata[i][j]==0.001) out.print("-");
  	 											else out.print(fitnessdata[i][j]);%>
	    									</td>
	    							<%	}%>
	    								<td>
	    								<%	if(fitnessdata_combination[i]==0.001) out.print("-");
  	 										else out.print(fitnessdata_combination[i]);%>
	    								</td>
	    								<td><%= data_train[i]%></td>
	    							</tr>
    						<%	} %>
    					</table>
    				</div>
    			</div>
    			<div id="resultCombination_con4" style="display:none">
    				<div class="subtitle">组合模型参数</div>
    				<% 
						process = process.replaceAll("\n", "<br>");
					%>
					<div class="scrollbox"><%= process%></div>
    			</div>
    			<%	String filename,graphURL;%>
    			<div id="resultCombination_con5" style="display:none">
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
    			<div id="resultCombination_con6" style="display:none">
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
    			<div id="resultCombination_con7" style="display:none">
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
    			<div id="resultCombination_con8" style="display:none">
    			<% 	filename = threestepchart.generateLineChart(data_train,data_test,outdata,
    													fitnessdata_combination,model,
			    									colname,session,new PrintWriter(out));
     				graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;%>
					<img src="<%= graphURL %>">
    			</div>
			</div>
 	<%	}%>
	</body>
</html>