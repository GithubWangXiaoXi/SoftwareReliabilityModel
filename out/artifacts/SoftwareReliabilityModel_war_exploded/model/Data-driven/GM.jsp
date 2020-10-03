<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="system.*" %>
<!-- javabean:inputdata ��ǰʹ������ | parameterinfo Ĭ�ϲ�����Ϣ -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<%
	String step = parameterinfo.getstep();
	String[] parameter = parameterinfo.getparameter("GM");
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
    	<title>GMģ��</title>
   		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/datadriven/validate_GM.js" 
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
		<div class="titlename">GMģ��</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="GM_tab1" onClick="setTab('GM',1,4)" class="hover">ģ�ͼ��</li> 
					<li id="GM_tab2" onClick="setTab('GM',2,4)" >ʧЧ����</li> 
					<li id="GM_tab3" onClick="setTab('GM',3,4)">Ԥ�����</li> 
					<li id="GM_tab4" onClick="setTab('GM',4,4)" style="display:none">�������</li> 
				</ul> 
			</div> 
			<div class="main_tab_content"> 
				<div id="GM_con1">
					<div class="subtitle">ģ�ͼ��</div>
					<div class="scrollbox">
						<p>
							��ɫϵͳģ��(Gery Model,
							GM)�����ý��ٵĻ�ȷ�еı�ʾ��ɫϵͳ��Ϊ������ԭʼ�������������ɱ任�����ģ�
							����������ɫϵͳ�ڲ����������仯���̵�ģ�͡�
							��ɫģ��ͨ���ۼӲ���(AGO)�ķ�����
							���޹����ԭʼ���ݽ��д�����
							�Ӷ�����ԭʼ���ݵ�����ԺͲ����ԣ�
							�����й����׼ָ�����ɵ����ݣ�
							Ȼ�����Щ���ɵ����ݽ��н�ģ��Ԥ�⡣
							���õĻ�ɫԤ��ģ����Ҫ�Ǿ����һ��GM(1,1)ģ�͡�
						</p>
						<p>GM(1,1)ģ����һ����������һ��΢�ַ��̹��ɣ�</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/GM_1.jpg"></p>
						<p>
							ʽ��<i>a</i>��<i>b</i>Ϊ�����Ĳ�����
							<i>X<sub>1</sub></i>Ϊԭʼ��������<i>X<sub>0</sub></i>���ۼ�����ֵ��
							��ʽҲ����Ϊʱ����Ӧ��������<i>X<sub>0</sub></i>Ϊԭʼ���ݵ�<i>n</i>Ԫ���У�
							��
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/GM_2.jpg"></p>
						<p>��һ���ۼӺ�õ�һ���ۼ����У�</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/GM_3.jpg"></p>
						<p>��<i>Z</i><sub>1</sub>Ϊ<i>X</i><sub>1</sub>�Ľ��ھ�ֵ��������Ϊ��</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/GM_4.jpg"></p>
						<p>�������������Եõ�ʱ����Ӧ�����Ľ�Ϊ��</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/GM_4.jpg"></p>
						<p>����ʽ�ɵõ�GM(1,1)ģ�͵�Ԥ��ֵ��</p>
					</div>
				</div>
				<div id="GM_con2" style="display:none">
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
				<div id="GM_con3" style="display:none">
					<div class="subtitle">��������</div>
					<div class="setup">
						<form action="../../resultshow/resultDriven.jsp" method="post"
							target="SHOWDATA_GM" name="parameterform" 
							onsubmit="return validate_GM(this,1);">
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
								<input type="text" name="prestep" 
									value="<%= step%>">
								(���÷�Χ��0-100�� ����ģ�����Ԥ��Ĳ���)
							</div>
							<div class="parametersetup_title">ָ��������</div>
							<div class="parametersetup_content">
								<select name="GM_parameter1">
									<option value="1"
									<% if(parameter[0].equals("1")) {%> selected <%}%>>1
									</option>
									<option value="2"
									<% if(parameter[0].equals("2")) {%> selected <%}%>>2
									</option>
								</select>
								(����΢�ַ��̵Ľ�������ȷ����ͬ�Ļ�ɫģ�ͷ���)
							</div>	
							<div style="text-align:center">
								<input type="hidden" id="model" name="model" value="GM">
								<input type="hidden" id="flag" value="0">
								<input type="hidden" id="current_tab" value="3">
								<input type="button" class="button button-pill button-primary" 
								onClick="saveparameter();" value="����">
								<input type="submit" class="button button-pill button-primary" value="Ԥ��">
							</div>	
  						</form>
					</div> 
				</div>
				<div id="GM_con4" style="display:none">
					<iframe name="SHOWDATA_GM" src="../../resultshow/resultDriven.jsp"></iframe>
				</div> 
			</div> 
		</div>
	</body>
</html>