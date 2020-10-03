<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<!-- javabean:inputdata 当前使用数据-->
<jsp:useBean id="inputdata" class="system.InputData" scope="session"></jsp:useBean>

<html>
	<head>
		<link rel="stylesheet" type="text/css" href="../CSS/universal.css" />
		<link rel="stylesheet" type="text/css" href="../CSS/maintab.css" />
		<link rel="stylesheet" type="text/css" href="../CSS/waitload.css" />
		<link rel="stylesheet" type="text/css" href="../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../CSS/buttons.css">	
		<script type="text/javascript" src="../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../JS/waitload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../JS/button/validate_PLR.js" 
		charset="gb2312"></script>
	</head>
	<body>
		<div id="loader_container" style="display:none">
			<div id="loader">
				<div align="center">正在处理，请稍后 ...</div>
				<div id="loader_bg">
					<div id="progress"></div>
				</div>
			</div>
		</div>
		<input type="hidden" id="flag" value="0">
		<input type="hidden" id="current_tab" value="2">
		<input type="hidden" id="model" value="PLR">
		<div class="titlename">经典模型PLR图对比 </div>
  		<div id="main_tab">
  			<div class="main_tab_menu"> 
				<ul> 
					<li id="PLR_tab1" onClick="setTab('PLR',1,3)" 
					class="hover">PLR对比简介</li> 
					<li id="PLR_tab2" onClick="setTab('PLR',2,3)">选择对比模型</li> 
					<li id="PLR_tab3" onClick="setTab('PLR',3,3)" 
					>对比结果显示</li> 
				</ul> 
			</div>
			<div class="main_tab_content">
				<div id="PLR_con1">
					<div class="subtitle">PLR对比</div>
					<div class="scrollbox">
                     <p style="text-align:center;"><img src="../IMAGE/com/PLR.jpg"></p>                                                          
					</div>
				</div>
				<div id="PLR_con2" style="display:none">
					<div class="subtitle">对比模型选择</div>
					<div class="setup">
						<form action="../resultshow/showPLR.jsp" 
								method="post" target="SHOWDATA_PLR"
								onsubmit="return validate_PLR();;">
							<div class="parametersetup_title">数据序列：</div>
							<div class="parametersetup_content">
								<select name="Sequence">
							<%	for(int i=1;i<=inputdata.getdimension();i++)
								{%>
									<option value="<%= String.valueOf(i)%>" 
									<%if(i==1) {%>selected<%}%>><%= inputdata.getcolname(i)%>
									</option>
							<%	}%>
								</select>
							</div>
							<div class="parametersetup_title">对比模型1：</div>
							<div class="parametersetup_content">
								<select name="model1">
									<option value="JM">J_M模型</option>
									<option value="DUANE">DUANE模型</option>
									<option value="WEIBULL">Weibull模型</option>
									<option value="GO">G_O模型</option>
									<option value="SCHNEIDEWIND">Schneidewind模型</option>
									<option value="MO">M_O模型</option>
									<option value="GammaSRM">GammaSRM模型</option>
									<option value="ExponentialSRM">ExponentialSRM模型</option>
									<option value="LogNormalSRM">LogNormalSRM模型</option>
								</select>
							</div>
							<div class="parametersetup_title">对比模型2：</div>
							<div class="parametersetup_content">
							<select name="model2">
								<option value="JM">J_M模型</option>
								<option value="DUANE">DUANE模型</option>
								<option value="WEIBULL">Weibull模型</option>
								<option value="GO">G_O模型</option>
								<option value="SCHNEIDEWIND">Schneidewind模型</option>
								<option value="GammaSRM">GammaSRM模型</option>
								<option value="MO">M_O模型</option>
								<option value="ExponentialSRM">ExponentialSRM模型</option>
								<option value="LogNormalSRM">LogNormalSRM模型</option>
							</select>
							</div>
							<div style="text-align:center">
								<input type="submit" class="button button-pill button-primary" value="对比分析">
							</div>
						</form>
					</div>
				</div>
				<div id="PLR_con3" style="display:none">
					<iframe name="SHOWDATA_PLR" src="../resultshow/showPLR.jsp"></iframe>
				</div>
			</div>
  		</div>
	</body>
</html>
