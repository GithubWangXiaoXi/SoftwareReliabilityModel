<%@page import="sun.rmi.server.Dispatcher"%>
<%@page import="java.security.spec.DSAGenParameterSpec"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@page import="system.DataSet"%>
<%@ page contentType="text/html;charset= gb2312"%>
<!-- javabean:inputdata 当前使用数据|predata 备选数据集|contrastdata 对比数据集 -->
<jsp:useBean id="rt" class="system.ReadTable" scope="page"></jsp:useBean>
<%-- <jsp:useBean id="dataset" class="system.DataSet" scope="application"></jsp:useBean> 
 --%>
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="historydata" class="system.HistoryData" scope="page"></jsp:useBean>
<jsp:useBean id="contrastdata" class="system.ContrastData" scope="page"></jsp:useBean>

<%
	ArrayList<DataSet> list=rt.getDataSet(1);
    //String[] cname=new String[]{"col1","col2"};
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
	int changeflag = 0;		//声明一个数据替代标志，用于判断当前数据inputdata有没有被替代
   	if(request.getParameter("changenumber") != null)	//替代当前数据
   	{
   		
   		int n = Integer.parseInt(request.getParameter("changenumber")) - 1;	//记录传值号
   		//System.out.println(n+"------>"+historydata.getdataname(n));
   		rt.updateDefaultSet(historydata.getdataname(n), Integer.parseInt(request.getParameter("showhistorydata_testpercentage")));
   		inputdata.setdata(historydata.getdata(n),		//用备选数据集中的指定数据替换掉当前数据
   		 			historydata.getdataname(n),
   		 			historydata.getcolname(n),
   		  			Integer.parseInt(request.getParameter("showhistorydata_testpercentage")),
 					historydata.getdatainfo(n));
 		historydata.setcurrent(n+1);
 		contrastdata.init();	//对比数据集初始化（清空）
 		changeflag = 1;			//替代数据标志启动
 		//request.getRequestDispatcher("/main/frame.jsp").forward(request, response);
   	}
   	int dimension = inputdata.getdimension();
   	String[] colname = new String[dimension];
	double[][] data_train = new double[dimension][];	//将当前数据训练集读入一份到页面
	double[][] data_test = new double[dimension][];		//将当前数据测试集读入一份到页面
   	for(int i=0;i<dimension;i++)
   	{
   		colname[i] = inputdata.getcolname(i+1);
   		data_train[i] = inputdata.getdata_train(i+1).clone();
   		data_test[i] = inputdata.getdata_test(i+1).clone();
   	}
%>

<html>
	<head>
    	<title>失效数据</title>
    	<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
  		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
  		<link rel="stylesheet" type="text/css" href="../../CSS/table.css">
  		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css"> 
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/onload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/modifydata.js" charset="gb2312"></script>
	</head>
	
	<body onload="onload_show();">

		<div id="loader_container" style="display:none">
			<div id="loader">
				<div align="center">正在执行，请稍后 ...</div>
				<div id="loader_bg">
					<div id="progress"></div>
				</div>
			</div>
		</div>
		<input type="hidden" id="changeflag" value="<%= String.valueOf(changeflag)%>">
		<div class="titlename">失效数据</div>
  		<div id="main_tab"> 		<!-- 设置tab页的标题 -->
			<div class="main_tab_menu"> 
				<ul> 
					<li id="show_tab1" onClick="setTab('show',1,4)" class="hover">失效数据</li> 
					<li id="show_tab2" onClick="setTab('show',2,4)" >训练数据</li> 
					<li id="show_tab3" onClick="setTab('show',3,4)">测试数据</li>
					<li id="show_tab4" onClick="setTab('show',4,4)">历史数据</li>
				</ul> 
			</div> 
			<div class="main_tab_content"> 		<!-- 设置tab页的每页的具体内容 -->
				<div id="show_con1">
					<div class="subtitle">失效数据信息</div>
					<div class="currentdata">
						数据名称：<%= inputdata.getdataname()%><br><br>
  	 					数据总数：<%= inputdata.getlength_train()+inputdata.getlength_test()%><br><br>
  	 					训练数据：<%= inputdata.getlength_train()%><br><br>
  	 					测试数据：<%= inputdata.getlength_test()%><br><br>
						数据维数： <%= inputdata.getdimension()%><br><br>
  	 					数据描述：<%= inputdata.getdatainfo()%>
					</div> 
					<div id="resultC_con9" style="display:none;text-align:center;">
			   
				</div>
				</div> 
				<div id="show_con2" style="display:none;">
					<div class="subtitle">训练数据</div>
					<div class="scrollbox">
						<table>
  	 						<tr>
  	 							<th>序号</th>
  	 						<%	for(int i=0; i<dimension; i++)
  	 							{%>
  	 								<th><%= colname[i]%></th>
  	 						<%	}%>
  	 						</tr>
  	 					 <%	for(int i=0; i<data_train[0].length; i++)
  	 						{%>
  	 							<tr <% if(i%2==0) {%>class="altrow"<%}%>>
  	 								<td><%= i+1%></td>
  	 							<%	for(int j=0; j<dimension; j++)
  	 								{%>
  	 									<td><%= data_train[j][i]%></td>
  	 							<%	}%>
  	 							</tr>
  	 					<%	}%>
  	 					</table>
					</div>
				</div>
				<div id="show_con3" style="display:none;">
					<div class="subtitle">测试数据</div>
					<div class="scrollbox">
						<table>
  	 						<tr>
  	 							<th>序号</th>
  	 						<%	for(int i=0; i<dimension; i++)
  	 							{%>
  	 								<th><%= colname[i]%></th>
  	 						<%	}%>
  	 						</tr>
 						<%	for(int i=0,k=data_train[0].length+1; i<data_test[0].length; i++,k++)
  	 						{%>
  	 							<tr <% if(i%2==0) {%>class="altrow"<%}%>>
  	 								<td><%= k%></td>
  	 							<%	for(int j=0; j<dimension; j++)
  	 								{%>
  	 									<td><%= data_test[j][i]%></td>
  	 							<%	}%>
  	 							</tr>
  	 					<%	}%>
  	 					</table>
					</div>
				</div>
				<div id="show_con4" style="display:none;">
					<iframe name="SHOWDATA_show" src="../../resultshow/showhistorydata.jsp"></iframe>
				</div>
			</div> 
		</div> 
	</body>
</html>
