<%@ page language="java" import="java.util.*,system.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<!-- javabean:inputdata ��ǰʹ������ | parameterinfo Ĭ�ϲ�����Ϣ -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<%
	
	ReadTable rt =new ReadTable();
	HistoryData historydata=new HistoryData();
	ArrayList<DataSet> list=rt.getDataSet(0);
	for(int i=0;i<list.size();i++){
		DataSet ds=list.get(i);	
		historydata.entry(ds.getData(), ds.getSetname(), ds.getColname(), ds.getSetinfo());
	
	}
	
		DataSet curds=list.get(list.size()-1);
		inputdata.setdata(curds.getData(),		//�ñ�ѡ���ݼ��е�ָ�������滻����ǰ����
		 			curds.getSetname(),
		 			curds.getColname(),
		  			curds.getPercent(),
					curds.getSetinfo());
%>
<html>
	<head>
		<title>EWģ��</title>
		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
	    <link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">	
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/addsubmodel.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/button/combination/validate_Combination.js" 
  		charset="gb2312"></script>
	</head>
	<body>
		<div id="loader_container" style="display:none">   <!-- ִ�еȴ��� -->
			<div id="loader">
				<div align="center">����ִ�У����Ժ� ...</div>
				<div id="loader_bg">
					<div id="progress"></div>
				</div>
			</div>
		</div>
		<input type="hidden" id="flag" value="0">
		<div class="titlename">��Ȩ�����ģ��</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="EW_tab1" onClick="setTab('EW',1,4)" class="hover">ģ�ͼ��</li> 
					<li id="EW_tab2" onClick="setTab('EW',2,4)" >ʧЧ����</li> 
					<li id="EW_tab3" onClick="setTab('EW',3,4)">ģ��ѡ��</li>
					<li id="EW_tab4" onClick="setTab('EW',4,4)" style="display:none">�������</li> 
				</ul>
			</div>
			<div class="main_tab_content">
				<div id="EW_con1">
					<div class="subtitle">ģ�ͼ��</div>
										<div class="scrollbox">
						<p style="text-align:center;"><img src="../../IMAGE/com/EW.jpg"></p>
					</div>
				</div>
				<div id="EW_con2" style="display:none">
					<%-- <div class="subtitle">���ݻ�����Ϣ</div>
					<div class="currentdata">
						�������ƣ�<%= inputdata.getdataname()%><br><br>
  	 					����������<%= inputdata.getlength_train()+inputdata.getlength_test()%><br><br>
  	 					ѵ�����ݣ�<%= inputdata.getlength_train()%><br><br>
  	 					�������ݣ�<%= inputdata.getlength_test()%><br><br>
						����ά���� <%= inputdata.getdimension()%><br><br>
  	 					����������<%= inputdata.getdatainfo()%>
					</div> --%>
					<iframe src="../../resultshow/showhistorydata2.jsp"></iframe>
				</div>
				<div id="EW_con3" style="display:none">
					<div class="subtitle">ģ��ѡ��</div>
					<div class="setup" style="height:84%">
						<form action="../../resultshow/resultCombination.jsp" method="post"
								target="SHOWDATA_EW" onsubmit="return validate_Combination(this);">
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
							<div class="parametersetup_title">Ԥ�ⲽ����</div>
							<div class="parametersetup_content">
								<input type="text" name="prestep" value="<%= parameterinfo.getstep()%>">
										(���÷�Χ��0-100�� ����ģ�����Ԥ��Ĳ���)
							</div>
							<div style="text-align:center;">
								<input type="button" class="button button-pill button-primary" onClick="addmodel();" value="����ģ��">
								<input type="button" class="button button-pill button-primary" onClick="submodel();" value="����ģ��">
							</div>
						<%	for(int i=1;i<=6;i++)
							{%>
								<div id="model<%= String.valueOf(i)%>" class="addsubmodel"
									<% if(i>=3) {%> style="display:none" <%}%>>
									ģ��<%= String.valueOf(i)%>��
									<select name="modelselect<%= String.valueOf(i)%>">
										<option value="BPN" selected>BPNģ��</option>
										<option value="RBFN">RBFNģ��</option>
										<option value="GEP">GEPģ��</option>
										<option value="GM">GMģ��</option>
										<option value="SVM">SVMģ��</option>
										<option value="ARIMA">ARIMAģ��</option>
										<option value="JM">J_Mģ��</option>
										<option value="DUANE">DUANEģ��</option>
										<option value="WEIBULL">Weibullģ��</option>
										<option value="GammaSRM">GammaSRMģ��</option>
										<option value="ExponentialSRM">ExponentialSRMģ��</option>
										<option value="LogNormalSRM">LogNormalSRMģ��</option>
										<option value="GO">G_Oģ��</option>
										<option value="SCHNEIDEWIND">Schneidewindģ��</option>
										<option value="MO">M_Oģ��</option>
	<!-- **********************************����ģ�ͽӿ�********************************** -->
	<!-- **********************************����ģ�ͽӿ�********************************** -->
	<!-- **********************************����ģ�ͽӿ�********************************** -->
	<!-- **********************************����ģ�ͽӿ�********************************** -->
	<!-- **********************************����ģ�ͽӿ�********************************** -->
									</select>
							</div>
						<%	}%>
							<div style="text-align:center">
								<input type="hidden" id="model" name="model" value="EW">
								<input type="hidden" id="number" name="number" value="2">
								<input type="hidden" id="current_tab" value="3">
								<input type="submit" class="button button-pill button-primary" value="Ԥ��">
							</div>
						</form>
					</div>	
				</div>
				<div id="EW_con4" style="display:none">
					<iframe name="SHOWDATA_EW" src="../../resultshow/resultCombination.jsp"></iframe>
				</div>
			</div>		
		</div>
	</body>
</html>