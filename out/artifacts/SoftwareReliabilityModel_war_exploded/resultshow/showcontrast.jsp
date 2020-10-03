<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="java.io.*,system.*" %>
<!-- javabean:inputdata 当前使用数据|contrastdata 对比数据集|index 性能参数计算方法实例
				testdatachart 测试集对比图输出方法接口|barchart 柱状图输出方法接口 -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="contrastdata" class="system.ContrastData" scope="page"></jsp:useBean>
<jsp:useBean id="index" class="system.IndexCalculation" scope="page"></jsp:useBean>
<jsp:useBean id="testdatachart" class="charts.TestDataChart" scope="page"></jsp:useBean>
<jsp:useBean id="barchart" class="charts.BarChart" scope="page"></jsp:useBean>
<%
	String filename,graphURL;							//声明变量，用于暂存对比图名与路径信息

	
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
   		<title>对比结果显示</title>
		<link rel="stylesheet" type="text/css" href="../CSS/universal.css" />
		<link rel="stylesheet" type="text/css" href="../CSS/showtab.css" />
		<link rel="stylesheet" type="text/css" href="../CSS/table.css" />
		<script type="text/javascript" src="../JS/onload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../JS/tab.js" charset="gb2312"></script>
   	</head>
   	
   	<body onload="onload();">
	<%	if(request.getParameter("model") == null)		//只有触发时才启动页面显示
		{%>
			<div class="subtitle">暂无结果显示</div>
	<%	}
		else
		{
			String select[] = request.getParameterValues("select");	//声明变量，接收被选中的模型名
			int sequence = Integer.parseInt(request.getParameter("Sequence"));
			String colname = inputdata.getcolname(sequence);
			String[] select_modelname = new String[select.length];	//声明变量，存储被选中的模型名
			double[][] select_testdata = new double[select.length][inputdata.getlength_test()];
			//声明变量，存储被选中模型的测试集预测数据
			double[] select_MSE = new double[select.length];		//声明变量，存储被选中模型的MSE值
			double[] select_R_Square = new double[select.length];	//声明变量，存储被选中模型的R_Square值
			double[] select_AE = new double[select.length];			//声明变量，存储被选中模型的AE值
			double[] select_MSPE = new double[select.length];		//声明变量，存储被选中模型的MSPE值	
	
			for(int i = 0 ; i < select.length ; i++)
			{
				int select_current = Integer.parseInt(select[i]);
				select_modelname[i] = contrastdata.getmodelname(select_current);	//提取被选择的模型名
				select_testdata[i]=contrastdata.gettestdata(select_current).clone();
				select_MSE[i]=contrastdata.getMSE(select_current);			//提取MSE值
				select_R_Square[i]=contrastdata.getR_Square(select_current);	//提取R_Square值
				select_AE[i]=contrastdata.getAE(select_current);			//提取AE值
				select_MSPE[i]=contrastdata.getMSPE(select_current);		//提取MSPE值
				
	 		}%>
	 		<div class="show_tab_menu">
	    		<div style="width:100%;">
	    			<ul> 
						<li id="showcontrast_tab1" onClick="setTab('showcontrast',1,6)" 
						class="hover">表格对比</li>
						<li id="showcontrast_tab2" onClick="setTab('showcontrast',2,6)" >预测曲线图</li> 
						<li id="showcontrast_tab3" onClick="setTab('showcontrast',3,6)" >MSE图</li> 
						<li id="showcontrast_tab4" onClick="setTab('showcontrast',4,6)">R_Square图</li> 
						<li id="showcontrast_tab5" onClick="setTab('showcontrast',5,6)">AE图</li>
						<li id="showcontrast_tab6" onClick="setTab('showcontrast',6,6)">MSPE图</li> 
					</ul> 
	    		</div>
	    	</div>
	    	<div class="show_tab_content"> 
				<div id="showcontrast_con1">
					<div class="subtitle">性能参数对比总表</div>
					<div class="scrollbox">
						<table>
	    					<tr>
	  	 						<th>模型名</th>
	  	 						<th>MSE</th>
	  	 						<th>R_Square</th>
	  	 						<th>AE</th>
	  	 						<th>MSPE</th>
	  	 					</tr>
	  	 				<% 	for(int i=0;i<select.length;i++)
	  	 					{%>
	  	 					<tr <% if(i%2==0) {%>class="altrow"<%}%>>
	  	 						<td><%= select_modelname[i]%></td>
	  	 						<td><%= select_MSE[i]%></td>
	  	 						<td><%= select_R_Square[i]%></td>
	  	 						<td><%= select_AE[i]%></td>
	  	 						<td><%= select_MSPE[i]%></td>
	  	 					</tr>
	  	 				<%	}%>
	  	 					<tr>
	  	 					<%	int optimal; %>
	  	 						<th>最优模型</th>
	  	 					<%	optimal=index.optimal(select_MSE, 1); %>
	  	 						<th><%=select_modelname[optimal]%></th>
	  	 					<%	optimal=index.optimal(select_R_Square, 2); %>
								<th><%=select_modelname[optimal]%></th>
							<%	optimal=index.optimal(select_AE, 1); %>
	  	 						<th><%=select_modelname[optimal]%></th>
	  	 					<%	optimal=index.optimal(select_MSPE, 1); %>
	  	 						<th><%=select_modelname[optimal]%></th>
	  	 					</tr>
	  	 				</table>
	  	 			</div>
				</div>
				<div id="showcontrast_con2" style="display:none;text-align:center;">
				<% 	filename = testdatachart.generateLineChart(select_modelname,
													inputdata.getdata_test(sequence),
													select_testdata,
													inputdata.getlength_train(),
													colname,session,new PrintWriter(out));
	     			graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;%>
					<img src="<%= graphURL %>">
				</div> 
				<div id="showcontrast_con3" style="display:none;text-align:center;">
				<% 	filename = barchart.generateBarChart("MSE",select_modelname,select_MSE,
														session,new PrintWriter(out));
	     			graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;%>
					<img src="<%= graphURL %>">
				</div>
				<div id="showcontrast_con4" style="display:none;text-align:center;">
				<% 	filename = barchart.generateBarChart("R_Square",select_modelname,select_R_Square,
														session,new PrintWriter(out));
	     			graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;%>
					<img src="<%= graphURL %>">
				</div>
				<div id="showcontrast_con5" style="display:none;text-align:center;">
	 			<% 	filename = barchart.generateBarChart("AE",select_modelname,select_AE,
	 													session,new PrintWriter(out));
	     			graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;%>
					<img src="<%= graphURL %>">
				</div>
				<div id="showcontrast_con6" style="display:none;text-align:center;">
				<% 	filename = barchart.generateBarChart("MSPE",select_modelname,select_MSPE,
														session,new PrintWriter(out));
	     			graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;%>
					<img src="<%= graphURL %>">
				</div>
			</div>	
	<%	}%>
	</body>
</html>