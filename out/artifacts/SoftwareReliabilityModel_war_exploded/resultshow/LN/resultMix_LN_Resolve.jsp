<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="java.io.*,system.*"%>
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<jsp:useBean id="resolvechart" class="charts.ResolveChart" scope="page"></jsp:useBean>
<jsp:useBean id="calculate_mix_ln" class="calculate.CalculateMix_LN" 
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
		inputdata.setdata(curds.getData(),		//�ñ�ѡ���ݼ��е�ָ�������滻����ǰ����
		 			curds.getSetname(),
		 			curds.getColname(),
		  			curds.getPercent(),
					curds.getSetinfo());
%>
<html>
	<head>
		<title>���ģ�ͷֽ�����ʾ</title>
    	<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
  		<link rel="stylesheet" type="text/css" href="../../CSS/showtab.css">
  		<link rel="stylesheet" type="text/css" href="../../CSS/table.css">
  		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">	
  		
		<script type="text/javascript" src="../../JS/onload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/button/mix/validate_LN.js" 
		charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/button/mix/validate_merger.js" 
		charset="gb2312"></script>
	</head>
	<body onload="onload();">
	<%	if(request.getParameter("modelselect")==null)		//ֻ�д���ʱ������ҳ����ʾ
		{%>
 			<div class="subtitle">���޽����ʾ</div>
 	<%	}
 		else
 		{
 			int Sequence = Integer.parseInt(request.getParameter("Sequence"));
 			double data_train[] = inputdata.getdata_train(Sequence);	//��ȡ��ǰ����ѵ����
 			String colname = inputdata.getcolname(Sequence);
 			String model = request.getParameter("modelselect");
 			int step = Integer.parseInt(request.getParameter("prestep")) +
 										inputdata.getlength_test();
 			String[] parameter_str = parameterinfo.getparameter(model);
 			double[] parameter = new double[parameter_str.length];
 			for(int i=0; i<parameter.length; i++)
 			{
 				parameter[i] = Double.parseDouble(parameter_str[i]);
 			}
 			double[][] resolvedata = calculate_mix_ln.inputdata(data_train, step, model, parameter);
 		%>
 			<div class="show_tab_menu">
 				<div style="width:100%;">
					<ul> 
						<li id="resultMix_ln_tab1" onClick="setTab('resultMix_ln',1,3)" class="hover">
							�ֽ����ݱ�
						</li> 
						<li id="resultMix_ln_tab2" onClick="setTab('resultMix_ln',2,3)">
							�ֽ�����ͼ
						</li> 
						<li id="resultMix_ln_tab3" onClick="setTab('resultMix_ln',3,3)">
							ģ������
						</li>
					</ul> 
				</div>
 			</div>
 			<div class="show_tab_content">
 				<div id="resultMix_ln_con1">
 					<div class="subtitle">�в����зֽ��</div>
 					<div class="scrollbox">
 						<table>
 						 	<tr>
 								<th>���</th>
 								<th><%= model%></th>
 								<th>�в�����</th>
 							</tr>
 						<%	for(int i=0; i<resolvedata[0].length; i++)
 							{%>
 								<tr <% if(i%2==0) {%>class="altrow"<%}%>>
 									<td><%= String.valueOf(i+1)%></td>
 									<td><%= resolvedata[0][i]%></td>
 									<td><%= resolvedata[1][i]%></td>
 								</tr>
 						<%	}%>
 						</table>
 					</div>
 				</div>
 				<div id="resultMix_ln_con2" style="display:none;text-align:center;">
 				<%	String filename,graphURL;
					filename= resolvechart.generateLineChart(resolvedata[0],model,colname,
																session,new PrintWriter(out));
     				graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;%>
					<img src="<%= graphURL%>">
				<%	filename= resolvechart.generateLineChart(resolvedata[1],"�в�����",colname,
															session,new PrintWriter(out));
     				graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;%>
					<img src="<%= graphURL%>">
 				</div>
 				<div id="resultMix_ln_con3" style="display:none;" align="center">
					<br><br>
					<form action="resultMix_LN_Merger.jsp" method="post"
									target="SHOWDATA_LN_MERGER"
									onsubmit="return validata_LN_merger(this);">
						�в�ģ�ͣ�
						<select	name="modelselect">
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
							<option value="LogLogisticSRM">LogLogisticSRMģ��</option>
							<option value="ParetoSRM">ParetoSRMģ��</option>
							<option value="MO">M_Oģ��</option>
<!-- **********************************����ģ�ͽӿ�********************************** -->
<!-- **********************************����ģ�ͽӿ�********************************** -->
<!-- **********************************����ģ�ͽӿ�********************************** -->
<!-- **********************************����ģ�ͽӿ�********************************** -->
<!-- **********************************����ģ�ͽӿ�********************************** -->
						</select>
						<br><br>
						<input type="hidden" name="model" value="<%= model%>">
						<input type="hidden" name="Sequence" value="<%= Sequence%>">
						<input type="submit" class="button button-pill button-primary" value="Ԥ��">
					</form>
 				</div>
 			</div>
 	<%	}%>
	</body>
</html>