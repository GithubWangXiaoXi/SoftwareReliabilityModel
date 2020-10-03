<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="charts.*,java.io.*,system.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="util.RandomSampling" %>
<%@ page import="util.InputDataChange" %>
<%@ page import="model.faultDetect.boost.AdaBoost" %>
<%@ page import="model.faultDetect.boost.BasicBoost" %>
<%@ page import="util.SoftMax" %>
<%@ page import="util.QuickSort" %>
<%@ page import="model.faultDetect.boost.AdaBoost3" %>
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
//		inputdata.setdata(curds.getData(),		//�ñ�ѡ���ݼ��е�ָ�������滻����ǰ����
//		 			curds.getSetname(),
//		 			curds.getColname(),
//		  			curds.getPercent(),
//					curds.getSetinfo());
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
	<% System.out.println(request.getParameter("model"));
		String model = request.getParameter("model");
		if(model == null)		//ֻ�д���(Ԥ�ⰴť)ʱ������ҳ����ʾ
		{%>
 			<div class="subtitle">���޽����ʾ</div>
 	<%	}
 		else
 		{
 			//��inputdata���ݱ����ڵ�ǰҳ�������
 			int label = Integer.parseInt(request.getParameter("Sequence"));

			//��ȡ�������� mybox
			String[] featureIndex = request.getParameterValues("mybox");
			String[] featureName = curds.getColname();
			String label1 = curds.getColname()[label-1];

// 			double data_train[] = inputdata.getdata_train(label);
// 			double data_test[] = inputdata.getdata_test(label);
// 			String colname = inputdata.getcolname(label);

 			int j = curds.getPercent();
			double[][] inputDataT = curds.getData();

			//��ԭ����inputDataת��
			double[][] inputData = InputDataChange.MatrixTranspose(inputDataT);

			int YIndex = label;
			int[] XIndex = new int[featureIndex.length];
			for (int i = 0; i < featureIndex.length; i++) {
				XIndex[i] = Integer.parseInt(featureIndex[i]);
			}

			//��������зŻصĳ����õ�ѵ���������Լ�
			double[][] x_train, x_test;
			int []y_train, y_test;
			DecimalFormat dF = new DecimalFormat("0.00000000");
			double rate = Double.parseDouble(dF.format((double)j/100));

			int test_size = (int) Math.floor(rate * inputData.length);
			int train_size = inputData.length - test_size;

			//����зŻصĳ���������index˳������
			int []test_RandomWithOrder = new int[test_size];
			int []train_RandomWithOrder = new int[train_size];
			RandomSampling.getNum(test_RandomWithOrder,inputData.length);
			RandomSampling.getNum(train_RandomWithOrder,inputData.length);

			//���Լ�
			x_test = new double[test_size][XIndex.length];
			y_test = new int[test_size];
			int k = 0;
			for (int i = 0; i < test_size; i++) {
				for (int l = 0; l < XIndex.length; l++){
					if(inputData[test_RandomWithOrder[i]][YIndex - 1] == 0.0){
						y_test[k] = -1;
					}else{
						y_test[k] = (int)inputData[test_RandomWithOrder[i]][YIndex - 1];
					}
					x_test[k][l] = inputData[test_RandomWithOrder[i]][XIndex[l] - 1];
				}
				k++;
			}

			//ѵ����
			k = 0;
			x_train = new double[train_size][XIndex.length];
			y_train = new int[train_size];
			for (int i = 0; i < train_size; i++) {
				for (int l = 0; l < XIndex.length; l++){
					if(inputData[train_RandomWithOrder[i]][YIndex - 1] == 0.0){
						y_train[k] = -1;
					}else{
						y_train[k] = (int)inputData[train_RandomWithOrder[i]][YIndex - 1];
					}
					x_train[k][l] = inputData[train_RandomWithOrder[i]][XIndex[l] - 1];
				}
				k++;
			}

			//��ȡģ��
		    BasicBoost basicBoost;
			if(featureIndex.length == 1){
				basicBoost = new AdaBoost();  //���ֻ��һ����������ѡ��AdaBoost
			}else{
				basicBoost = new AdaBoost3(); //����ж����������ѡ��AdaBoost2
			}

			//���²���
			String height = request.getParameter("height"); //��ȡ���ĸ߶� height
			basicBoost.setHeight(Integer.parseInt(height));

			String times = request.getParameter("times"); //��ȡ�������� times
			basicBoost.setTIMES(Integer.parseInt(times));

			String threshold = request.getParameter("threshold"); //��ȡ��ֵ threshold
			basicBoost.setShrehold(Double.parseDouble(threshold));

			basicBoost.inputdata(x_train,y_train,x_test,y_test,featureName,label1);
			basicBoost.calculate();

			int[] outdata;
			double[] TPRArr = new double[95];
			double[] FPRArr = new double[95];
			int temp = 0;
			for (double t = 0.95; t > 0.0 ; t -= 0.01) {

				System.out.println();
				System.out.println("��ֵΪ��" + t);
				outdata = basicBoost.getoutdata(t);

				for (int l = 0; l < XIndex.length; l++) {
					System.out.print(featureName[XIndex[l] - 1] + "  ");
				}
				System.out.println(featureName[YIndex - 1] + "  " + "Ԥ��ֵ");

				for (int i = 0; i < x_test.length; i++) {
					for (int l = 0; l < x_test[i].length; l++) {
						System.out.print(x_test[i][l] + "   ");
					}
					System.out.print(y_test[i] + "  ");

					if (outdata[i] == 0){
						int num = -1;
						System.out.println(num);
					}else{
						System.out.println(outdata[i]);
					}
				}

				//������ֵ����ò�ͬ��TPR,FPR

				ROC roc = new ROC(y_test,outdata);
				TPRArr[temp] = roc.getTPR();
				FPRArr[temp] = roc.getFPR();
				System.out.println("TPR��" + roc.getTPR());
				System.out.println("FPR��" + roc.getFPR());

				double correctRate =basicBoost.getCorrectRate();
				System.out.println("׼ȷ�ʣ�" + correctRate * 100 + "%");

				temp++;
			}

		    outdata = basicBoost.getoutdata();

 			String date = calculate_datadriven.getdate();

 			RocChart rocChart = new RocChart();
    	%>
 			<div class="show_tab_menu">
    			<div style="width:100%;">
					<ul> 
						<li id="resultD_tab1" onClick="setTab('resultD',1,7)" class="hover">Ԥ������</li>
						<li id="resultD_tab2" onClick="setTab('resultD',2,7)">ROC����</li>
						<li id="resultD_tab3" onClick="setTab('resultD',3,7)">ģ�Ͳ���</li>
						<li id="resultD_tab4" onClick="setTab('resultD',4,7)">���ܲ���</li>
					<%--<li id="resultD_tab5" onClick="setTab('resultD',5,7)">���ܲ���</li>--%>
						<%--<li id="resultD_tab6" onClick="setTab('resultD',6,7)">�в����</li>--%>
						<%--<li id="resultD_tab7" onClick="setTab('resultD',7,7)">���-Ԥ��ͼ</li>--%>
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
  	 						for(; i < test_RandomWithOrder.length;i++)
							{%>
  	 						<tr <% if(i%2==0) {%>class="altrow"<%}%>>
  	 							<td><%= test_RandomWithOrder[i]%></td>
  	 							<td><%= y_test[i]%></td>
  	 							<td><%= outdata[i]%></td>
  	 						</tr>
  	 					<%	}%>
  	 					</table>
					</div>
    			</div>
    			<%--<div id="resultD_con2" style="display:none">--%>
					<%--<div class="subtitle">�������</div>--%>
					<%--<div class="scrollbox">--%>
						<%--<table>--%>
    						<%--<tr>--%>
  	 							<%--<th>���</th>--%>
  	 							<%--<th>��ʵ����</th>--%>
  	 							<%--<th>�������</th>--%>
  	 						<%--</tr>--%>
  	 					<%--<% 	for(int j=0;j<data_train.length;j++)--%>
							<%--{%>--%>
  	 						<%--<tr <% if(j%2==0) {%>class="altrow"<%}%>>--%>
  	 							<%--<td><%= j+1%></td>--%>
  	 							<%--<td><%= data_train[j]%></td>--%>
  	 							<%--<td>--%>
  	 							<%--<%	if(fitness[j]==0.001) out.print("-");--%>
  	 								<%--else out.print(fitness[j]);%>--%>
  	 							<%--</td>--%>
  	 						<%--</tr>--%>
  	 					<%--<%	}%>--%>
  	 					<%--</table>--%>
					<%--</div>--%>
    			<%--</div>--%>

    			<%	String filename,graphURL;%>
    			<div id="resultD_con2" style="display:none;text-align:center;">
				<%	filename = rocChart.generateLineChart(TPRArr,FPRArr,session,new PrintWriter(out));
		     		graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;
		     	%>
					<img src="<%= graphURL %>">
					<br><br>
					<%--<div class="note" style="font-weight:bold;font-size:20px;">--%>
						<%--KS���룺<%= ks.getD()%>��pֵ��<%= ks.getp()%>--%>
					<%--</div>--%>
				</div>

				<div id="resultD_con3" style="display:none">
				</div>

				<div id="resultD_con4" style="display:none">
				</div>

				<%--<div id="resultD_con5" style="display:none">--%>
					<%--<div class="subtitle">���ܲ���</div>--%>
					<%--<br><br>--%>
					<%--<div class="note">--%>
						<%--<table style="width:80%">--%>
							<%--<tr>--%>
								<%--<th>������</th>--%>
								<%--<th>MSE</th>--%>
								<%--<th>R_Square</th>--%>
								<%--<th>AE</th>--%>
								<%--<th>MSPE</th>--%>
							<%--</tr>--%>
							<%--<tr>--%>
								<%--<th>��������</th>--%>
								<%--<td>��ֵ���ƽ����</td>--%>
								<%--<td>�ع����߷��̵����ָ��</td>--%>
								<%--<td>��ֵ���</td>--%>
								<%--<td>�����ٷֱ����</td>--%>
							<%--</tr>--%>
							<%--<tr>--%>
								<%--<th>��ʽ</th>--%>
								<%--<td><img src="../IMAGE/formula/MSE.png" height="100%" width="100%"/></td>--%>
								<%--<td><img src="../IMAGE/formula/R_Square.png" height="100%" width="100%"/></td>--%>
								<%--<td><img src="../IMAGE/formula/AE.png" height="100%" width="100%"/></td>--%>
								<%--<td><img src="../IMAGE/formula/MSPE.png" height="100%" width="100%"/></td>--%>
							<%--</tr>--%>
							<%--<tr class="altrow">--%>
								<%--<th>ֵ</th>--%>
								<%--<td>--%>
								<%--<%	if(data_test.length==0) { out.print("-");}--%>
									<%--else { out.print(index.getMSE());} %>--%>
								<%--</td>--%>
								<%--<td>--%>
								<%--<%	if(data_test.length==0) { out.print("-");}--%>
									<%--else { out.print(index.getR_Square());} %>--%>
								<%--</td>--%>
								<%--<td>--%>
								<%--<%	if(data_test.length==0) { out.print("-");}--%>
									<%--else { out.print(index.getAE());} %>--%>
								<%--</td>--%>
								<%--<td>--%>
								<%--<%	if(data_test.length==0) { out.print("-");}--%>
									<%--else { out.print(index.getMSPE());} %>--%>
								<%--</td>--%>
							<%--</tr>--%>
						<%--</table>--%>
						<%--<br>--%>
						<%--(<b>ע��</b>��ʽ�У�<i>y<sub>i</sub></i>��ʾ���ݵ�ʵ��ֵ��--%>
						<%--<i>y'<sub>i</sub></i>��ʾ���ݵ�Ԥ��ֵ��--%>
					 	<%--<i>y<sub>ave</sub></i>��ʾ�۲�����<i>y<sub>i</sub></i>�ľ�ֵ��)--%>
					<%--</div>--%>
				<%--</div> --%>
				<%--<div id="resultD_con6" style="display:none;text-align:center;">--%>
					<%--<%	if(data_test.length==0)--%>
						<%--{%>--%>
							<%--<div class="subtitle">�޲��Լ����ݣ�</div>--%>
					<%--<%	}--%>
						<%--else--%>
						<%--{					--%>
							<%--filename = rechart.generateLineChart(index.getRE(),data_train.length,--%>
																<%--session,new PrintWriter(out));--%>
		     				<%--graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;--%>
		     		<%--%>--%>
							<%--<img src="<%= graphURL %>">--%>
					<%--<%	}%>--%>
				<%--</div>--%>
				<%--<div id="resultD_con7" style="display:none;text-align:center;">--%>
			    <%--<% 	filename = threestepchart.generateLineChart(data_train,data_test,outdata,fitness,model,--%>
			    											<%--colname,session,new PrintWriter(out));--%>
     				<%--graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;%>--%>
					<%--<img src="<%= graphURL %>">--%>
				<%--</div>--%>
			</div>
	<%	}%>
	</body>
</html>