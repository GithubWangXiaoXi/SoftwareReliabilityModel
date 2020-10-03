<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="system.*" %>
<!-- javabean:inputdata ��ǰʹ������ | parameterinfo Ĭ�ϲ�����Ϣ -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<%
	String step = parameterinfo.getstep();
	String[] parameter = parameterinfo.getparameter("WEIBULL");
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
    	<title>Weibullģ��</title>
    	<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/classic/validate_WEIBULL.js" 
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
		
		
		<div class="titlename">WEIBULLģ��</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="WEIBULL_tab1" onClick="setTab('WEIBULL',1,4)" class="hover">ģ�ͼ��</li> 
					<li id="WEIBULL_tab2" onClick="setTab('WEIBULL',2,4)" >ʧЧ����</li> 
					<li id="WEIBULL_tab3" onClick="setTab('WEIBULL',3,4)">Ԥ�����</li> 
					<li id="WEIBULL_tab4" onClick="setTab('WEIBULL',4,4)"
					style="display:none">�������</li> 
				</ul> 
			</div>
			<div class="main_tab_content"> 
				<div id="WEIBULL_con1">
					<div class="subtitle">ģ�ͼ��</div>
					<div class="scrollbox">
						<p>
							���� ǿ�Ⱥ�����NHPP���̣�������β��ɹ��̣����������Է������޸�ϵͳ��ʧЧģʽ��
							�Լ�����Ȼ���Ƶķ���Ϊ�������Ƶ�����Weibull�����ڿɿ������������е�Ӧ�á�
						</p>
						<p>
							������������Weibull�ֲ������ǣ�
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Classic/Weibull_1.jpg"></p>
						<p>
							���У� <i>��</i>��<i>��</i>�ֱ���ģ�͵ĳ߶Ȳ�������״������
						</p>
						<p>
							����С�����˳�����У�<img src="../../IMAGE/Classic/Weibull_2.jpg">
							�����ﲻ����<i>x</i><sub>1</sub>=<i>x</i><sub>1</sub>=...
							<i>x</i><sub>n</sub>���������Ȼ�����ǣ�
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Classic/Weibull_3.jpg"></p>
						<p>
							����Ȼ��������ʽ����ȡ���������ҷֱ���������� ��������������ɵã�
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Classic/Weibull_4.jpg"></p>
						<p>
							��ȡ<img src="../../IMAGE/Classic/Weibull_5.jpg">
							��Ȼ�������ʽ�����õ������������<i>��</i>���ٽ�<i>��</i>������ʽ���������<i>��</i>��
						</p>
					</div>
				</div>
				<div id="WEIBULL_con2" style="display:none">
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
				<div id="WEIBULL_con3" style="display:none">
					<div class="subtitle">��������</div>
					<div class="setup">
						<form action="../../resultshow/resultClassic.jsp" method="post"
							target="SHOWDATA_WEIBULL" name="parameterform" 
							onsubmit="return validate_WEIBULL(this,1);">
							<div class="parametersetup_title">ʧЧ���ݣ�</div>
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
								<input type="hidden" id="model" name="model" value="WEIBULL">
								<input type="hidden" id="flag" value="0">
								<input type="hidden" id="current_tab" value="3">
								
								<!-- <input type="button" class="button button-pill button-primary" 
								onClick="saveparameter();" value="����"> -->
								<input type="submit" class="button button-pill button-primary"  value="Ԥ��">
							</div>	
  						</form>
					</div> 
				</div>
				<div id="WEIBULL_con4" style="display:none">
					<iframe name="SHOWDATA_WEIBULL" src="../../resultshow/resultClassic.jsp"></iframe>
				</div> 
			</div> 
		</div>	
	</body>
</html>