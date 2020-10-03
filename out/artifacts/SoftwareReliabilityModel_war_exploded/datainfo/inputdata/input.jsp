<%@page import="system.DataSet"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page contentType="text/html;charset=utf-8"%>
<!-- javabean:inputdata 当前使用数据|contrastdata 对比数据集|historydata 历史数据集-->
 <jsp:useBean id="readtable" class="system.ReadTable" scope="application"></jsp:useBean>
 <jsp:useBean id="dataset" class="system.DataSet" scope="application"></jsp:useBean> 
<jsp:useBean id="inputdata" class="system.InputData" scope="session"></jsp:useBean>
<jsp:useBean id="contrastdata" class="system.ContrastData" scope="session"></jsp:useBean>
<jsp:useBean id="historydata" class="system.HistoryData" scope="session"></jsp:useBean>
<%
	int flag=0;	//定义 flag，用来判断当前有没有执行以下程序
	if(request.getParameter("flag")!=null)
	{
		int number = Integer.parseInt(request.getParameter("number"));	//提取数据长度
		int dimension = Integer.parseInt(request.getParameter("dimension"));	//提取数据维度
		//System.out.println("!!!!"+number+" "+dimension);
		int testpercentage = Integer.parseInt(request.getParameter("data_testpercentage"));
	//提取数据的测试百分比
		double[][] data = new double[dimension][number];
		String[] colname = new String[dimension];
		for (int i = 0; i < dimension; i++) //提取数据
		{
			for (int j = 0; j < number; j++)
			{
				data[i][j] = Double.parseDouble(request
						.getParameter("data_" + String.valueOf(j + 1)
								+ "_" + String.valueOf(i + 1)));
			}
		}
		for (int i = 0; i < dimension; i++) //提取每个维度的列明
		{
			colname[i] = request.getParameter("colname"
					+ String.valueOf(i + 1));
			colname[i] = new String(colname[i].getBytes("ISO8859_1"),
					"GBK");
		}
		String dataname = request.getParameter("data_name");	//提取数据名
		dataname = new String(dataname.getBytes("ISO8859_1"), "GBK");	//转换字体格式
		String datainfo = request.getParameter("data_description");		//提取数据信息
		datainfo = new String(datainfo.getBytes("ISO8859_1"), "GBK");	 //转换字体格式
		int datatype=Integer.parseInt(request.getParameter("data_type"));
		readtable.setData(dataname, datainfo, testpercentage,datatype);
		
		historydata.entry(data, dataname, colname, datainfo);	//导入到历史数据集
		contrastdata.init();	//将比较数据集里的数据清空
		inputdata.setdata(data, dataname, colname, testpercentage,		//导入当前数据
				datainfo);
		flag = 1;
	}
%>

<html>
	<head> 
		<title>导入数据</title> 
		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css" />
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css" />
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css" />
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/tab.js?v=2" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/onload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/button/validate_fileinput.js" 
		charset="gb2312"></script>
	</head> 
	
	<body onload="onload_input();">
		<input type="hidden" id="flag" value="<%= flag%>">
		<div id="loader_container" style="display:none">   <!-- 执行等待条 -->
			<div id="loader">
				<div align="center">正在执行，请稍后 ...</div>
				<div id="loader_bg">
					<div id="progress"></div>
				</div>
			</div>
		</div>
		<div class="titlename">数据导入</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="INPUT_tab1" onClick="setTab('INPUT',1,4)" class="hover">手动导入</li> 
					<li id="INPUT_tab2" onClick="setTab('INPUT',2,4)" >文件导入</li> 
					<li id="INPUT_tab3" onClick="setTab('INPUT',3,4)">数据库导入</li> 
					<li id="INPUT_tab4" onClick="setTab('INPUT',4,4)" 
					style="display:none">数据导入设置</li>
				</ul> 
			</div>
			<div class="main_tab_content"> 
				<div id="INPUT_con1">
					<div id="manual1" style="text-align:center;">
						<br><br><br><br><br><br>
						<form action="manual.jsp" method="post" target="MANUAL">
							失效数据类型：
							<select name="datatype"style="width:80px;height:30px; font-size: 18px">
								<option value="0">经典模型失效数据</option>
								<option value="1">SOA模型失效数据</option>
							</select>
							<br><br>
							输入数据个数：
							<select name="number" style="width:80px;height:30px; font-size: 18px" >
							<%	for(int i=10;i<=200;i++)
								{%>
									<option value="<%= String.valueOf(i)%>" 
									<% if(i==100) {%>selected<%}%>>
									<%= i%></option>
							<%	}%>
							</select>
							<br><br>
							输入数据维数：
							<select name="dimension" style="width:80px;height:30px; font-size: 18px" >
							<%	for(int i=1;i<=10;i++)
								{%>
									<option value="<%= String.valueOf(i)%>" 
									<% if(i==1) {%>selected<%}%>>
									<%= i%></option>
							<%	}%>
							</select>
							<br><br><br><br>
							<input type="hidden" name="mode" value="manual">
							<input type="submit" class="button button-pill button-primary" value="确定">
						</form>
					</div>
					<div id="manual2" style="display:none">
						<iframe name="MANUAL" src="manual.jsp"></iframe>
					</div>
				</div>
				<div id="INPUT_con2" style="display:none">
					<div id="file1" style="text-align:center;">
						<br><br><br><br><br><br>
						<form action="file.jsp" method="post" target="FILE" 
						onsubmit="return validate_fileinput(this);">
						          失效数据类型：
							<select name="datatype"style="width:130px;height:30px; font-size: 18px">
								<option value="0">经典模型失效数据</option>
								<option value="1">SOA模型失效数据</option>
							</select>
							<br><br>
							文件路径：支持xls、txt和csv文件 <br><br>
							<input type="FILE" name="fileinput" style="width:80px;height:30px; font-size: 18px">
							<br><br><br><br>
							<input type="hidden" name="mode" value="file">
							<input type="submit" class="button button-pill button-primary" value="确定">
						</form>
					</div>
					<div id="file2" style="display:none">
						<iframe name="FILE" src="file.jsp"></iframe>
					</div>
				</div>
				
				<script >   
			          function validate()   
			          {   
			                  if(document.getElementById("user").value=='')    
			                  {   
			                          alert("用户名不能为空.");   
			                         // document.myform.username.focus();   
			                          return false;   
			                  }   
			                  else if(document.getElementById("password").value=='')  
			                  {   
			                          alert("密码不能为空.");   
			                         // document.myform.userpass.focus();   
			                          return false;   
			                  }   
			                  else      return true;   
			          }   
			  </script>   
				
				<div id="INPUT_con3" style="display:none">
					<div id="table1" style="text-align: center;">
						<br>
						<br>
						<br>
						<br>
						<br>
						<br>
						<form action="table.jsp" method="post" target="TABLE"  onsubmit="return validate(this);"  >
						
						
						数据库类型：
							<select name="choseDataBase" style="width:120px;height:30px; font-size: 18px">
									<option value="mysql" >MySQL</option>
									<option value="oracle" >Oracle</option>
							</select><br><br>
						IP  地  址：
							<input type="text" id="addr" value="127.0.0.1" autocomplete="off" name="addr" style="width:120px;height:30px; font-size: 18px">
							<br>
							<br>
						用  户  名：
							<input type="text" id="user" autocomplete="off" name="user" style="width:120px;height:30px; font-size: 18px">
							<br>
							<br>
						密  &nbsp;&nbsp;&nbsp;&nbsp;码：
							<input type="password" autocomplete="off" id="password" name="password" style="width:120px;height:30px; font-size: 18px" onBlur="getTableName()">
							<br>
							<br>
							<!--请输入表名:
							<input type="text" name="tablename" style="width: 120px;">
							 <br><br>
						 请选择列数：
							<select name="dimension" style="width:50px">
							<%	for(int i=1;i<=10;i++)
								{%>
									<option value="<%= String.valueOf(i)%>" 
									<% if(i==1) {%>selected<%}%>>
									<%= i%></option>
							<%	}%>
							</select><br><br>
							请选择条数：
							<select name="sum" style="width:50px">
							<%	for(int i=10;i<=100;i++)
								{%>
									<option value="<%= String.valueOf(i)%>" 
									<% if(i==1) {%>selected<%}%>>
									<%= i%></option>
							<%	}%>
							</select>-->
							<input type="hidden" name="mode" value="table">
							<!--<button >确定</button>-->
							 <input type="submit" class="button button-pill button-primary" onclick="validate()" value="确定"> 
						</form>
					</div>
					<div id="table2" style="display: none">
						<iframe name="TABLE" src="table.jsp"></iframe>
					</div>
			</div> 
		</div>
		</div>
	</body>
</html>
