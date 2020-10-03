<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="system.*" %>
<%@ page import="com.alibaba.fastjson.JSON" %>
<!-- javabean:inputdata ��ǰʹ������ | parameterinfo Ĭ�ϲ�����Ϣ -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<%
	String step = parameterinfo.getstep();
	String[] parameter = parameterinfo.getparameter("SVM");
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

		String featureName =  JSON.toJSONString(curds.getColname());
		System.out.println(featureName);
%>

<html>
	<head>
    	<title>SVMģ��</title>
   		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/datadriven/validate_SVM.js" 
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
		<div class="titlename">SVMģ��</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul>
					<li id="SVM_tab1" onClick="setTab('SVM',1,4)" class="hover">ģ�ͼ��</li> 
					<li id="SVM_tab2" onClick="setTab('SVM',2,4)" >ʧЧ����</li> 
					<li id="SVM_tab3" onClick="setTab('SVM',3,4)">Ԥ�����</li> 
					<li id="SVM_tab4" onClick="setTab('SVM',4,4)" style="display:none">�������</li> 
				</ul>
			</div> 
			<div class="main_tab_content"> 
				<div id="SVM_con1">
					<div class="subtitle">ģ�ͼ��</div>
					<div class="scrollbox">
						<p>
							Vapnik������1995�����ͳ��ѧϰ���������һ��ѧϰ����-֧��������(Support Vector Machine, SVM)��
							����һ�ּලѧϰ��
							��ͨ��ѵ������������������õ�Ŀ�꺯���ķ�����
							�������ܵ��˹���ѧ����Ĺ㷺���ӣ�
							�Ѿ��㷺���ڽ������ͻع����⡣
							��֧�����������ڽ���ع����⼴֧�������ع顣
							֧��������������ص�����Խṹ������С��ԭ������ģ�
							�ı��˴�ͳ�ľ��������С��ԭ��
							��˾��кܺõķ���������
							���⣬֧���������ڴ������������ʱ��
							���Ƚ�����������ת��Ϊ��ά�ռ��е��������⣬
							Ȼ����һ���˺�����kernel function���������ά�ռ��е��ڻ����㣬
							�Ӷ�����ؽ���˸��Ӽ������⣬
							������Ч�ؿ˷���ά�����Ѽ��ֲ���С���⡣
						</p>
						<p>
							����ѵ��Ŀ��(<i>x<sub>i</sub></i>,<i>y<sub>i</sub></i>)��
							���Իع��Ŀ����������Ժ�����
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/SVM_1.jpg"></p>
						<p>
							������ѵ����������Ͼ���Ϊ<i>��</i>(�ֳ�Ϊ������ϵ��)����������ʽ��
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/SVM_2.jpg"></p>
						<p>
							Ϊ���ǳ�������Ҫ��������
							����Ǹ��ɳڱ���<i>��<sub>i</sub></i>��<i>��<sub>i</sub></i><sup>*</sup>��
							����������������ת��Ϊ�������<i>w</i>��<i>b</i>�����Ż����⣬��
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/SVM_3.jpg"></p>
						<p>ͨ�������������ճ��ӣ����Եõ����Ż�����Ķ�ʽ��</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/SVM_4.jpg"></p>
						<p>
							���У�
							<i>a<sub>i</sub></i>��<i>a<sub>i</sub></i><sup>*</sup>���������ճ��ӡ�
							֧�������������ڴ������������ʱ��ʵ�������Ե�ά�ռ�������Ϊ����ĺ˺���
							<i>K</i>(<i>x<sub>i</sub></i>,<i>y<sub>i</sub></i>)
							ֵ�����ӳ������ά�ռ�����������ڻ�ֵ��
							��ͨ���˺�������ά�ռ��е��������ά�ռ���ӳ�䣬
							ֱ����ά�ռ��е��������Կɷ�Ϊֹ��
							��ˣ�
							�����õ�Ŀ�꺯��Ϊ��
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/SVM_5.jpg"></p>
						<p>
							֧��������������ص�����������Խṹ������С��ԭ�������ģ�
							�ı��˴�ͳ�ľ��������С��ԭ��
							���кܺõķ���������
							���������ڸ��������еõ��˹㷺Ӧ�ã�
							������ɿ���������Ҳ�õ��˽϶�ѧ�ߵ��о���
							SVM������˺�����һ���
							���ܹ����ڵ�ά�ռ������Բ��ɷ�����ת��Ϊ��ά�ռ��е����Կɷ����⣬
							���������ɿ��������У�������и��Ӻͷ����Թ�ϵ�����ʧЧ����ʱ����һ�������ơ�
						</p>
					</div>
				</div>
				<div id="SVM_con2" style="display:none">
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
				<div id="SVM_con3" style="display:none">
					<%--<input type="hidden" id="featureName" name="featureName" value="<%= curds.getColname()%>">--%>
					<div class="subtitle">��������</div>
					<div class="setup" style="height:85%;overflow:auto;">
						<form action="../../resultshow/resultDriven.jsp" method="post"
							target="SHOWDATA_SVM" name="parameterform" 
							onsubmit="return validate_SVM(this,1);">
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
							<div class="parametersetup_title">SVM���ͣ�</div>
							<div class="parametersetup_content">
								<select name="SVM_parameter1">
									<option value="3" <%if(parameter[0].equals("3")) {%>selected<%}%>>
										epsilon-SVR
									</option>
									<option value="4" <%if(parameter[0].equals("4")) {%>selected<%}%>>
										nu-SVR
									</option>
								</select>
								(���÷�Χ��0-1�� )
							</div>
							<div class="parametersetup_title">�˺������ͣ�</div>
							<div class="parametersetup_content">
								<select name="SVM_parameter2">
									<option value="0" <%if(parameter[1].equals("0")) {%>selected<%}%>>
										���Ժ�
									</option>
									<option value="2" <%if(parameter[1].equals("2")) {%>selected<%}%>>
										�������
									</option>
									<option value="3" <%if(parameter[1].equals("3")) {%>selected<%}%>>
										S�ͺ�
									</option>
								</select>
								(���÷�Χ��0-1�� )
							</div>
							<div class="parametersetup_title">�ͷ�ϵ����</div>
							<div class="parametersetup_content">
								<input type="text" name="SVM_parameter3" 
								value="<%= parameter[2]%>">
								(���÷�Χ��0-100000��ֵԽ��Ч��Խ��ȷ�����������㷨�ĵ������� )
							</div>
							<div class="parametersetup_title">gammaֵ��</div>
							<div class="parametersetup_content">
								<input type="text" name="SVM_parameter4" 
									value="<%= parameter[3]%>">
								(���÷�Χ��0-1�� )
							</div>	
							<div class="parametersetup_title">��ʧ����ֵ��</div>
							<div class="parametersetup_content">
								<input type="text" name="SVM_parameter5" 
									value="<%= parameter[4]%>">
								(���÷�Χ��0-1�� )
							</div>	
							<div class="parametersetup_title">nu������</div>
							<div class="parametersetup_content">
								<input type="text" name="SVM_parameter6" 
									value="<%= parameter[5]%>">
								(���÷�Χ��0-1�� )
							</div>
							<div class="parametersetup_title">S�ͺ˲�����</div>
							<div class="parametersetup_content">
								<input type="text" name="SVM_parameter7" 
									value="<%= parameter[6]%>">
								(���÷�Χ��0-1�� )
							</div>
							<div class="parametersetup_title">��ֹ������</div>
							<div class="parametersetup_content">
								<input type="text" name="SVM_parameter8" 
									value="<%= parameter[7]%>">
								(���÷�Χ��0-1�� )
							</div>
							
							<div style="text-align:center">
								<input type="hidden" id="model" name="model" value="SVM">
								<input type="hidden" id="flag" value="0">
								<input type="hidden" id="current_tab" value="3">
								<input type="button" class="button button-pill button-primary" 
								onClick="saveparameter();" value="����">
								<input type="submit" class="button button-pill button-primary" value="Ԥ��">
							</div>	
  						</form>
					</div> 
				</div>
				<div id="SVM_con4" style="display:none">
					<iframe name="SHOWDATA_SVM" src="../../resultshow/resultDriven.jsp"></iframe>
				</div> 
			</div> 
		</div>
	</body>
</html>
