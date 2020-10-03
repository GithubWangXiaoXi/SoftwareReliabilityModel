<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="java.io.*,system.*" %>
<!-- javabean:inputdata ��ǰʹ������ | parameterinfo Ĭ�ϲ�����Ϣ | resolve �ֽ����ݼ�
				emd EMD�ֽ�ģ�ͷ����ӿ� | ssa SSA�ֽ�ģ�ͷ����ӿ� | wave WAVE�ֽ�ģ�ͷ����ӿ�
				ln L+N�ֽ�ģ�ͷ����ӿ� | resolvechart �ֽ�ͼ��������ӿ� -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<jsp:useBean id="resolve" class="system.Resolve" scope="page"></jsp:useBean>
<jsp:useBean id="resolvechart" class="charts.ResolveChart" scope="page"></jsp:useBean>
<jsp:useBean id="calculate_mix_resolve" class="calculate.CalculateMix_Resolve" 
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
		<title>���ݷֽ�����ʾ</title>
    	<link rel="stylesheet" type="text/css" href="../CSS/universal.css">
  		<link rel="stylesheet" type="text/css" href="../CSS/showtab.css">
  		<link rel="stylesheet" type="text/css" href="../CSS/table.css">
  		<link rel="stylesheet" type="text/css" href="../CSS/waitload.css">
  		<link rel="stylesheet" type="text/css" href="../CSS/buttons.css">	
		<script type="text/javascript" src="../JS/onload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../JS/waitload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../JS/button/mix/validate_merger.js" 
		charset="gb2312"></script>
	</head>

	<body onload="onload();">
	<%	if(request.getParameter("model")==null)		//ֻ�д���ʱ������ҳ����ʾ
		{%>
 			<div class="subtitle">���޽����ʾ</div>
 	<%	}
 		else
 		{
 			int Sequence = Integer.parseInt(request.getParameter("Sequence"));
 			double data_train[] = inputdata.getdata_train(Sequence);	//��ȡ��ǰ����ѵ����
 			String colname = inputdata.getcolname(Sequence);
 			String model=request.getParameter("model");			//��ȡģ����
 			double[][] resolvedata=new double[1][1];
 			//����ҳ������������ݴ�ֽ�����
 			String resolvename="";	//����ҳ������������ݴ�ģ�ͷֽ���
 			double[] parameter = new double[2];
 			double[] SSA_SinglePercent = new double[1];
 			//����ҳ������������ݴ�ģ�Ͳ���			
 			if(request.getParameter("Combination") == null)
 			{
 				parameter[0]=Double.parseDouble(request.getParameter(model+"_parameter1"));
	 			parameter[1]=Double.parseDouble(request.getParameter(model+"_parameter2"));
 				calculate_mix_resolve.inputdata(data_train, model, parameter);
 				resolvedata=calculate_mix_resolve.getoutdata();
	 			resolvename=calculate_mix_resolve.getresolvename(model);
	 			if(model.equals("SSA"))
 				{
 					SSA_SinglePercent = calculate_mix_resolve.getSSA_SinglePercent();
 					resolve.setSinglePercent(SSA_SinglePercent);
 				}
 				resolve.setdata(resolvedata);
 			}
 			else
 			{
 				resolve.combination(model);
 				resolvedata=resolve.getdata();
 				resolvename=request.getParameter("resolvename");
 				if(model.equals("SSA"))
 				{
 					SSA_SinglePercent = resolve.getSinglePercent();
 				}
 			}
 			int resolvenumber = resolvedata.length;
 			%>
 			<input type="hidden" id="resolvenumber" value="<%= resolvenumber%>">
			<div class="show_tab_menu">
				<div style="width:100%;">
					<ul> 
						<li id="resultResolve_tab1" onClick="setTab('resultResolve',1,4)" class="hover">
							�ֽ����ݱ�
						</li> 
						<li id="resultResolve_tab2" onClick="setTab('resultResolve',2,4)">
							�ֽ�����ͼ
						</li> 
						<li id="resultResolve_tab3" onClick="setTab('resultResolve',3,4)">
							�ϲ�����
						</li>
						<li id="resultResolve_tab4" onClick="setTab('resultResolve',4,4)">
							Ԥ�����
						</li> 
					</ul> 
				</div>
			</div>
			<div class="show_tab_content">
				<div id="resultResolve_con1">
					<div class="subtitle"><%= model%>�ֽ��</div>
					<div class="scrollbox">
						<table>
							<tr>
								<th>���</th>
								<th>ԭʼ����</th>
							<%	for(int j=1;j<=resolvenumber;j++)
							 	{%>
  	 							<th><%= resolvename%><%= String.valueOf(j)%></th>
  	 						<%	} %>
  	 						</tr>
  	 					<%	for(int i=0;i<data_train.length;i++)
  	 						{%>
  	 							<tr <% if(i%2==0) {%>class="altrow"<%}%>>
  	 								<td><%= i+1%></td>
  	 								<td><%= data_train[i]%></td>
  	 							<%	for(int j=0;j<resolvedata.length;j++)
  	 								{%>
  	 									<td><%= resolvedata[j][i]%></td>
  	 							<%	}%>
  	 							</tr>
  	 					<%	}%>
						</table>
					</div>
				</div>
				<div id="resultResolve_con2" class="scrollbox" style="display:none;text-align:center;">
				<%	String filename,graphURL;
					for(int i=0;i<resolvenumber;i++)
					{
						filename= resolvechart.generateLineChart(resolvedata[i],
																resolvename+String.valueOf(i+1),
																colname,
																session,
																new PrintWriter(out));
     					graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;%>
						<img src="<%= graphURL%>">
				<%	}%>
				</div>
				<div id="resultResolve_con3" style="display:none;">
					<form action="../model/Mix/<%= model%>.jsp" method="post"
								target="MAIN"
								onsubmit="return validata_combination(this);">
						<div class="scrollbox" align="center">
							<table>
								<tr>
									<th>ѡ��ϲ�</th>
									<th>�ֽ���</th>
								<%	if(model.equals("SSA"))
									{%>
										<th>����ֵ</th>
								<%	}%>
								</tr>
							<%	for(int i=1;i<=resolvenumber;i++)
								{%>
									<tr <% if(i%2==1) {%>class="altrow"<%}%>>
										<td>
											<input type="checkbox" name="select"
												value="<%= String.valueOf(i)%>">
										</td>
										<td><%= resolvename%><%= String.valueOf(i)%></td>
									<%	if(model.equals("SSA"))
									{%>
										<th><%= SSA_SinglePercent[i-1]%></th>
								<%	}%>
									</tr>
							<%	}%>
							</table>
							<br>
							<input type="hidden" name="Sequence" value="<%= Sequence%>">
							<input type="hidden" name="resolvename" value="<%= resolvename%>">
							<input type="hidden" name="resolveflag" value="1">
							<input type="hidden" name="model" value="<%= model%>">
							<input type="submit" class="button button-pill button-primary" value="�ϲ�">
						</div>
					</form>
				</div>
				<div id="resultResolve_con4" style="display:none">
					<div class="subtitle">ģ������</div>
				<%	if(resolvenumber>10) 
					{%>
						<br><div class="subtitle">�ֽ��������10��������</div>
				<%	} 
					else
					{%>
						<div class="scrollbox" align="center">
							<form action="resultMix_Merger.jsp" method="post"
									target="SHOWDATA_<%= model%>_MERGER"
									onsubmit="return validata_merger(this);">
								Ԥ�ⲽ����<input type="text" name="prestep" 
								value="<%= parameterinfo.getstep()%>">
								<span class="setup_description">
									(���÷�Χ��0-100�� ����ģ�����Ԥ��Ĳ���)
								</span>
								<br>
								<table>
									<tr>
										<td></td>
										<th>��������</th>
										<th>ѡ��ģ��</th>
									</tr>
								<%	for(int i=1;i<=resolvenumber;i++)
									{%>
										<tr <% if(i%2==1) {%>class="altrow"<%}%>>
											<td>
											<% 	if(i==1)
												{%>
													<input type="button" class="button button-pill button-primary" 
													onClick="aftersame(1);" value="��ͬ" style="width:80px">
											<%	}
												if(i==2)
												{%>
													<input type="button" class="button button-pill button-primary" 
													onClick="aftersame(2);" value="��ͬ" style="width:80px">
											<%	}%>
											</td>
											<td><%= resolvename%><%= String.valueOf(i)%></td>
											<td>
												<select id="modelselect<%= String.valueOf(i)%>" 
												name="modelselect<%= String.valueOf(i)%>">
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
													<option value="LogLogisticSRM">LogLogisticSRMģ��</option>
										            <option value="ParetoSRM">ParetoSRMģ��</option>
													<option value="GO">G_Oģ��</option>
													<option value="SCHNEIDEWIND">Schneidewindģ��</option>
													<option value="MO">M_Oģ��</option>
	<!-- **********************************����ģ�ͽӿ�********************************** -->
	<!-- **********************************����ģ�ͽӿ�********************************** -->
	<!-- **********************************����ģ�ͽӿ�********************************** -->
	<!-- **********************************����ģ�ͽӿ�********************************** -->
	<!-- **********************************����ģ�ͽӿ�********************************** -->
												</select>
											</td>
										</tr>
								<%	}%>
								</table>
								<br>
								<input type="hidden" name="model" value="<%= model%>">
								<input type="hidden" name="Sequence" value="<%= Sequence%>">
								<input type="submit" class="button button-pill button-primary" value="Ԥ��">
							</form>
						</div>
					<%}%>
				</div>
			</div>
 	<%	}%>
	</body>
</html>