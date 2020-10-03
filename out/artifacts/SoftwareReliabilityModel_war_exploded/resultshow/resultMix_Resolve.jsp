<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="java.io.*,system.*" %>
<!-- javabean:inputdata 当前使用数据 | parameterinfo 默认参数信息 | resolve 分解数据集
				emd EMD分解模型方法接口 | ssa SSA分解模型方法接口 | wave WAVE分解模型方法接口
				ln L+N分解模型方法接口 | resolvechart 分解图输出方法接口 -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<jsp:useBean id="resolve" class="system.Resolve" scope="page"></jsp:useBean>
<jsp:useBean id="resolvechart" class="charts.ResolveChart" scope="page"></jsp:useBean>
<jsp:useBean id="calculate_mix_resolve" class="calculate.CalculateMix_Resolve" 
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
		<title>数据分解结果显示</title>
    	<link rel="stylesheet" type="text/css" href="../CSS/universal.css">
  		<link rel="stylesheet" type="text/css" href="../CSS/showtab.css">
  		<link rel="stylesheet" type="text/css" href="../CSS/table.css">
  		<link rel="stylesheet" type="text/css" href="../CSS/waitload.css">
  		<link rel="stylesheet" type="text/css" href="../CSS/buttons.css">	
		<script type="text/javascript" src="../JS/onload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../JS/waitload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../JS/button/mix/validate_merger.js" 
		charset="gb2312"></script>
	</head>

	<body onload="onload();">
	<%	if(request.getParameter("model")==null)		//只有触发时才启动页面显示
		{%>
 			<div class="subtitle">暂无结果显示</div>
 	<%	}
 		else
 		{
 			int Sequence = Integer.parseInt(request.getParameter("Sequence"));
 			double data_train[] = inputdata.getdata_train(Sequence);	//提取当前数据训练集
 			String colname = inputdata.getcolname(Sequence);
 			String model=request.getParameter("model");			//提取模型名
 			double[][] resolvedata=new double[1][1];
 			//声明页面变量，用于暂存分解数据
 			String resolvename="";	//声明页面变量，用于暂存模型分解名
 			double[] parameter = new double[2];
 			double[] SSA_SinglePercent = new double[1];
 			//声明页面变量，用于暂存模型参数			
 			if(request.getParameter("Combination") == null)
 			{
 				parameter[0]=Double.parseDouble(request.getParameter(model+"_parameter1"));
	 			parameter[1]=Double.parseDouble(request.getParameter(model+"_parameter2"));
 				calculate_mix_resolve.inputdata(data_train, model, parameter);
 				resolvedata=calculate_mix_resolve.getoutdata();
	 			resolvename=calculate_mix_resolve.getresolvename(model);
	 			if(model.equals("SSA"))
 				{
 					SSA_SinglePercent = calculate_mix_resolve.getSSA_SinglePercent();
 					resolve.setSinglePercent(SSA_SinglePercent);
 				}
 				resolve.setdata(resolvedata);
 			}
 			else
 			{
 				resolve.combination(model);
 				resolvedata=resolve.getdata();
 				resolvename=request.getParameter("resolvename");
 				if(model.equals("SSA"))
 				{
 					SSA_SinglePercent = resolve.getSinglePercent();
 				}
 			}
 			int resolvenumber = resolvedata.length;
 			%>
 			<input type="hidden" id="resolvenumber" value="<%= resolvenumber%>">
			<div class="show_tab_menu">
				<div style="width:100%;">
					<ul> 
						<li id="resultResolve_tab1" onClick="setTab('resultResolve',1,4)" class="hover">
							分解数据表
						</li> 
						<li id="resultResolve_tab2" onClick="setTab('resultResolve',2,4)">
							分解数据图
						</li> 
						<li id="resultResolve_tab3" onClick="setTab('resultResolve',3,4)">
							合并数据
						</li>
						<li id="resultResolve_tab4" onClick="setTab('resultResolve',4,4)">
							预测分析
						</li> 
					</ul> 
				</div>
			</div>
			<div class="show_tab_content">
				<div id="resultResolve_con1">
					<div class="subtitle"><%= model%>分解表</div>
					<div class="scrollbox">
						<table>
							<tr>
								<th>序号</th>
								<th>原始数据</th>
							<%	for(int j=1;j<=resolvenumber;j++)
							 	{%>
  	 							<th><%= resolvename%><%= String.valueOf(j)%></th>
  	 						<%	} %>
  	 						</tr>
  	 					<%	for(int i=0;i<data_train.length;i++)
  	 						{%>
  	 							<tr <% if(i%2==0) {%>class="altrow"<%}%>>
  	 								<td><%= i+1%></td>
  	 								<td><%= data_train[i]%></td>
  	 							<%	for(int j=0;j<resolvedata.length;j++)
  	 								{%>
  	 									<td><%= resolvedata[j][i]%></td>
  	 							<%	}%>
  	 							</tr>
  	 					<%	}%>
						</table>
					</div>
				</div>
				<div id="resultResolve_con2" class="scrollbox" style="display:none;text-align:center;">
				<%	String filename,graphURL;
					for(int i=0;i<resolvenumber;i++)
					{
						filename= resolvechart.generateLineChart(resolvedata[i],
																resolvename+String.valueOf(i+1),
																colname,
																session,
																new PrintWriter(out));
     					graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;%>
						<img src="<%= graphURL%>">
				<%	}%>
				</div>
				<div id="resultResolve_con3" style="display:none;">
					<form action="../model/Mix/<%= model%>.jsp" method="post"
								target="MAIN"
								onsubmit="return validata_combination(this);">
						<div class="scrollbox" align="center">
							<table>
								<tr>
									<th>选择合并</th>
									<th>分解名</th>
								<%	if(model.equals("SSA"))
									{%>
										<th>贡献值</th>
								<%	}%>
								</tr>
							<%	for(int i=1;i<=resolvenumber;i++)
								{%>
									<tr <% if(i%2==1) {%>class="altrow"<%}%>>
										<td>
											<input type="checkbox" name="select"
												value="<%= String.valueOf(i)%>">
										</td>
										<td><%= resolvename%><%= String.valueOf(i)%></td>
									<%	if(model.equals("SSA"))
									{%>
										<th><%= SSA_SinglePercent[i-1]%></th>
								<%	}%>
									</tr>
							<%	}%>
							</table>
							<br>
							<input type="hidden" name="Sequence" value="<%= Sequence%>">
							<input type="hidden" name="resolvename" value="<%= resolvename%>">
							<input type="hidden" name="resolveflag" value="1">
							<input type="hidden" name="model" value="<%= model%>">
							<input type="submit" class="button button-pill button-primary" value="合并">
						</div>
					</form>
				</div>
				<div id="resultResolve_con4" style="display:none">
					<div class="subtitle">模型设置</div>
				<%	if(resolvenumber>10) 
					{%>
						<br><div class="subtitle">分解个数超过10个！！！</div>
				<%	} 
					else
					{%>
						<div class="scrollbox" align="center">
							<form action="resultMix_Merger.jsp" method="post"
									target="SHOWDATA_<%= model%>_MERGER"
									onsubmit="return validata_merger(this);">
								预测步长：<input type="text" name="prestep" 
								value="<%= parameterinfo.getstep()%>">
								<span class="setup_description">
									(设置范围：0-100， 设置模型向后预测的步数)
								</span>
								<br>
								<table>
									<tr>
										<td></td>
										<th>特征数据</th>
										<th>选择模型</th>
									</tr>
								<%	for(int i=1;i<=resolvenumber;i++)
									{%>
										<tr <% if(i%2==1) {%>class="altrow"<%}%>>
											<td>
											<% 	if(i==1)
												{%>
													<input type="button" class="button button-pill button-primary" 
													onClick="aftersame(1);" value="下同" style="width:80px">
											<%	}
												if(i==2)
												{%>
													<input type="button" class="button button-pill button-primary" 
													onClick="aftersame(2);" value="下同" style="width:80px">
											<%	}%>
											</td>
											<td><%= resolvename%><%= String.valueOf(i)%></td>
											<td>
												<select id="modelselect<%= String.valueOf(i)%>" 
												name="modelselect<%= String.valueOf(i)%>">
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
													<option value="LogLogisticSRM">LogLogisticSRM模型</option>
										            <option value="ParetoSRM">ParetoSRM模型</option>
													<option value="GO">G_O模型</option>
													<option value="SCHNEIDEWIND">Schneidewind模型</option>
													<option value="MO">M_O模型</option>
	<!-- **********************************增加模型接口********************************** -->
	<!-- **********************************增加模型接口********************************** -->
	<!-- **********************************增加模型接口********************************** -->
	<!-- **********************************增加模型接口********************************** -->
	<!-- **********************************增加模型接口********************************** -->
												</select>
											</td>
										</tr>
								<%	}%>
								</table>
								<br>
								<input type="hidden" name="model" value="<%= model%>">
								<input type="hidden" name="Sequence" value="<%= Sequence%>">
								<input type="submit" class="button button-pill button-primary" value="预测">
							</form>
						</div>
					<%}%>
				</div>
			</div>
 	<%	}%>
	</body>
</html>