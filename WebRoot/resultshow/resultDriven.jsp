<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="charts.*,java.io.*,system.*" %>
<!-- javabean:inputdata ��ǰʹ������ | contrastdata �Ա����ݼ� | index ���ܲ������㷽��ʵ�� 
				parameterinfo Ĭ�ϲ�����Ϣ | bpn BPNģ�ͷ����ӿ� | rbfn RBFNģ�ͷ����ӿ�
				gep GEPģ�ͷ����ӿ� | svm SVMģ�ͷ����ӿ� | gm GMģ�ͷ����ӿ�
				arima ARIMAģ�ͷ����ӿ� | threestepchart ����ͼ��������ӿ�
				rechart ���ٷֱ�ͼ��������ӿ� -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="contrastdata" class="system.ContrastData" scope="page"></jsp:useBean>
<jsp:useBean id="index" class="system.IndexCalculation" scope="page"></jsp:useBean>
<jsp:useBean id="ks" class="system.KS" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<jsp:useBean id="kschart" class="charts.KSChart" scope="page"></jsp:useBean>
<jsp:useBean id="threestepchart" class="charts.ThreeStepChart" scope="page"></jsp:useBean>
<jsp:useBean id="rechart" class="charts.REChart" scope="page"></jsp:useBean>
<jsp:useBean id="calculate_datadriven" class="calculate.CalculateDataDriven" scope="session"></jsp:useBean>
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
		<title>��������ģ�ͽ����ʾ</title>
    	<link rel="stylesheet" type="text/css" href="../CSS/universal.css">
  		<link rel="stylesheet" type="text/css" href="../CSS/showtab.css">
  		<link rel="stylesheet" type="text/css" href="../CSS/table.css">
		<script type="text/javascript" src="../JS/onload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../JS/tab.js" charset="gb2312"></script>
	</head>
	
	<body onload="onload();">
	<%	if(request.getParameter("model")==null)		//ֻ�д���(Ԥ�ⰴť)ʱ������ҳ����ʾ
		{%>
 			<div class="subtitle">���޽����ʾ</div>
 	<%	}	
 		else
 		{
 			//��inputdata���ݱ����ڵ�ǰҳ�������
 			int sequence = Integer.parseInt(request.getParameter("Sequence"));
 			double data_train[] = inputdata.getdata_train(sequence);	//��ȡ��ǰ����ѵ����
 			double data_test[] = inputdata.getdata_test(sequence);		//��ȡ��ǰ���ݲ��Լ�
 			String colname = inputdata.getcolname(sequence);
 			int step = Integer.parseInt(request.getParameter("prestep"))
 						+inputdata.getlength_test();			//��ȡԤ���ܲ���
 			String model=request.getParameter("model");			//��ȡģ����
 			double[] parameter=new double[parameterinfo.getnumber(model)];
 			//����ҳ������������ݴ�ģ�Ͳ���
 			for(int i=0;i<parameter.length;i++)
 			{
 				parameter[i]=Double.parseDouble(
 							request.getParameter(model+"_parameter"+String.valueOf(i+1)));
 			}
			calculate_datadriven.inputdata(data_train, model, step, parameter);
			double[] outdata = calculate_datadriven.getoutdata();  //�õ�Ԥ�����ݡ�
			double[] fitness = calculate_datadriven.getfitness();  //�õ�������ݡ�
 			String process = calculate_datadriven.getprocess();
 			String str_parameterinfo = calculate_datadriven.getparameterinfo();
 			String date = calculate_datadriven.getdate();
 			ks.inputdata(data_train, fitness);
			if(data_test.length!=0)
			{
 				index.calculation(data_test,outdata);		//��������ܲ���
    			contrastdata.entry(sequence,model,outdata,data_test.length,date,str_parameterinfo,
    							index.getMSE(),index.getR_Square(),
    							index.getAE(),index.getMSPE());	//��ִ����Ϣ����Ա����ݼ�
    		}
    	%>
 			<div class="show_tab_menu">
    			<div style="width:100%;">
					<ul> 
						<li id="resultD_tab1" onClick="setTab('resultD',1,7)" class="hover">Ԥ������</li>
						<li id="resultD_tab2" onClick="setTab('resultD',2,7)">�������</li>
						<li id="resultD_tab3" onClick="setTab('resultD',3,7)">K-S����</li>
						<li id="resultD_tab4" onClick="setTab('resultD',4,7)">ģ�Ͳ���</li> 
						<li id="resultD_tab5" onClick="setTab('resultD',5,7)">���ܲ���</li>
						<li id="resultD_tab6" onClick="setTab('resultD',6,7)">�в����</li>
						<li id="resultD_tab7" onClick="setTab('resultD',7,7)">���-Ԥ��ͼ</li>
					</ul> 
				</div>
				<div class="subtitle">
					���ʱ��:<br>
				<%= date%>
				</div>
    		</div>
    		<div class="show_tab_content">
				<div id="resultD_con1">
					<div class="subtitle">Ԥ������</div>
					<div class="scrollbox">
						<table>
    						<tr>
  	 							<th>���</th>
  	 							<th>��ʵ����</th>
  	 							<th>��������</th>
  	 						</tr>
  	 					<% 	int i=0;
  	 						for(int k=inputdata.getlength_train()+1;i<inputdata.getlength_test();i++,k++)
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
    			<div id="resultD_con2" style="display:none">
					<div class="subtitle">�������</div>
					<div class="scrollbox">
						<table>
    						<tr>
  	 							<th>���</th>
  	 							<th>��ʵ����</th>
  	 							<th>�������</th>
  	 						</tr>
  	 					<% 	for(int j=0;j<data_train.length;j++)
							{%>
  	 						<tr <% if(j%2==0) {%>class="altrow"<%}%>>
  	 							<td><%= j+1%></td>
  	 							<td><%= data_train[j]%></td>
  	 							<td>
  	 							<%	if(fitness[j]==0.001) out.print("-");
  	 								else out.print(fitness[j]);%>
  	 							</td>
  	 						</tr>
  	 					<%	}%>
  	 					</table>
					</div>
    			</div>
    			<%	String filename,graphURL;%>
    			<div id="resultD_con3" style="display:none;text-align:center;">
				<%	filename = kschart.generateLineChart(ks.getFn1(),ks.getFn2(),
																session,new PrintWriter(out));
		     		graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;
		     	%>
					<img src="<%= graphURL %>">
					<br><br>
					<div class="note" style="font-weight:bold;font-size:20px;">
						KS���룺<%= ks.getD()%>��pֵ��<%= ks.getp()%>
					</div>
				</div>
				<div id="resultD_con4" style="display:none">
					<div class="subtitle">���̲���</div>
					<% 
						process = process.replaceAll("\n", "<br>");
					%>
					
					<div class="scrollbox"><%= process%></div>
				</div>
				<div id="resultD_con5" style="display:none">
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
								<td>�ع����߷��̵����ָ��</td>
								<td>��ֵ���</td>
								<td>�����ٷֱ����</td>
							</tr>
							<tr>
								<th>��ʽ</th>
								<td><img src="../IMAGE/formula/MSE.png" height="100%" width="100%"/></td>
								<td><img src="../IMAGE/formula/R_Square.png" height="100%" width="100%"/></td>
								<td><img src="../IMAGE/formula/AE.png" height="100%" width="100%"/></td>
								<td><img src="../IMAGE/formula/MSPE.png" height="100%" width="100%"/></td>
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
				<div id="resultD_con6" style="display:none;text-align:center;">
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
				<div id="resultD_con7" style="display:none;text-align:center;">
			    <% 	filename = threestepchart.generateLineChart(data_train,data_test,outdata,fitness,model,
			    											colname,session,new PrintWriter(out));
     				graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;%>
					<img src="<%= graphURL %>">
				</div>
			</div>
	<%	}%>
	</body>
</html>