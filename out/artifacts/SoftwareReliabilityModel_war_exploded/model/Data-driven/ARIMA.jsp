<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="system.*" %>
<!-- javabean:inputdata ��ǰʹ������ | parameterinfo Ĭ�ϲ�����Ϣ -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<%
	String step = parameterinfo.getstep();
	String[] parameter = parameterinfo.getparameter("ARIMA");
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
    	<title>ARIMAģ��</title>
   		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">	
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/datadriven/validate_ARIMA.js" 
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
		<div class="titlename">ARIMAģ��</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="ARIMA_tab1" onClick="setTab('ARIMA',1,4)" class="hover">ģ�ͼ��</li> 
					<li id="ARIMA_tab2" onClick="setTab('ARIMA',2,4)" >ʧЧ����</li> 
					<li id="ARIMA_tab3" onClick="setTab('ARIMA',3,4)">Ԥ�����</li> 
					<li id="ARIMA_tab4" onClick="setTab('ARIMA',4,4)" style="display:none">�������</li> 
				</ul> 
			</div> 
			<div class="main_tab_content">
				<div id="ARIMA_con1">
					<div class="subtitle">ģ�ͼ��</div>
					<div class="scrollbox">
						<p>
							ARIMAģ��ȫ��Ϊ�����Իع��ƶ�ƽ��ģ�ͣ�Autoregressive Integrated Moving Aver- age Model��
							����Box��Jenkins ��20����70����������ʱ������Ԥ�ⷽ����
							�ֳ�֮ΪB-Jģ�͡�
							����Իع黬��ƽ��ģ�ͣ�ARIMA���Ƿǳ����е�����ʱ������Ԥ��ģ��֮һ��
							��ARIMAģ���У�
							����ʱ�����еĽ���ֵ�ǹ�ȥ�Ĺ۲�ֵ���漴�������Ժ�����
							һ����ɢ���漴����ʱ������<i>Y<sub>t</sub></i>��<i>t</i>=1��2��...��<i>k</i>��
							��ôARIMA(<i>p, d, q</i>) ģ�͵�һ����ʽ���£�
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/ARIMA_1.jpg"></p>
						<p>
							����<i>X<sub>t</sub></i>ԭʼʱ������<i>Y<sub>t</sub></i>ͨ�����ɴεĲ�ֵõ���ƽ�����У�
							��ÿһ�β�ֶ��ᵼ��ԭ������Ϣ�Ĳ�����ʧ�����Ҫע���ֵĴ�����
							���磬
							���õ�һ�ײ�ֹ�ʽΪ��
							<i>X<sub>t-1</sub></i>=<i>Y<sub>t</sub></i>-<i>Y<sub>t-1</sub></i>��
							�Ǹ�����<i>p</i>Ϊ�Իع������
							<i>��<sub>i</sub></i>����<i>i</i>=1��2��...��<i>p</i>��Ϊ�Իع�ϵ����
							�Ǹ�����<i>q</i>Ϊ�ƶ�ƽ��������
							<i>��<sub>i</sub></i>��
							��<i>i</i>=1��2��...��
							<i>q</i>��Ϊ�ƶ�ƽ��ϵ����
							{<i>��<sub>t</sub></i>}����ͬ�ֲ��ھ�ֵΪ0��
							����Ϊ<i>��<sup>2</sup></i>�İ��������̡�
							ARIMAģ�Ϳɷ�Ϊ�������֣�
						</p>
						<p>1���� q=0,��ģ��ΪAR(p)����</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/ARIMA_2.jpg"></p>
						<p>2����p=0,��ģ��ΪMA(q)����</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/ARIMA_3.jpg"></p>
						<p>3����d=0,��ģ��ΪARMA(p, q)����</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/ARIMA_4.jpg"></p>
						<p>
							ARIMAģ�͵Ľ�ģ���̰�����ƽ���Լ��顢ģ��ʶ�𡢲�������/���׺Ͳ���/ģ�ͼ����ĸ����衣��������ͼ���£�
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/ARIMA_5.jpg"></p>
						<p>
							ARIMA�Ļ���˼���ǽ���������������ۻ����ϣ���������֮�������������ģ�ͣ����нṹ�򵥡�
							��ģ�ٶȿ졢Ԥ�⾫�ȸߵ��ŵ㣬���ҽ���˷�ƽ��ʱ�����еĴ������⣬�ǳ��ʺϴ�������ԺͲ����Խ�ǿ�����⡣
							ģ�͵ľ�����ʽ�ɷ�Ϊ�Իع飨AR��ģ�͡�����ƽ����MA��ģ�ͺ��Իع黬��ƽ����ARMA��ģ�ͣ�
							������������ʽ����ͨ������غ�����ƫ��غ������ж�����ȻARIMAģ���ڴ����ݺ����Ե��������нϸߵ�Ԥ�⾫�ȣ�
							���ڴ���С�ġ������Ե������е�³���Խϲ
						</p>
					</div>
				</div>
				<div id="ARIMA_con2" style="display:none">
					<%-- <div class="subtitle">���ݻ�����Ϣ</div>
					<div class="currentdata">
						�������ƣ�<%= inputdata.getdataname()%><br><br>
  	 					����������<%= inputdata.getlength_train()+inputdata.getlength_test()%><br><br>
  	 					ѵ�����ݣ�<%= inputdata.getlength_train()%><br><br>
  	 					�������ݣ�<%= inputdata.getlength_test()%><br><br>
						����ά���� <%= inputdata.getdimension()%><br><br>
  	 					����������<%= inputdata.getdatainfo()%>
					</div> --%>
					<iframe src="../../resultshow/showhistorydata2.jsp"></iframe>
				</div>
				<div id="ARIMA_con3" style="display:none">
					<div class="subtitle">��������</div>
					<div class="setup">
						<form action="../../resultshow/resultDriven.jsp" method="post"
							target="SHOWDATA_ARIMA" name="parameterform" 
							onsubmit="return validate_ARIMA(this,1);">
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
								<input type="text" name="prestep" value="<%= step%>">
								(���÷�Χ��1-100�� ����ģ�����Ԥ��Ĳ���)
							</div>
							<div class="parametersetup_title">����֮һ��</div>
							<div class="parametersetup_content">
								<input type="text" name="ARIMA_parameter1" 
									value="<%= parameter[0]%>">
									(���÷�Χ��0-1�� )
							</div>
							<div class="parametersetup_title">����֮����</div>
							<div class="parametersetup_content">
								<input type="text" name="ARIMA_parameter2" 
								value="<%= parameter[1]%>">
								(���÷�Χ��0-1�� )
							</div>
							<div class="parametersetup_title">����֮����</div>
							<div class="parametersetup_content">
								<input type="text" name="ARIMA_parameter3" 
								value="<%= parameter[2]%>">
								(���÷�Χ��0-1�� )
							</div>
							<div class="parametersetup_title">����֮�ģ�</div>
							<div class="parametersetup_content">
								<input type="text" name="ARIMA_parameter4" 
								value="<%= parameter[3]%>">
								(���÷�Χ��0-1�� )
							</div>
							<div style="text-align:center">
								<input type="hidden" id="model" name="model" value="ARIMA">
								<input type="hidden" id="flag" value="0">
								<input type="hidden" id="current_tab" value="3">
								<input type="button" class="button button-pill button-primary" 
									onClick="saveparameter();" value="����">
								<input type="submit" class="button button-pill button-primary" value="Ԥ��">
							</div>	
  						</form>
					</div>
				</div>
				<div id="ARIMA_con4" style="display:none">
					<iframe name="SHOWDATA_ARIMA" src="../../resultshow/resultDriven.jsp"></iframe>
				</div> 
			</div> 
		</div>
	</body>
</html>

