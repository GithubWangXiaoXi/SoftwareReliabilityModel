<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="system.*" %>
<!-- javabean:inputdata ��ǰʹ������ | parameterinfo Ĭ�ϲ�����Ϣ -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<%
	String step = parameterinfo.getstep();
	String[] parameter = parameterinfo.getparameter("LogNormalSRM");
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
    	<title>LogNormalSRMģ��</title>
    	<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/classic/validate_LogNormalSRM.js" 
  		charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/saveparameter.js" charset="gb2312"></script>
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
		<iframe style="display:none" name="MODIFYPARAMETER" 
		src="../../main/modifyparameter.jsp"></iframe>
		
		
		<div class="titlename">LogNormalSRMģ��</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="LogNormalSRM_tab1" onClick="setTab('LogNormalSRM',1,4)" class="hover">ģ�ͼ��</li> 
					<li id="LogNormalSRM_tab2" onClick="setTab('LogNormalSRM',2,4)" >ʧЧ����</li> 
					<li id="LogNormalSRM_tab3" onClick="setTab('LogNormalSRM',3,4)">Ԥ�����</li> 
					<li id="LogNormalSRM_tab4" onClick="setTab('LogNormalSRM',4,4)" style="display:none">�������</li> 
				</ul> 
			</div>
			<div class="main_tab_content"> 
				<div id="LogNormalSRM_con1">
					<div class="subtitle">ģ�ͼ��</div>
					<div class="scrollbox">
						<p>������̬�ֲ���logarithmic normal distribution����ָһ����������Ķ���������̬�ֲ����������������Ӷ�����̬�ֲ���
						������̬�ֲ��Ӷ�������������̬�ֲ��ǳ��ӽ���������������������̬�ֲ����Ϸֲ�����ֵ����һЩ��</p>
						
						<p>
							������̬�ֲ�����ĳЩ����Ļ�е����Ŀɿ��Է�����ƣ������������Ҫ��;����ά���Է����ж�����ʱ�����ݽ���ȷ�еķ�����
  							��֪������̬�ֲ����ܶȺ������Ϳ��Ը��ݿɿ����벻�ɿ��Ⱥ����Ķ��������÷ֲ��Ŀɿ��Ⱥ����Ͳ��ɿ��Ⱥ����ı���ʽ��
						</p>
						<p>������ܶȺ���Ϊ��</p>
						<p style="text-align:center;"><img src="../../IMAGE/Classic/LogNormal1.jpg"></p>

						
					</div>
				</div>
				<div id="LogNormalSRM_con2" style="display:none">
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
				<div id="LogNormalSRM_con3" style="display:none">
					<div class="subtitle">��������</div>
					<div class="setup">
						<form action="../../resultshow/resultClassic.jsp" method="post"
							target="SHOWDATA_LogNormalSRM" name="parameterform" 
							onsubmit="return validate_LogNormalSRM(this,1);">
							<div class="parametersetup_title">�������У�</div>
							<div class="parametersetup_content">
								<select name="Sequence" style="height:30px;width:200px;font-size:18px">
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
								<input type="text" name="prestep" 
								value="<%= step%>" style="height:30px;width:200px;font-size:18px">
								(���÷�Χ��0-100�� ����ģ�����Ԥ��Ĳ���)
							</div>
							<div style="text-align:center">
								<input type="hidden" id="model" name="model" value="LogNormalSRM">
								<input type="hidden" id="flag" value="0">
								<input type="hidden" id="current_tab" value="3">
								
								<!-- <input type="button" class="button button-pill button-primary" 
								onClick="saveparameter();" value="����"> -->
							   <input type="submit" class="button button-pill button-primary" value="Ԥ��">
							</div>	
  						</form>
					</div>
				</div>
				<div id="LogNormalSRM_con4" style="display:none">
					<iframe name="SHOWDATA_LogNormalSRM" src="../../resultshow/resultClassic.jsp"></iframe>
				</div> 
			</div> 
		</div>	
	</body>
</html>