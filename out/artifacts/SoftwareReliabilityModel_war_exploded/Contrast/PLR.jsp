<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<!-- javabean:inputdata ��ǰʹ������-->
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
				<div align="center">���ڴ������Ժ� ...</div>
				<div id="loader_bg">
					<div id="progress"></div>
				</div>
			</div>
		</div>
		<input type="hidden" id="flag" value="0">
		<input type="hidden" id="current_tab" value="2">
		<input type="hidden" id="model" value="PLR">
		<div class="titlename">����ģ��PLRͼ�Ա� </div>
  		<div id="main_tab">
  			<div class="main_tab_menu"> 
				<ul> 
					<li id="PLR_tab1" onClick="setTab('PLR',1,3)" 
					class="hover">PLR�Աȼ��</li> 
					<li id="PLR_tab2" onClick="setTab('PLR',2,3)">ѡ��Ա�ģ��</li> 
					<li id="PLR_tab3" onClick="setTab('PLR',3,3)" 
					>�ԱȽ����ʾ</li> 
				</ul> 
			</div>
			<div class="main_tab_content">
				<div id="PLR_con1">
					<div class="subtitle">PLR�Ա�</div>
					<div class="scrollbox">
                     <p style="text-align:center;"><img src="../IMAGE/com/PLR.jpg"></p>                                                          
					</div>
				</div>
				<div id="PLR_con2" style="display:none">
					<div class="subtitle">�Ա�ģ��ѡ��</div>
					<div class="setup">
						<form action="../resultshow/showPLR.jsp" 
								method="post" target="SHOWDATA_PLR"
								onsubmit="return validate_PLR();;">
							<div class="parametersetup_title">�������У�</div>
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
							<div class="parametersetup_title">�Ա�ģ��1��</div>
							<div class="parametersetup_content">
								<select name="model1">
									<option value="JM">J_Mģ��</option>
									<option value="DUANE">DUANEģ��</option>
									<option value="WEIBULL">Weibullģ��</option>
									<option value="GO">G_Oģ��</option>
									<option value="SCHNEIDEWIND">Schneidewindģ��</option>
									<option value="MO">M_Oģ��</option>
									<option value="GammaSRM">GammaSRMģ��</option>
									<option value="ExponentialSRM">ExponentialSRMģ��</option>
									<option value="LogNormalSRM">LogNormalSRMģ��</option>
								</select>
							</div>
							<div class="parametersetup_title">�Ա�ģ��2��</div>
							<div class="parametersetup_content">
							<select name="model2">
								<option value="JM">J_Mģ��</option>
								<option value="DUANE">DUANEģ��</option>
								<option value="WEIBULL">Weibullģ��</option>
								<option value="GO">G_Oģ��</option>
								<option value="SCHNEIDEWIND">Schneidewindģ��</option>
								<option value="GammaSRM">GammaSRMģ��</option>
								<option value="MO">M_Oģ��</option>
								<option value="ExponentialSRM">ExponentialSRMģ��</option>
								<option value="LogNormalSRM">LogNormalSRMģ��</option>
							</select>
							</div>
							<div style="text-align:center">
								<input type="submit" class="button button-pill button-primary" value="�Աȷ���">
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
