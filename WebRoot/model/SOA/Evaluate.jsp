<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<!-- javabean:inputdata ��ǰʹ������ | parameterinfo Ĭ�ϲ�����Ϣ -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>

<html>
	<head>
		<title>SOA�������ģ��</title>
		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">	
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/addsubmodel.js" charset="gb2312"></script>
		
		<script type="text/javascript" src="../../JS/button/combination/validate_Combination.js" 
  		charset="gb2312"></script>
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
		<input type="hidden" id="flag" value="0">
		<div class="titlename">���������ģ��</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="DW_tab1" onClick="setTab('DW',1,4)" class="hover">ģ�ͼ��</li> 
					<li id="DW_tab2" onClick="setTab('DW',2,4)" >ʧЧ����</li> 
					<li id="DW_tab3" onClick="setTab('DW',3,4)">��������</li>
					<li id="DW_tab4" onClick="setTab('DW',4,4)" style="display:none">Ԥ����</li> 
				</ul>
			</div>
			<div class="main_tab_content">
				<div id="DW_con1">
					<div class="subtitle">ģ�ͼ��</div>
					<div class="scrollbox">
						<p>
							�� �� �� �� �� �� ϵ �� �� ( service-orientedarchitecture, SOA)���ж�̬����Эͬ�Եı������� ,��ʹ�ô�ͳ������ɿ����������������������� SOAӦ�õĿ�
���ԡ� ����ⷽ�����Ҫ���� ,�����һ���µĿɿ��Զ�̬�������� ,������������߼�⵽�������������ķ�����Ͽɿ���ģ�͡�
						</p>
						<p>
							��ģ��ͨ���Ե����ϵ� 3�����������Ŀ��ϵͳ�Ķ�̬�仯 ,��: ����ɿ��ԵĶ���ģ�͡�������ݴ�ģ�ͺͻ��� Markov���ķ������ʹ��ģ�͡�
						</p>
						
						<p style="text-align:center;"><img src="../../IMAGE/SOA/soa.JPG"></p>
						<p>
							�ɿ���������һ��ʱ��ĸ��� ,�����޹��ϼ��ʱ�� ( M TT F)��Ϊ�ɿ���ָ�ꡣ����ѧ������ ,ͨ�����ɿ��ȶ���Ϊ���Ӹ�ָ���ֲ�,</p>
							<p>����ʽ:<br>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;R = e- ��t. 
                                                                                     ����: ��(�ˡ� [0, 1 ])ΪʧЧ�� ,һ���ȡ����; t ��ʾ�������е�ʱ�䡣</p>
                                                                                     <p>��������� , t��Ϊ��ɢ�ĵ��ô����������Ƕ�ε��õ����������ǽ�������� ,����
һ����ʹ�������� ,���ض��������������������
ʧЧͬ��Ҳ������Ϊ������ġ�
                                                                                     
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/SOA/soa2.JPG"></p>
						<p>������̬����������⡣��������̬�ֲ�Ϊ��= (Z1 ,Z2 ,�� ,ZN ,ZC ,ZF ) , ���Ц�= ��P </p>
					<p> ������ȫ����̬���ʺ�Ϊ 1��Լ�������ɵ����·�����:</p>
					<img alt="" src="../../IMAGE/SOA/fangcheng.JPG">
					<h3>����˷����÷��̹������£�</h3>
					<p>�����������������̣����������ģ�͵�����ɿ��ԣ�</p>
					<img alt="" src="../../IMAGE/SOA/f2.JPG">
					<img alt="" src="../../IMAGE/SOA/f3.JPG">
					</div>
				</div>
				<div id="DW_con2" style="display:none">
					<%-- <div class="subtitle">���ݻ�����Ϣ</div>
					<div class="currentdata">
						�������ƣ�<%= inputdata.getdataname()%><br><br>
  	 					����������<%= inputdata.getlength_train()+inputdata.getlength_test()%><br><br>
  	 					ѵ�����ݣ�<%= inputdata.getlength_train()%><br><br>
  	 					�������ݣ�<%= inputdata.getlength_test()%><br><br>
						����ά���� <%= inputdata.getdimension()%><br><br>
  	 					����������<%= inputdata.getdatainfo()%>
					</div> --%>
					<iframe id="targetframe"name="targetframe" src="../../resultshow/showhistorydata.jsp"></iframe>
				</div>
				<div id="DW_con3" style="display:none">
					<div class="subtitle">��������</div>
					<div class="setup" style="height:84%">
					  <form action="single.jsp" method="post" 
						target="SHOWDATA_DW" onsubmit="return validate_Combination(this);"onkeydown="if(event.keyCode==13){return false;}">
							<div class="parametersetup_title">����ʧЧ�ʣ�</div>
							<div class="parametersetup_content">
								<input type="text" name="lamdaf" value="">
										(���÷�Χ��0-1�� ���õ�ǰ����Ĺ���ʧЧ��)
							</div>
							
							<div class="parametersetup_title">����ʧЧ�ʣ�</div>
							<div class="parametersetup_content">
								<input type="text" name="lamdac" value="">
										(���÷�Χ��0-1�� ���õ�ǰ���������ʧЧ��)
							</div>
							<!-- <div style="text-align:center;">
								<input type="button" class="button button-pill button-primary" onClick="addmodel();" value="����ģ��">
								<input type="button" class="button button-pill button-primary" onClick="submodel();" value="����ģ��">
							</div>
						 -->
						  
							<div style="text-align:center">
						 		<input type="hidden" id="model" name="model" value="DW">
								<input type="hidden" id="number" name="number" value="2">
								<input type="hidden" id="current_tab" value="3">  
								<input type="hidden" name="prestep" value="3">  
								<input type="submit" class="button button-pill button-primary" value="Ԥ��">
							</div>
						</form> 
						
						
						
					</div>	
				</div>
				<div id="DW_con4" style="display:none">
					<iframe name="SHOWDATA_DW" src="single.jsp"></iframe>
				</div>
			</div>		
		</div>
	</body>
</html>