<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="system.*" %>
<!-- javabean:inputdata ��ǰʹ������ | parameterinfo Ĭ�ϲ�����Ϣ -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<%
	String step = parameterinfo.getstep();
	String[] parameter = parameterinfo.getparameter("SCHNEIDEWIND");
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
    	<title>Schneidewindģ��</title>
    	<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/classic/validate_SCHNEIDEWIND.js" 
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
		
		
		<div class="titlename">SCHNEIDEWINDģ��</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="SCHNEIDEWIND_tab1" onClick="setTab('SCHNEIDEWIND',1,4)" class="hover">ģ�ͼ��</li> 
					<li id="SCHNEIDEWIND_tab2" onClick="setTab('SCHNEIDEWIND',2,4)" >ʧЧ����</li> 
					<li id="SCHNEIDEWIND_tab3" onClick="setTab('SCHNEIDEWIND',3,4)">Ԥ�����</li> 
					<li id="SCHNEIDEWIND_tab4" onClick="setTab('SCHNEIDEWIND',4,4)" style="display:none">�������</li> 
				</ul> 
			</div>
			<div class="main_tab_content"> 
				<div id="SCHNEIDEWIND_con1">
					<div class="subtitle">ģ�ͼ��</div>
					<div class="scrollbox">
						<p>
							�����<i>��</i>(<i>t</i>)ֵ��ʱ��ȱ�����ױ�¶�����
							<img src="../../IMAGE/Classic/Schneidewind_1.jpg"><i>��</i>(<i>t</i>)
							Ӧ�ø��Ķ�һЩ��
							��ˣ���ʱ�䲻�Ƿǳ����ʱ�������У�Schneidewind����
							 <img src="../../IMAGE/Classic/Schneidewind_1.jpg"><i>��</i>(<i>t</i>)
							 =-<i>�¦�</i>(<i>t</i>)�����Ϊ<i>��</i>(<i>t</i>)=
							 <i>��</i>e<sup>-<i>��t</i></sup>����Schneidewindģ���У�
							 ��ʱ�������<i>t</i>=0���Ϊ�ȳ��ļ������i�����ڵ�<i>��<sub>t</sub></i>)= ��
							 -<i>�¦�</i>(<i>t</i>)�������ڵ�<i>k</i>��������
						</p>
							 <p style="text-align:center;"><img src="../../IMAGE/Classic/Schneidewind_2.jpg">
						</p>
						<p>
							���ǣ����Եõ���Ȼ������
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Classic/Schneidewind_3.jpg">
						<p>
							<i>��</i>��<i>��</i>�������Ȼ��������
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Classic/Schneidewind_4.jpg">
						<p>
							��󣬿��������
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Classic/Schneidewind_5.jpg">
					</div>
				</div>
				<div id="SCHNEIDEWIND_con2" style="display:none">
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
				<div id="SCHNEIDEWIND_con3" style="display:none">
					<div class="subtitle">��������</div>
					<div class="setup">
						<form action="../../resultshow/resultClassic.jsp" method="post"
							target="SHOWDATA_SCHNEIDEWIND" name="parameterform" 
							onsubmit="return validate_SCHNEIDEWIND(this,1);">
							<div class="parametersetup_title">ʧЧ���ݣ�</div>
							<div class="parametersetup_content">
								<select name="Sequence"style="height:30px;width:200px;font-size:18px">
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
							<div class="parametersetup_title">ģ�;���ex��</div>
							<div class="parametersetup_content">
								<input type="text" name="SCHNEIDEWIND_parameter1" 
								value="<%= parameter[0]%>"style="height:30px;width:200px;font-size:18px">
								(���÷�Χ��0-1�� )
							</div>
							<div class="parametersetup_title">ģ�;���ey��</div>
							<div class="parametersetup_content">
								<input type="text" name="SCHNEIDEWIND_parameter2" 
								value="<%= parameter[1]%>"style="height:30px;width:200px;font-size:18px">
								(���÷�Χ��0-1�� )
							</div>
							<div style="text-align:center">
								<input type="hidden" id="model" name="model" value="SCHNEIDEWIND">
								<input type="hidden" id="flag" value="0">
								<input type="hidden" id="current_tab" value="3">
								
								<input type="button" class="button button-pill button-primary"  
								onClick="saveparameter();" value="����">
								<input type="submit" class="button button-pill button-primary"  value="Ԥ��">
							</div>	
  						</form>
					</div> 
				</div>
				<div id="SCHNEIDEWIND_con4" style="display:none">
					<iframe name="SHOWDATA_SCHNEIDEWIND" src="../../resultshow/resultClassic.jsp"></iframe>
				</div> 
			</div> 
		</div>	
	</body>
</html>