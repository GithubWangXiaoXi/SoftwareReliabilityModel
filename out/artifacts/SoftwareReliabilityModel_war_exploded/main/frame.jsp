<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%@page import="system.DataSet"%>
<%@ page contentType="text/html;charset= gb2312"%>
<!-- javabean:inputdata ��ǰʹ������|predata ��ѡ���ݼ�|contrastdata �Ա����ݼ�-->

<jsp:useBean id="inputdata" class="system.InputData" scope="session"></jsp:useBean>
<jsp:useBean id="contrastdata" class="system.ContrastData" scope="session"></jsp:useBean>
<jsp:useBean id="historydata" class="system.HistoryData" scope="session"></jsp:useBean>

<%	//���ó�ʼ������
 	double[][] x = {
	 				{5.7683,9.5743,9.105,7.9655,8.6482,9.9887,10.1962,11.6399,11.6275,6.4922,
					7.901,10.2679,7.6839,8.8905,9.2933,8.3499,9.0431,9.6027,9.3736,8.5896,
					8.7877,8.7794,8.0469,10.8459,8.7416,7.5443,8.5941,11.0399,10.1196,10.1786,
					5.8944,9.546,9.6197,10.3852,10.6301,8.3333,11.315,9.4871,8.1391,8.6713,
					6.4615,6.6415,7.6955,4.7005,10.0024,11.0129,10.8621,9.4371,6.6644,9.2294,
					8.9671,10.3534,10.0998,12.6078,7.1546,10.0033,9.8601,7.8675,10.5757,10.9294,
					10.6604,12.4972,11.3745,11.9158,9.575,10.4504,10.5866,12.7201,12.5982,12.0859,
					12.2766,11.9602,12.0246,9.2873,12.495,14.5569,13.3279,8.9464,14.7824,14.8969,
					12.1399,9.7981,12.0907,13.0977,13.368,12.7206,14.192,11.3704,12.2021,12.2793,
					11.3667,11.3923,14.4113,8.3333,8.0709,12.2021,12.7831,13.1585,12.753,10.3533,
					12.4897},
 					
	 				{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,
	 					21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,
	 					41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,
	 					61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,
	 					81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,
	 					101},
	 					
	 					{2,4,6,8,10,12,14,16,18,20,
	 					18,16,14,12,10,8,6,4,2,0,
	 					2,4,6,8,10,12,14,16,18,20,
	 					18,16,14,12,10,8,6,4,2,0,
	 					2,4,6,8,10,12,14,16,18,20,
	 					18,16,14,12,10,8,6,4,2,0,
	 					2,4,6,8,10,12,14,16,18,20,
	 					18,16,14,12,10,8,6,4,2,0,
	 					2,4,6,8,10,12,14,16,18,20,
	 					18,16,14,12,10,8,6,4,2,0,
	 					2}
 					};
	String x_dataname = "Musa���ݼ�";  	//��ʼ��һ�����ݵ�����
	String[] colname={"ʧЧ�������","����1","����2"};
	String x_datainfo = "��ʼĬ������";	//��ʼ��һ�����ݵ�����
	/*****************************************************************************/
	
	contrastdata.init();	//���Ա����ݼ����ʻ�����գ�
	historydata.init();
	historydata.entry(x, x_dataname, colname, x_datainfo);
	int testpercentage = 10;		//���õ�ǰʹ�����ݵĲ��Լ��ٷֱ�
	inputdata.setdata(x,		//����һ����ʼ���ݼ�����Ϊ��ǰʹ������
						x_dataname,	
						colname,
						testpercentage,
						x_datainfo);	
	
	//contrastdata.init();	//���Ա����ݼ����ʻ�����գ�
	//historydata.init();
	// historydata.entry(x, x_dataname, colname, x_datainfo);
	/* ArrayList<DataSet> list=rt.getDataSet(1);
    //String[] cname=new String[]{"col1","col2"};
	for(int i=0;i<list.size();i++){
		DataSet ds=list.get(i);	
		historydata.entry(ds.getData(), ds.getSetname(), ds.getColname(), ds.getSetinfo());
		
	}
	int testpercentage = 10;		//���õ�ǰʹ�����ݵĲ��Լ��ٷֱ�
	/* inputdata.setdata(x,		//����һ����ʼ���ݼ�����Ϊ��ǰʹ������
						x_dataname,	
						colname,
						testpercentage,
						x_datainfo);	 */
	//inputdata.init();
	/*DataSet curds=list.get(list.size()-1);
	inputdata.setdata(curds.getData(),		//�ñ�ѡ���ݼ��е�ָ�������滻����ǰ����
						 			curds.getSetname(),
						 			curds.getColname(),
						  			curds.getPercent(),
									curds.getSetinfo()); */
%>

<html >
	<head>
	<title>����ɿ��Է���ƽ̨</title>
	<link rel="stylesheet" type="text/css" href="../CSS/universal.css">
 	<link rel="stylesheet" type="text/css" href="../CSS/frame.css">
 	<script type="text/javascript" src="../JS/jquery1.8.3.min.js"></script>
	</head>
	
	<body style="overflow:auto;">
		<div id="mainframe">		<!-- ����ܹ�����һ����Ϊ������ -->
   			<div class="top">		<!-- ����(top) -->
        		<img src="../IMAGE/top.png" height=100% width=100%;>
   			</div>
   			<div class="menu">		<!-- �˵�(menu) -->
   				<iframe src="menu.jsp"></iframe>
   			</div>
        	<div class="main">		<!-- ������(main) -->
   				<iframe name="MAIN"></iframe>
   			</div>
		</div>
	</body>
</html>