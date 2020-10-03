<%@page import="sun.rmi.server.Dispatcher"%>
<%@page import="java.security.spec.DSAGenParameterSpec"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@page import="system.DataSet"%>
<%@ page contentType="text/html;charset= gb2312"%>
<!-- javabean:inputdata ��ǰʹ������|predata ��ѡ���ݼ�|contrastdata �Ա����ݼ� -->
<jsp:useBean id="rt" class="system.ReadTable" scope="page"></jsp:useBean>
<%-- <jsp:useBean id="dataset" class="system.DataSet" scope="application"></jsp:useBean> 
 --%>
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="historydata" class="system.HistoryData" scope="page"></jsp:useBean>
<jsp:useBean id="contrastdata" class="system.ContrastData" scope="page"></jsp:useBean>

<%
	ArrayList<DataSet> list=rt.getDataSet(1);
    //String[] cname=new String[]{"col1","col2"};
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
	int changeflag = 0;		//����һ�����������־�������жϵ�ǰ����inputdata��û�б����
   	if(request.getParameter("changenumber") != null)	//�����ǰ����
   	{
   		
   		int n = Integer.parseInt(request.getParameter("changenumber")) - 1;	//��¼��ֵ��
   		//System.out.println(n+"------>"+historydata.getdataname(n));
   		rt.updateDefaultSet(historydata.getdataname(n), Integer.parseInt(request.getParameter("showhistorydata_testpercentage")));
   		inputdata.setdata(historydata.getdata(n),		//�ñ�ѡ���ݼ��е�ָ�������滻����ǰ����
   		 			historydata.getdataname(n),
   		 			historydata.getcolname(n),
   		  			Integer.parseInt(request.getParameter("showhistorydata_testpercentage")),
 					historydata.getdatainfo(n));
 		historydata.setcurrent(n+1);
 		contrastdata.init();	//�Ա����ݼ���ʼ������գ�
 		changeflag = 1;			//������ݱ�־����
 		//request.getRequestDispatcher("/main/frame.jsp").forward(request, response);
   	}
   	int dimension = inputdata.getdimension();
   	String[] colname = new String[dimension];
	double[][] data_train = new double[dimension][];	//����ǰ����ѵ��������һ�ݵ�ҳ��
	double[][] data_test = new double[dimension][];		//����ǰ���ݲ��Լ�����һ�ݵ�ҳ��
   	for(int i=0;i<dimension;i++)
   	{
   		colname[i] = inputdata.getcolname(i+1);
   		data_train[i] = inputdata.getdata_train(i+1).clone();
   		data_test[i] = inputdata.getdata_test(i+1).clone();
   	}
%>

<html>
	<head>
    	<title>ʧЧ����</title>
    	<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
  		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
  		<link rel="stylesheet" type="text/css" href="../../CSS/table.css">
  		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css"> 
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/onload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/modifydata.js" charset="gb2312"></script>
	</head>
	
	<body onload="onload_show();">

		<div id="loader_container" style="display:none">
			<div id="loader">
				<div align="center">����ִ�У����Ժ� ...</div>
				<div id="loader_bg">
					<div id="progress"></div>
				</div>
			</div>
		</div>
		<input type="hidden" id="changeflag" value="<%= String.valueOf(changeflag)%>">
		<div class="titlename">ʧЧ����</div>
  		<div id="main_tab"> 		<!-- ����tabҳ�ı��� -->
			<div class="main_tab_menu"> 
				<ul> 
					<li id="show_tab1" onClick="setTab('show',1,4)" class="hover">ʧЧ����</li> 
					<li id="show_tab2" onClick="setTab('show',2,4)" >ѵ������</li> 
					<li id="show_tab3" onClick="setTab('show',3,4)">��������</li>
					<li id="show_tab4" onClick="setTab('show',4,4)">��ʷ����</li>
				</ul> 
			</div> 
			<div class="main_tab_content"> 		<!-- ����tabҳ��ÿҳ�ľ������� -->
				<div id="show_con1">
					<div class="subtitle">ʧЧ������Ϣ</div>
					<div class="currentdata">
						�������ƣ�<%= inputdata.getdataname()%><br><br>
  	 					����������<%= inputdata.getlength_train()+inputdata.getlength_test()%><br><br>
  	 					ѵ�����ݣ�<%= inputdata.getlength_train()%><br><br>
  	 					�������ݣ�<%= inputdata.getlength_test()%><br><br>
						����ά���� <%= inputdata.getdimension()%><br><br>
  	 					����������<%= inputdata.getdatainfo()%>
					</div> 
					<div id="resultC_con9" style="display:none;text-align:center;">
			   
				</div>
				</div> 
				<div id="show_con2" style="display:none;">
					<div class="subtitle">ѵ������</div>
					<div class="scrollbox">
						<table>
  	 						<tr>
  	 							<th>���</th>
  	 						<%	for(int i=0; i<dimension; i++)
  	 							{%>
  	 								<th><%= colname[i]%></th>
  	 						<%	}%>
  	 						</tr>
  	 					 <%	for(int i=0; i<data_train[0].length; i++)
  	 						{%>
  	 							<tr <% if(i%2==0) {%>class="altrow"<%}%>>
  	 								<td><%= i+1%></td>
  	 							<%	for(int j=0; j<dimension; j++)
  	 								{%>
  	 									<td><%= data_train[j][i]%></td>
  	 							<%	}%>
  	 							</tr>
  	 					<%	}%>
  	 					</table>
					</div>
				</div>
				<div id="show_con3" style="display:none;">
					<div class="subtitle">��������</div>
					<div class="scrollbox">
						<table>
  	 						<tr>
  	 							<th>���</th>
  	 						<%	for(int i=0; i<dimension; i++)
  	 							{%>
  	 								<th><%= colname[i]%></th>
  	 						<%	}%>
  	 						</tr>
 						<%	for(int i=0,k=data_train[0].length+1; i<data_test[0].length; i++,k++)
  	 						{%>
  	 							<tr <% if(i%2==0) {%>class="altrow"<%}%>>
  	 								<td><%= k%></td>
  	 							<%	for(int j=0; j<dimension; j++)
  	 								{%>
  	 									<td><%= data_test[j][i]%></td>
  	 							<%	}%>
  	 							</tr>
  	 					<%	}%>
  	 					</table>
					</div>
				</div>
				<div id="show_con4" style="display:none;">
					<iframe name="SHOWDATA_show" src="../../resultshow/showhistorydata.jsp"></iframe>
				</div>
			</div> 
		</div> 
	</body>
</html>
