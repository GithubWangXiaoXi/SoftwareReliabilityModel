<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<!-- javabean:inputdata ��ǰʹ������ | parameterinfo Ĭ�ϲ�����Ϣ -->
<%@ page import="system.*" %>
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<%
	String step = parameterinfo.getstep();
	String[] parameter = parameterinfo.getparameter("GEP");
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
    	<title>GEPģ��</title>
   		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/datadriven/validate_GEP.js" 
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
		<div class="titlename">GEPģ��</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="GEP_tab1" onClick="setTab('GEP',1,4)" class="hover">ģ�ͼ��</li> 
					<li id="GEP_tab2" onClick="setTab('GEP',2,4)" >ʧЧ����</li> 
					<li id="GEP_tab3" onClick="setTab('GEP',3,4)">Ԥ�����</li> 
					<li id="GEP_tab4" onClick="setTab('GEP',4,4)" style="display:none">�������</li> 
				</ul> 
			</div> 
			<div class="main_tab_content"> 
				<div id="GEP_con1">
					<div class="subtitle">ģ�ͼ��</div>
					<div class="scrollbox">
						<p>
							������ʽ��̣�Gene Expression Programming , GEP��
							�㷨��һ�ֻ��ڻ�������ͱ����������������Ӧ�ݻ��㷨��
							�����Ŵ��㷨(GA)���Ŵ��������(GP)���ϵĲ��
							�����Ŵ��㷨���Ŵ�������Ƶ��ŵ���һ�壬
							�Ѹ����������ڽ����Ŵ������Ĺ̶����Դ���
							Ȼ������ɳ��Ⱥ���״��ͬ�ı��ʽ����<i>K</i>-���ʽ����ʽ��
						</p>
						<p>
							������ʽ����㷨�е�ÿ��Ⱦɫ����������һ���⣬
							����Ⱦɫ�Ļ������ս���ͷ��ս�����ɡ�
							���ʽ����ETs����Ⱦɫ��ı����ͣ���һ�������Ե����α����ʽ��
							ÿ��������Ϊһ�������ڱ��ʽ���ִ��ڡ�
							��GEP�У�������ͷ����β�����ɡ�
							ͷ���ɺ�����<i>F</i>(�磬+,-,*,/+,sin, ��)���ս��<i>T</i>
							���磬��������롢�������������޲εĺ��������ɣ�β��ֻ�����ս�����ɣ�
							GEP�㷨�и���Ĺ��ɿ���������һ����Ԫ�鹹�ɣ�
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/GEP_1.jpg"></p>
						<p>
							����ͷ���ĳ��ȣ�<i>h</i>������ʹ��������ȷ����
							����֮��ʹ�ù����н��е�����
							��ͷ���ĳ���ȷ��֮��β���ĳ��ȣ�<i>t</i>���ɱ�ʾΪ��<i>t</i>=
							<i>h</i>(<i>n</i>-1)+1��
							����<i>n</i>Ϊ���������к���������������������
							������һ�����ż����£� 
							S<sup>*</sup>={<i>S,*,/,+,-,a,b</i>}��
							����SΪsqrt���㣬
							��<i>n</i>=2��
							����<i>h</i>=7��
							��<i>t</i>=8��
							�Ǹ������ܵĳ�����Ϊ7+8=15��
							������������������G1=S*+a+*+aaabbbab��
							G2=*a+*/bSabaaabba����c��+����Ϊ���ӷ���
							�����ı��ʽ�����£�
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/GEP_2.jpg"></p>
						<p>
							GEP��GA��GP���㷨������
							���ݸ������⣬
							����Ҫ�����ս�㼯<i>T</i>�ͳ�ʼ������<i>F</i>��
							Ȼ��ȷ����Ӧ�����۷���
							�����������п�������
							�����Ҫȷ����ֹ���еı�׼��
							����������Ⱦɫ�屻���ɱ��ʽ����
							ͨ��һϵ���Ŵ����������µĸ��壬
							���Ŵ���������Ӧ��ֵ�ﵽԤ��ֵ����ֹ�������̡�
							�ڻ�����ʽ��������У�
							Ⱦɫ��ͨ���ɶ���ȳ��Ļ��򹹳ɣ�
							�һ�������ͻ���ͷ���ĳ��ȶ���Ԥ��ѡ���ġ�
							ÿһ�����򱻱���һ���ӱ��ʽ����
							�ӱ��ʽ�����໥���ù��ɸ����ӵĶ��������ʽ����
							����һЩ���ӵ�����Ϳ��Ա���ʾ�����ˡ�
							������ʽ��������е��Ŵ�������Ҫ����ѡ�񡢱��졢�任�����������
							�任����ʵ���Ͼ��Ǳ��������
							������������Կ����ǽ��������
							��������ͼ���£�
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/GEP_3.jpg"></p>
						<p>
							������ʽ����㷨����������Ŵ��Ļ�������ɶ�����ģ�
							�ۺ���GA��GP���ߵ��ŵ㣬
							�����������ڽ����Ŵ������Ĺ̶����Դ���
							Ȼ������ɳ��Ⱥ���״��ͬ�ı������ʽ��
							���Ŵ�������������ǰ���������߱��Ĳ崮���Ӻͻ����������ӡ�
							�ڻ�����ʽ��������У�
							�ս�㼯�ͺ�������Ԫ�ص�ѡȡ���Ŵ��������û��̫�������
							��������Ĺ��ɷ�Ϊͷ����β�������֣�
							ͷ��Ԫ�ؼȿ������ս�㼯�е�Ԫ�أ�
							Ҳ�����Ǻ������е�Ԫ�أ�
							��β��Ԫ��ֻ���������ս�㼯�е�Ԫ�ء�
							GEP�ܴ󲿷��Ǳ����ں������֣�
							������ѧ�߽�������������ɿ��������в�ȡ���˲����Ч����
						</p>
					</div>
				</div>
				<div id="GEP_con2" style="display:none">
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
				<div id="GEP_con3" style="display:none">
					<div class="subtitle">��������</div>
					<div class="setup" style="height:85%;overflow:auto;">
						<form action="../../resultshow/resultDriven.jsp" method="post"
								target="SHOWDATA_GEP" name="parameterform" 
							onsubmit="return validate_GEP(this,1);">
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
							<div class="parametersetup_title">��Ⱥ��С��</div>
							<div class="parametersetup_content">
								<input type="text" name="GEP_parameter1" 
								value="<%= parameter[0]%>">
									(���÷�Χ��30-100�� ������Ⱥ�а���Ⱦɫ��ĸ��� )
							</div>
							<div class="parametersetup_title">�ع�ά����</div>
							<div class="parametersetup_content">
								<input type="text" name="GEP_parameter2" 
								value="<%= parameter[1]%>">
									(���÷�Χ��3-10�� ������ռ��ع���ά��)
							</div>
							<div class="parametersetup_title">����ͷ�����ȣ�</div>
							<div class="parametersetup_content">
								<input type="text" name="GEP_parameter3" 
								value="<%= parameter[2]%>">
								(���÷�Χ��5-15�� ���û���ͷ���ĳ���h��������ܳ���Ϊ2*h+1)
							</div>
							<div class="parametersetup_title">����������</div>
							<div class="parametersetup_content">
								<input type="text" name="GEP_parameter4" 
								value="<%= parameter[3]%>">
								(���÷�Χ��2-10�� ����һ��Ⱦɫ���ذ�������ĸ���)
							</div>
							<div class="parametersetup_title">���������ʣ�</div>
							<div class="parametersetup_content">
								<input type="text" name="GEP_parameter5" 
								value="<%= parameter[4]%>">
									(���÷�Χ��0-1�� ����ÿ���л���������ĸ���)
							</div>
							<div class="parametersetup_title">ISǨ�Ƹ��ʣ�</div>
							<div class="parametersetup_content">
								<input type="text" name="GEP_parameter6" 
								value="<%= parameter[5]%>">
									(���÷�Χ��0-1�� ����ÿ����Ⱦɫ�巢��ISǨ�Ƶĸ���)
							</div>
							<div class="parametersetup_title">RISǨ�Ƹ��ʣ�</div>
							<div class="parametersetup_content">
								<input type="text" name="GEP_parameter7" 
								value="<%= parameter[6]%>">
								(���÷�Χ��0-1�� ����ÿ����Ⱦɫ�巢��RISǨ�Ƶĸ���)
							</div>
							<div class="parametersetup_title">����������ʣ�</div>
							<div class="parametersetup_content">
								<input type="text" name="GEP_parameter8" 
								value="<%= parameter[7]%>">
									(���÷�Χ��0-1�� ����ÿ����Ⱦɫ�巢����������ĸ���)
							</div>
							<div class="parametersetup_title">˫��������ʣ�</div>
							<div class="parametersetup_content">
								<input type="text" name="GEP_parameter9" 
								value="<%= parameter[8]%>">
									(���÷�Χ��0-1�� ����ÿ����Ⱦɫ�巢��˫������ĸ���)
							</div>
							<div class="parametersetup_title">����������ʣ�</div>
							<div class="parametersetup_content">
								<input type="text" name="GEP_parameter10" 
								value="<%= parameter[9]%>">
									(���÷�Χ��0-1�� ����ÿ����Ⱦɫ�巢����������ĸ���)
							</div>
							<div class="parametersetup_title">ѵ��������</div>
							<div class="parametersetup_content">
								<input type="text" name="GEP_parameter11" 
								value="<%= parameter[10]%>">
								(���÷�Χ��10-100000�� ��ѵ����ָ����������ֹѵ��)
							</div>
							<div class="parametersetup_title">��ֵ��</div>
							<div class="parametersetup_content">
								<input type="text" name="GEP_parameter12" 
								value="<%= parameter[11]%>">
									(���÷�Χ��0-100�� ����ֵС��ָ��ֵ����ֹѵ��)
							</div>
							<div style="text-align:center">
								<input type="hidden" id="model" name="model" value="GEP">
								<input type="hidden" id="flag" value="0">
								<input type="hidden" id="current_tab" value="3">
								<input type="button" class="button button-pill button-primary" 
									onClick="saveparameter();" value="����">
							<input type="submit" class="button button-pill button-primary" value="Ԥ��">
							</div>	
  						</form>
  					</div>
				</div> 
				<div id="GEP_con4" style="display:none">
					<iframe name="SHOWDATA_GEP" src="../../resultshow/resultDriven.jsp"></iframe>
				</div> 
			</div> 
		</div>
	</body>
</html>