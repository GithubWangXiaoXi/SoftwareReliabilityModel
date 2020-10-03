<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<!-- javabean:inputdata ��ǰʹ������ | parameterinfo Ĭ�ϲ�����Ϣ -->
<%@ page import="system.*" %>
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<%
	String step = parameterinfo.getstep();
	String[] parameter = parameterinfo.getparameter("RBFN");
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
    	<title>RBFNģ��</title>
   		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/datadriven/validate_RBFN.js" 
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
		<div class="titlename">RBFNģ��</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="RBFN_tab1" onClick="setTab('RBFN',1,4)" class="hover">ģ�ͼ��</li> 
					<li id="RBFN_tab2" onClick="setTab('RBFN',2,4)">ʧЧ����</li> 
					<li id="RBFN_tab3" onClick="setTab('RBFN',3,4)">Ԥ�����</li> 
					<li id="RBFN_tab4" onClick="setTab('RBFN',4,4)" style="display:none">�������</li> 
				</ul> 
			</div> 
			<div class="main_tab_content"> 
				<div id="RBFN_con1">
					<div class="subtitle">ģ�ͼ��</div>
					<div class="scrollbox">
						<p>
							����������磨Radial Basis Function Network�� RBFN���Ļ���˼���ǣ�
							��RBF��Ϊ����Ԫ�ġ���������������ռ䣬
							�����Ϳ��Խ�����ʸ��ֱ�ӣ�������Ҫͨ��Ȩ�ӣ�ӳ�䵽���ռ䡣
							��RBF�����ĵ�ȷ���Ժ� ����ӳ���ϵҲ��ȷ���ˡ�
							��������ռ䵽����ռ��ӳ�������Եģ� ����������������Ԫ��������Լ�Ȩ�͡�
							�˴���Ȩ��Ϊ����ɵ������� �ɴ˿ɼ��� �������Ͽ��� ���������뵽�����ӳ���Ƿ����Եģ�
							����������Կɵ���������ȴ�������Եġ� ���������Ȩ�Ϳ������Է���ֱ�ӽ����
							�Ӷ����ӿ�ѧϰ�ٶȲ�����ֲ���С���⡣	
						</p>
						<p>
							RBF������һ����������磬 �������������֮�����һ�����㡣
							�����е�ת�������Ǿֲ���Ӧ�ĸ�˹������ ������ǰ�������磬 ת������һ�㶼��ȫ����Ӧ������
							���������Ĳ�ͬ�� Ҫʵ��ͬ���Ĺ��ܣ� RBF��Ҫ�������Ԫ��
							�����RBF���粻��ȡ����׼ǰ���������ԭ�� ����RBF��ѵ��ʱ����̡�
							���Ժ����ıƽ������ŵģ� ���������⾫�ȱƽ��������������� �����е���ԪԽ�࣬ �ƽ�Խ��ȷ��
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/RBFN_1.jpg"></p>
						<p>������������г��õľ���������Ǹ�˹������ ��˾����������ļ�����ɱ�ʾΪ:</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/RBFN_2.jpg"></p>
						<p>�����������Ľṹ�ɵõ���������Ϊ:</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/RBFN_3.jpg"></p>
						<p>
							����һ�������ķ����Ժ������þ����������������������⾫��ȫ�ֱƽ�����
							������Ҫ���ǣ� �������������������䷴�򴫲��ķ����߳��ļ��㣬
							ʹѧϰ���Ա�ͨ�����������ܶࡣ	
						</p>
					</div>
				</div>
				<div id="RBFN_con2" style="display:none">
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
				<div id="RBFN_con3" style="display:none">
					<div class="subtitle">��������</div>
					<div class="setup">
						<form action="../../resultshow/resultDriven.jsp" method="post"
							target="SHOWDATA_RBFN" name="parameterform" 
							onsubmit="return validate_RBFN(this,1);">
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
							<div class="parametersetup_title">�ع�ά����</div>
							<div class="parametersetup_content">
								<input type="text" name="RBFN_parameter1" 
								value="<%= parameter[0]%>">
									(���÷�Χ��3-10�� ����������ṹ�����ڵ�ĸ���)
							</div>
							<div class="parametersetup_title">�������ϵ����</div>
							<div class="parametersetup_content">
								<input type="text" name="RBFN_parameter2" 
								value="<%= parameter[1]%>">
								(���÷�Χ��0-1�����ƾ���������и����ĵ������ )
							</div>
							<div style="text-align:center">
								<input type="hidden" id="model" name="model" value="RBFN">
								<input type="hidden" id="flag" value="0">
								<input type="hidden" id="current_tab" value="3">
								<input type="button" class="button button-pill button-primary" 
								onClick="saveparameter();" value="����">
								<input type="submit" class="button button-pill button-primary" value="Ԥ��">
							</div>	
  						</form>
					</div> 
				</div>
				<div id="RBFN_con4" style="display:none">
					<iframe name="SHOWDATA_RBFN" src="../../resultshow/resultDriven.jsp"></iframe>
				</div> 
			</div> 
		</div>
	</body>
</html>