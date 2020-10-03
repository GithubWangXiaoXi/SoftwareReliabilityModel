<%@ page language="java" import="java.util.*,system.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<!-- javabean:inputdata ��ǰʹ������ -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<%
	String step = parameterinfo.getstep();


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
		<title>L+Nģ��</title>
   		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/mix/validate_LN.js" 
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
		<input type="hidden" id="model" value="LN">
		<input type="hidden" id="flag" value="0">
		<input type="hidden" id="mergerflag" value="0">
		<input type="hidden" id="current_tab" value="3">
		<div class="titlename">�в�ֽ�ģ��</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="LN_tab1" onClick="setTab('LN',1,5)" class="hover">ģ�ͼ��</li> 
					<li id="LN_tab2" onClick="setTab('LN',2,5)">ʧЧ����</li> 
					<li id="LN_tab3" onClick="setTab('LN',3,5)">�ֽ�����</li>
					<li id="LN_tab4" onClick="setTab('LN',4,5)" style="display:none">�ֽ�����ʾ</li>
					<li id="LN_tab5" onClick="setTab('LN',5,5)" style="display:none">��Ͻ����ʾ</li> 
				</ul> 
			</div> 
			<div class="main_tab_content">
				<div id="LN_con1">
					<div class="subtitle">ģ�ͼ��</div>
					<div class="scrollbox">
						<p>���ڲв����еĻ��ģ�Ϳ�����ʽ����</p>
						<p style="text-align:center;"><img src="../../IMAGE/Mix/LN_1.jpg"></p>
						<p>
							���� ΪԭʼʧЧʱ��������ʱ��<i>t</i>��ֵ��<i>L<sub>t</sub></i>��ʾģ�͵����Բ��֣�
							<i>N<sub>t</sub></i>��ʾģ�͵ķ����Բ��֡�
						</p>
						<p>
						��ʱ�����зֽ�������Բ��ֺͷ����Բ������ݷֱ���þ���ɿ���ģ�ͺͻ���ѧϰģ�ͽ��н�ģ������������Ԥ�⣬Ȼ���Ԥ��������������ϣ�������յ�����ɿ���Ԥ��ֵ��
						</p>
					</div>
				</div>
				<div id="LN_con2" style="display:none">
					<%-- <div class="subtitle">���ݻ�����Ϣ</div>
					<div class="currentdata">
						�������ƣ�<%= inputdata.getdataname()%><br><br>
  	 					����������<%= inputdata.getlength_train()+inputdata.getlength_test()%><br><br>
  	 					ѵ�����ݣ�<%= inputdata.getlength_train()%><br><br>
  	 					�������ݣ�<%= inputdata.getlength_test()%><br><br>
						����ά���� <%= inputdata.getdimension()%><br><br>
  	 					����������<%= inputdata.getdatainfo()%>
					</div>  --%>
					<iframe src="../../resultshow/showhistorydata2.jsp"></iframe>
				</div>
				<div id="LN_con3" style="display:none">
					<div class="subtitle">�ֽ�����</div>
					<div class="setup">
						<form action="../../resultshow/LN/resultMix_LN_Resolve.jsp" method="post"
							target="SHOWDATA_LN_RESOLVE"
							onsubmit="return validate_LN_resolve(this);">
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
								<input type="text" name="prestep" value="<%= step%>">
								(���÷�Χ��0-100�� ����ģ�����Ԥ��Ĳ���)
							</div>
							<div class="parametersetup_title">ģ��ѡ��</div>
							<div class="parametersetup_content">
								<select name="modelselect">
									<option value="BPN" selected>BPNģ��</option>
									<option value="RBFN">RBFNģ��</option>
									<option value="GEP">GEPģ��</option>
									<option value="GM">GMģ��</option>
									<option value="SVM">SVMģ��</option>
									<option value="ARIMA">ARIMAģ��</option>
									<option value="JM">J_Mģ��</option>
									<option value="DUANE">DUANEģ��</option>
									<option value="WEIBULL">Weibullģ��</option>
									<option value="GO">G_Oģ��</option>
									<option value="GammaSRM">GammaSRMģ��</option>
									<option value="ExponentialSRM">ExponentialSRMģ��</option>
									<option value="LogNormalSRM">LogNormalSRMģ��</option>
									<option value="SCHNEIDEWIND">Schneidewindģ��</option>
									<option value="MO">M_Oģ��</option>
<!-- **********************************����ģ�ͽӿ�********************************** -->
<!-- **********************************����ģ�ͽӿ�********************************** -->
<!-- **********************************����ģ�ͽӿ�********************************** -->
<!-- **********************************����ģ�ͽӿ�********************************** -->
<!-- **********************************����ģ�ͽӿ�********************************** -->
								</select>
							</div>
							<div style="text-align:center">
								<input type="submit" class="button button-pill button-primary" value="�ֽ�">
							</div>	
  						</form>
					</div>
				</div>
				<div id="LN_con4" style="display:none">
					<iframe name="SHOWDATA_LN_RESOLVE" 
					src="../../resultshow/LN/resultMix_LN_Resolve.jsp"></iframe>
				</div>
				<div id="LN_con5" style="display:none">
					<iframe name="SHOWDATA_LN_MERGER" 
					src="../../resultshow/LN/resultMix_LN_Merger.jsp"></iframe>
				</div>
			</div>
		</div>
	</body>
</html>