<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>

<jsp:useBean id="inputdata" class="system.InputData" scope="session"></jsp:useBean>
<jsp:useBean id="historydata" class="system.HistoryData" scope="session"></jsp:useBean>
<jsp:useBean id="contrastdata" class="system.ContrastData" scope="session"></jsp:useBean>

<html>
	<head>
    	<title>用户管理</title>
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
	
	<body>
		<div class="titlename">用户管理</div>
  		<div id="main_tab"> 		<!-- 设置tab页的标题 -->
			<div class="main_tab_menu"> 
				<ul> 
					<li id="user_tab1" onClick="setTab('user',1,2)" class="hover">用户管理</li> 
					<li id="user_tab2" onClick="setTab('user',2,2)">用户注册</li>
				</ul> 
			</div> 
			<div class="main_tab_content"> 		<!-- 设置tab页的每页的具体内容 -->
				<div id="show_con1" style="display:none;">
					<div class="subtitle">用户管理</div>
					<div class="scrollbox">
						<table>
  	 						<tr>
  	 							<th>序号</th>
  	 						</tr>
  	 					 	<tr >
  	 							<td>用户名称 </td>  	 	
  	 						</tr>
  	 					</table>
					</div>
				</div>
				<div id="show_con2" style="display:none;">
					<div class="subtitle">用户注册</div>
					<div class="scrollbox">
						<table>
  	 						<tr>
  	 							<th>序号</th>
  	 						</tr>
  	 					</table>
					</div>
				</div>
			</div> 
		</div> 
	</body>
</html>
