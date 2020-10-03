<%@page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="java.io.*,system.*" %>
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="contrastdata" class="system.ContrastData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<jsp:useBean id="ks" class="system.KS" scope="page"></jsp:useBean>
<jsp:useBean id="index" class="system.IndexCalculation" scope="page"></jsp:useBean>
<jsp:useBean id="uychart" class="charts.UYChart" scope="page"></jsp:useBean>
<jsp:useBean id="kschart" class="charts.KSChart" scope="page"></jsp:useBean>
<jsp:useBean id="threestepchart" class="charts.ThreeStepChart" scope="page"></jsp:useBean>
<jsp:useBean id="rechart" class="charts.REChart" scope="page"></jsp:useBean>
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
		<title>���ģ�ͽ����ʾ</title>
    	<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
  		<link rel="stylesheet" type="text/css" href="../../CSS/showtab.css">
  		<link rel="stylesheet" type="text/css" href="../../CSS/table.css">
  		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">	
  		<script type="text/javascript" src="../../JS/onload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
	</head>
	<body onload="onload_merger();">
	<%	if(request.getParameter("modelselect")==null)		//ֻ�д���ʱ������ҳ����ʾ
		{%>
 			<div class="subtitle">���޽����ʾ</div>
 	<%	}
 		else
 		{
 			int sequence = Integer.parseInt(request.getParameter("Sequence"));
 			double data_train[] = inputdata.getdata_train(sequence);	//��ȡ��ǰ����ѵ����
 			double data_test[] = inputdata.getdata_test(sequence);		//��ȡ��ǰ���ݲ��Լ�
 			int step = calculate_mix_ln.getstep();
 			String colname = inputdata.getcolname(sequence);
 			String model = request.getParameter("model");
	 		String modelselect = request.getParameter("modelselect");
	 		String[] parameter_str = parameterinfo.getparameter(modelselect);
	 		double[] parameter = new double[parameter_str.length];
 			for(int i=0; i<parameter.length; i++)
 			{
 				parameter[i] = Double.parseDouble(parameter_str[i]);
 			}
	 		calculate_mix_ln.calculate(modelselect, parameter);
	 		double[] outdata = calculate_mix_ln.getoutdata();
	 		double[] fitness = new double[1];
			String info = calculate_mix_ln.getparameterinfo(model,modelselect);
			String date = calculate_mix_ln.getdate();
			
			if(data_test.length!=0)
			{
	 			index.calculation(data_test,outdata);		//��������ܲ���
	 			ks.inputdata(data_test, outdata);
	    		contrastdata.entry(sequence,"LN",outdata,data_test.length,date,info,
	    							index.getMSE(),index.getR_Square(),
	    							index.getAE(),index.getMSPE());	//��ִ����Ϣ����Ա����ݼ�
	    	}
	%>			
 						<div class="show_tab_menu">
    			<div style="width:100%;">
					<ul> 
						<li id="resultAssemble_tab1" onClick="setTab('resultAssemble',1,4)" class="hover">
							Ԥ������
						</li> 
						<li id="resultAssemble_tab2" onClick="setTab('resultAssemble',2,4)">
							���ܲ���
						</li> 
						<li id="resultAssemble_tab3" onClick="setTab('resultAssemble',3,4)">
							�в����
						</li>
						<li id="resultAssemble_tab4" onClick="setTab('resultAssemble',4,4)">
							����-Ԥ��ͼ
						</li>
					</ul> 
				</div>
				<div class="subtitle">
					���ʱ��:<br>
				<%= date%>
				</div>
    		</div>
    		<div class="show_tab_content">
				<div id="resultAssemble_con1">
					<div class="subtitle">Ԥ������</div>
					<div class="scrollbox">
						<table>
    						<tr>
  	 							<th>���</th>
  	 							<th>��ʵ����</th>
  	 							<th>��������</th>
  	 						</tr>
  	 					<% 	int i=0;
  	 						for(int k=inputdata.getlength_train()+1;
  	 						i<inputdata.getlength_test();i++,k++)
							{%>
  	 						<tr <% if(i%2==0) {%>class="altrow"<%}%>>
  	 							<td><%= k%></td>
  	 							<td><%= data_test[i]%></td>
  	 							<td><%= outdata[i]%></td>
  	 						</tr>
  	 					<%	}%>
  	 					</table>
    					<table>
    						<tr>
  	 							<th>Ԥ�ⲽ��</th>
  	 							<th>Ԥ������</th>
  	 						</tr>
    					<%	for(int k=1;i<step;i++,k++)
    						{%>
    						<tr <% if(k%2==1) {%>class="altrow"<%}%>>
    							<td>��<%= k%>��</td>
  	 							<td><%= outdata[i]%></td>
  	 						</tr>
    					<%	}%>
    					</table>
					</div>
    			</div>
				<div id="resultAssemble_con2" style="display:none">
					<div class="subtitle">���ܲ���</div>
					<br><br>
					<div class="note">
						<table style="width:80%">
							<tr>
								<th>������</th>
								<th>MSE</th>
								<th>R_Square</th>
								<th>AE</th>
								<th>MSPE</th>
							</tr>
							<tr>
								<th>��������</th>
								<td>��ֵ���ƽ����</td>
								<td>�����ɾ�ϵ��</td>
								<td>��ֵ���</td>
								<td>�����ٷֱ����</td>
							</tr>
							<tr>
								<th>��ʽ</th>
								<td><img src="../../IMAGE/formula/MSE.png" 
									height="100%" width="100%"/></td>
								<td><img src="../../IMAGE/formula/R_Square.png" 
									height="100%" width="100%"/></td>
								<td><img src="../../IMAGE/formula/AE.png" 
									height="100%" width="100%"/></td>
								<td><img src="../../IMAGE/formula/MSPE.png" 
									height="100%" width="100%"/></td>
							</tr>
							<tr class="altrow">
								<th>ֵ</th>
								<td>
								<%	if(data_test.length==0) { out.print("-");}
									else { out.print(index.getMSE());} %>
								</td>
								<td>
								<%	if(data_test.length==0) { out.print("-");}
									else { out.print(index.getR_Square());} %>
								</td>
								<td>
								<%	if(data_test.length==0) { out.print("-");}
									else { out.print(index.getAE());} %>
								</td>
								<td>
								<%	if(data_test.length==0) { out.print("-");}
									else { out.print(index.getMSPE());} %>
								</td>
							</tr>
						</table>
						<br>
						(<b>ע��</b>��ʽ�У�<i>y<sub>i</sub></i>��ʾ���ݵ�ʵ��ֵ��
						<i>y'<sub>i</sub></i>��ʾ���ݵ�Ԥ��ֵ��
					 	<i>y<sub>ave</sub></i>��ʾ�۲�����<i>y<sub>i</sub></i>�ľ�ֵ��)
					</div>
				</div> 
			 <%	String filename,graphURL;%>
				<div id="resultAssemble_con3" style="display:none;text-align:center;">
				<%	if(data_test.length==0)
					{%>
						<div class="subtitle">�޲��Լ����ݣ�</div>
				<%	}
					else
					{					
						filename = rechart.generateLineChart(index.getRE(),data_train.length,
															session,new PrintWriter(out));
		     			graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;
		     	%>
						<img src="<%= graphURL %>">
				<%	}%>
				</div>
				<div id="resultAssemble_con4" style="display:none;text-align:center;">
			    <% 	filename = threestepchart.generateLineChart(data_train,data_test,outdata,fitness,
				    											"LN",colname,session,new PrintWriter(out));
     				graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;%>
					<img src="<%= graphURL %>">
				</div>
			</div>	
 	
 	
 	<%	}%>
	</body>
</html>