<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="system.*" %>
<%@ page import="com.alibaba.fastjson.JSON" %>
<!-- javabean:inputdata ��ǰʹ������ | parameterinfo Ĭ�ϲ�����Ϣ -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<%
	String step = parameterinfo.getstep();
	String[] parameter = parameterinfo.getparameter("BOOST");
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
    	<title>����ģ��</title>
   		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/datadriven/validate_BOOST.js"
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
		<div class="titlename">����ģ��</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul>
					<li id="BOOST_tab1" onClick="setTab('BOOST',1,4)" class="hover">ģ�ͼ��</li>
					<li id="BOOST_tab2" onClick="setTab('BOOST',2,4)" >ʧЧ����</li>
					<li id="BOOST_tab3" onClick="setTab('BOOST',3,4)">Ԥ�����</li>
					<li id="BOOST_tab4" onClick="setTab('BOOST',4,4)" style="display:none">�������</li>
				</ul>
			</div> 
			<div class="main_tab_content"> 
				<div id="BOOST_con1">
					<div class="subtitle">ģ�ͼ��</div>
					<div class="scrollbox">
						<p>
							����������Boosting������һ�ֿ���������С�ලʽѧϰ��ƫ��Ļ���ѧϰ�㷨����Ե�����������.��˹��Michael Kearns��
							����ģ�һ�顰��ѧϰ�ߡ��ļ����ܷ�����һ����ǿѧϰ�ߡ�����ѧϰ��һ����ָһ�������������Ľ��ֻ����������һ��㣻
							ǿѧϰ��ָ�������Ľ���ǳ��ӽ���ֵ��
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
				<div id="BOOST_con2" style="display:none">
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
				<div id="BOOST_con3" style="display:none">
					<div class="subtitle">��������</div>
					<div class="setup" style="height:85%;overflow:auto;">
						<form action="../../resultshow/resultDriven1.jsp" method="post" name="parameterform"
							  target="SHOWDATA_BOOST" onsubmit="return validate_BOOST(this,1);">
							<div class="parametersetup_title">�������У�</div>
							<div class="parametersetup_content">
								<select id="Sequence" name="Sequence" onclick="changeFeature()">
							<%	for(int i=1;i<=inputdata.getdimension();i++)
								{%>
									<option value="<%= String.valueOf(i)%>"
									<%if(i==1) {%>selected<%}%>><%= inputdata.getcolname(i)%>
									</option>
							<%	}%>
								</select>
							</div>

							<div class="parametersetup_title">��ѡ������</div>
							<div id="featureBox" class="parametersetup_content">
								<%	for(int i=2;i<=inputdata.getdimension();i++)
								{%>
									<input type="checkbox" value="<%= String.valueOf(i)%>"  name="mybox"><%= inputdata.getcolname(i)%>
								<%}%>
							</div>

							<div class="parametersetup_title">���ĸ߶ȣ�</div>
							<div class="parametersetup_content">
								<input type="text" name="height"
									   value="<%= parameter[0]%>">
								(���÷�Χ��2-(������ + 1)��������ģ�͵���ȣ�������Ϊ������+1)
							</div>
							<div class="parametersetup_title">����������</div>
							<div class="parametersetup_content">
								<input type="text" name="times"
									   value="<%= parameter[1]%>">
								(���÷�Χ��0-1000����ѵ����ָ����������ֹѵ��)
							</div>
							<div class="parametersetup_title">��ֵ��</div>
							<div class="parametersetup_content">
								<input type="text" name="threshold"
								value="<%= parameter[2]%>">
								(���÷�Χ��0-1����ֵ��ָ���������ķ�������ʣ�����ֵС��ָ��ֵ����ֹѵ��)
							</div>
							
							<div style="text-align:center">
								<input type="hidden" id="model" name="model" value="BOOST">
								<input type="hidden" name="dimension" value=${inputdata.getdimension()}>
								<input type="hidden" id="flag" value="0">
								<input type="hidden" id="current_tab" value="3">
								<input type="button" class="button button-pill button-primary" 
								onClick="saveparameter();" value="����">
								<input type="submit" class="button button-pill button-primary" value="Ԥ��">
							</div>	
  						</form>
					</div> 
				</div>
				<div id="BOOST_con4" style="display:none">
					<iframe name="SHOWDATA_BOOST" src="../../resultshow/resultDriven1.jsp"></iframe>
				</div> 
			</div> 
		</div>
	</body>
</html>

<script type="text/javascript">

    //��java����ת����json���ɺ�js��������ת��
    var featureName = <%= featureName%>;  //��֪��Ϊɶ�Ӳ�����el���ʽ��ֻ����jsp���ʽ

	function changeFeature() {
        var sequenceId = document.getElementById("Sequence").selectedIndex;

        innerHTMLStr = "";
		var k = 0;
		for (var i = 0; i < featureName.length; ++i){
			if(i != sequenceId) {
				innerHTMLStr += '<input type="checkbox" value=' + (i + 1) + '  name="mybox">'+ featureName[i];
			}
		}

		document.getElementById("featureBox").innerHTML = innerHTMLStr;
    }

</script>