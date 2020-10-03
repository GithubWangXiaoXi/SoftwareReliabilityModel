<%@ page language="java" import="java.util.*,system.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<!-- javabean:inputdata ��ǰʹ������ -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="resolve" class="system.Resolve" scope="page"></jsp:useBean>
<% 
	if(request.getParameter("resolveflag") != null)
	{
		String select[] = request.getParameterValues("select");
		resolve.setselect(select);
	}
	String model = request.getParameter("model");
	String resolveflag = request.getParameter("resolveflag");
	String Sequence = request.getParameter("Sequence");
	String resolvename = request.getParameter("resolvename");
%>
<%
	
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
		<title>SSAģ��</title>
   		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/onload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/mix/validate_SSA_resolve.js" 
  			charset="gb2312"></script>
	</head>
  
  	<body onload="onload_resolve(<%= resolveflag%>)">
		<div id="loader_container" style="display:none">   <!-- ִ�еȴ��� -->
			<div id="loader">
				<div align="center">����ִ�У����Ժ� ...</div>
				<div id="loader_bg">
					<div id="progress"></div>
				</div>
			</div>
		</div>
		<input type="hidden" id="wl" 
				value="<%= inputdata.getlength_train()/2%>">
		<input type="hidden" id="flag" value="0">
		<input type="hidden" id="mergerflag" value="0">
		<input type="hidden" id="current_tab" value="3">
		<form action="../../resultshow/resultMix_Resolve.jsp" method="post"
							target="SHOWDATA_SSA_RESOLVE"
							name="resolve">
			<input type="hidden" name="Combination" value="1">
			<input type="hidden" name="Sequence" value="<%= Sequence%>">
			<input type="hidden" name="resolvename" value="<%= resolvename%>">
			<input type="hidden" name="model" value="<%= model%>">
		</form>
		<div class="titlename">SSA�ֽ�ģ��</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="SSA_tab1" onClick="setTab('SSA',1,5)" class="hover">ģ�ͼ��</li> 
					<li id="SSA_tab2" onClick="setTab('SSA',2,5)">ʧЧ����</li> 
					<li id="SSA_tab3" onClick="setTab('SSA',3,5)">�ֽ�����</li>
					<li id="SSA_tab4" onClick="setTab('SSA',4,5)" style="display:none">�ֽ�����ʾ</li>
					<li id="SSA_tab5" onClick="setTab('SSA',5,5)" style="display:none">��Ͻ����ʾ</li> 
				</ul> 
			</div> 
			<div class="main_tab_content">
				<div id="SSA_con1">
					<div class="subtitle">ģ�ͼ��</div>
					<div class="scrollbox">
						<p>
							�����׷���(Singular Spectrum Analysis�� SSA)������һ�ֻ���ͳ��ԭ��ķǲ���ʱ�����з���������
							�����ͳ��ѧ�������ۡ���̬ϵͳ���źŴ������ۡ�
							���ɽ���֪��ʱ�����зֽ��Ϊ���ɸ��໥��������ʱ�����У�
							ÿ�������ж�����ԭʼ���е�ĳ��������
							�����ơ����ڻ���׼�����Լ�������
						</p>
						<p>
							ʱ������ �� ���ڳ���<i>L</i>�� ��<i>K</i>=<i>N</i>-<i>L</i>+1�� 
							��ɻ�����¹������
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Mix/SSA_1.jpg"></p>
						<p>
							��Ȼ����������ΪHankel ���󣬼����ھ����жԽ����ϵ�Ԫ��<i>a<sub>i,j</sub></i>��
							<i>a<sub>m,n</sub></i>�� ��<i>i</i>+<i>j</i>=<i>m</i>+<i>n</i>ʱ��
							��<i>a<sub>i,j</sub></i>=<i>a<sub>m,n</sub></i>������
							���ǿ��Եõ�Э�������<i>S</i>:
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Mix/SSA_2.jpg"></p>
						<p>
							����ֵ�ֽ��Ǿ��������һ��ǿ������ļ�����
							ͨ����Э������� �Ľ��м򵥵ľ������㣬
							�ܹ��õ���������ֵ<i>��<sub>1</sub></i>��<i>��<sub>2</sub></i>��...��<i>��<sub>L</sub></i>
							�Ͷ�Ӧ��������������<i>U<sub>1</sub></i>��<i>U<sub>2</sub></i>��...��<i>U<sub>L</sub></i>��
							�������������ֵ�ֽ��дΪ��
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Mix/SSA_3.jpg"></p>
						<p>
							����ʽ��<i>E<sub>i</sub></i>�ֳ����ɻ������ӵ��飬
							������������{1,2,...,<i>d</i>}�ֳ�
							<i>I<sub>1</sub></i>��<i>I<sub>2</sub></i>��...��<i>I<sub>m</sub></i>��
							�ɽ���<i>I</i>�������ʾΪ��
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Mix/SSA_4.jpg"></p>
						<p>
							��SSA���漰�������������Ĳ����� ��һΪ���ڳ���<i>L</i>��
							��һ��Ϊ�������������岿���������ĸ���<i>r</i>��
							һ����˵���ڳ���<i>L</i>Ϊ<i>N</i>/2��
							�����ʱ�����а���һ����������<i>t</i>��
							�ɽ�<i>L</i>����Ϊ<i>t</i>���������� һ����˵��˵��
							ѡ����<i>r</i>��������Ҫ�ܹ���֤���ǵĹ��׶ȴ���һ����ֵ�����90%��ʣ��Ϊ�������ֵ����������׶�Ӧ��С��
							SSAģ�ͽ�ԭʼ���������зֽ�����ɸ��ܹ���ӳ��ԭʼ�������������У�
							����Щ�����У� ����׶��������о��н�Ϊ���õ�ƽ���ԡ�
						</p>
					</div>
				</div>
				<div id="SSA_con2" style="display:none">
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
				<div id="SSA_con3" style="display:none">
					<div class="subtitle">�ֽ�����</div>
					<div class="setup">
						<form action="../../resultshow/resultMix_Resolve.jsp" method="post"
							target="SHOWDATA_SSA_RESOLVE"
							onsubmit="return validate_SSA_resolve(this);;">
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
							<div class="parametersetup_title">����׶ȣ�</div>
							<div class="parametersetup_content">
								<input type="text" name="SSA_parameter1" 
								value="0.9">
								(���÷�Χ��0-1������ɷ�ռ����İٷֱȡ����׶�Խ������ԽС��)
							</div>
							<div class="parametersetup_title">���ڳ��ȣ�</div>
							<div class="parametersetup_content">
								<input type="text" name="SSA_parameter2" 
								value="<%= inputdata.getlength_train()/2%>">
								(���÷�Χ��2-<%= inputdata.getlength_train()/2%>
								�� ���ھ����ֽ�������еĸ���)
							</div>
							<div style="text-align:center">
								<input type="hidden" id="model" name="model" value="SSA">
								<input type="submit" class="button button-pill button-primary" value="�ֽ�">
							</div>	
  						</form>
					</div>
				</div>
				<div id="SSA_con4" style="display:none">
					<iframe name="SHOWDATA_SSA_RESOLVE" 
					src="../../resultshow/resultMix_Resolve.jsp"></iframe>
				</div>
				<div id="SSA_con5" style="display:none">
					<iframe name="SHOWDATA_SSA_MERGER" 
					src="../../resultshow/resultMix_Merger.jsp"></iframe>
				</div>
			</div>
		</div>
	</body>
</html>