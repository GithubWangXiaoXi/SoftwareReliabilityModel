<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%@ page import="system.*" %>
<%@ page contentType="text/html;charset= gb2312"%>
<!-- javabean:inputdata 当前使用数据|predata 备选数据集 -->
<% 
	InputData inputdata =new InputData();
	HistoryData historydata=new HistoryData();
	ReadTable rt = new ReadTable();
	ContrastData contrastdata =new ContrastData();
	ArrayList<DataSet> list=rt.getDataSet(1);
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
   		//System.out.print("收到请求了");
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
 		//System.out.println("@@@@@"+inputdata.gettestpercentage());
   	}
	double[][] history_data;	//声明变量，用于暂存历史数据集
	int number = historydata.getnumber();
	//System.out.println(number);
	double[][][] data=new double[number][][];
	String[][] colname = new String[number][];
	for(int i=0; i<number; i++)
	{
		data[i] = historydata.getdata(i);
		colname[i] = historydata.getcolname(i);
	}
%>
<html>
  <head>    
    <title>结果显示</title>
    <link rel="stylesheet" type="text/css" href="../CSS/universal.css">
  	<link rel="stylesheet" type="text/css" href="../CSS/showtab.css">
  	<link rel="stylesheet" type="text/css" href="../CSS/table.css">
  	<link rel="stylesheet" type="text/css" href="../CSS/showpredata.css">
  	<link rel="stylesheet" type="text/css" href="../CSS/buttons.css">
  	<script type="text/javascript" src="../JS/jquery1.8.3.min.js"></script> 	
	<script type="text/javascript" src="../JS/tab.js" charset="gb2312"></script>
	<script type="text/javascript" src="../JS/button/validate_changedata.js" 
	charset="gb2312"></script>
	<style>
		.f-show {
			float: left;
			width:260px;
		}
	</style>
	</head>
	<body>
	 	<div class="show_tab_menu" >
    		<div style="width:100%;">
    			<h3>选择失效数据集</h3>
				<select style="border: 1px solid #277de2;width:90%;"onchange="setchangenumber(this.selectedIndex+1,<%= String.valueOf(number)%>,<%= String.valueOf(historydata.getcurrent())%>)">
				<%	for(int i=1; i<=number ;i++)
					{%>
						<option id="showhistorydata_tab<%= String.valueOf(i)%>" 
						<%if(i==(historydata.getcurrent())) {%>selected="selected"<%}%>>
						
							<%= historydata.getdataname(i-1)%>
						</option>
					<%	}%>
				 </select>
				<%--  onchange="(<%= String.valueOf(i)%>,
											
										);"
							class="hover" --%>
			</div>
			<br>
			<div class="changedata" >
				<form action="" method="post"  
				onsubmit="validate_changedata(this)" id="changeform">
					<br><br>
					测试数据比例:
					<select name="showhistorydata_testpercentage" style="height:30px;width:70px;font-size:18px">
						<option value="0">0%</option>
						<option value="5">5%</option>
						<option value="10" selected>10%</option>
						<option value="15">15%</option>
						<option value="20">20%</option>
						<option value="25">25%</option>
						<option value="30">30%</option>
					</select>
					<br><br>
					<input type="hidden" id="changenumber" name="changenumber" value="<%= list.size()%>">
					<input type="submit" class="button button-pill button-primary" style="width:80px;font-size:18px" value="修改">
				</form>
 			
			</div>
			<div id="currentdata" class="subtitle2">当前数据集！！！</div>
		</div>
		<div class="show_tab_content">
		<%	for(int i=0;i<number;i++)
			{%>
				<div id="showhistorydata_con<%= String.valueOf(i+1)%>"
					<% if(i!=(historydata.getcurrent()-1)) {%> style="display:none;"<%}%>>
					<div class="showpredata">
						<div class="f-show">
							<div class="showpredata_title">数据名称：</div>
							<div class="showpredata_content"><%= historydata.getdataname(i)%>
							
							</div>
							<br><br>
							<div class="showpredata_title">数据长度：</div>
							<div class="showpredata_content"><%= data[i][0].length%></div>
						</div>
						<div class="f-show">
							<div class="showpredata_title">训练数据：</div>
							<div class="showpredata_content"><%=data[i][0].length-data[i][0].length*list.get(i).getPercent()/100%></div>
							<br><br>
							<div class="showpredata_title">测试数据：</div>
							<div class="showpredata_content"><%= data[i][0].length*list.get(i).getPercent()/100%></div>
						</div>
						<div class="f-show">
							<div class="showpredata_title">数据维数：</div>
							<div class="showpredata_content"><%= data[i].length%></div>
							<br><br>
							<div class="showpredata_title" >数据描述：</div>
							<div class="showpredata_content" >
							<%= historydata.getdatainfo(i)%>
							</div>
						</div>
						<br>
						<br>
					</div>
					<div class="scrollbox" style="height:69%;">
						<table>
	    					<tr>
	  	 						<th>序号</th>
	  	 					<%	for(int j=0; j<colname[i].length; j++)
	  	 						{%>
	  	 							<th><%= colname[i][j]%></th>
	  	 					<%	}%>
	  	 					</tr>
	  	 					<%	for(int j=0; j<data[i][0].length; j++)
								{%>
									<tr <% if(j%2==0) {%>class="altrow"<%}%>>
										<td><%=String.valueOf(j+1)%></td>
									<%	for(int k=0; k<data[i].length; k++)
	  	 								{%>
	  	 									<td><%= data[i][k][j]%></td>
	  	 							<%	}%>
									</tr>
							<%	}%>			
						</table>
					</div>		
				</div>
		<%	}%>
		</div>
	</body>
</html>