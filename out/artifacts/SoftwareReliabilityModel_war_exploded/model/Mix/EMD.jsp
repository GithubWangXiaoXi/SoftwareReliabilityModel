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
		<title>EMDģ��</title>
   		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/onload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/mix/validate_EMD_resolve.js" 
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
		<input type="hidden" id="flag" value="0">
		<input type="hidden" id="mergerflag" value="0">
		<input type="hidden" id="current_tab" value="3">
		<form action="../../resultshow/resultMix_Resolve.jsp" method="post"
							target="SHOWDATA_EMD_RESOLVE"
							name="resolve">
			<input type="hidden" name="Combination" value="1">
			<input type="hidden" name="Sequence" value="<%= Sequence%>">
			<input type="hidden" name="resolvename" value="<%= resolvename%>">
			<input type="hidden" name="model" value="<%= model%>">
		</form>
		<div class="titlename">EMD�ֽ�ģ��</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="EMD_tab1" onClick="setTab('EMD',1,5)" class="hover">ģ�ͼ��</li> 
					<li id="EMD_tab2" onClick="setTab('EMD',2,5)">ʧЧ����</li> 
					<li id="EMD_tab3" onClick="setTab('EMD',3,5)">�ֽ�����</li>
					<li id="EMD_tab4" onClick="setTab('EMD',4,5)" style="display:none;">�ֽ�����ʾ</li>
					<li id="EMD_tab5" onClick="setTab('EMD',5,5)" style="display:none;">��Ͻ����ʾ</li> 
				</ul> 
			</div> 
			<div class="main_tab_content">
				<div id="EMD_con1">
					<div class="subtitle">ģ�ͼ��</div>
					<div class="scrollbox">
						<p>
							����ģ̬�ֽ⣨Empirical Model Decomposition, EMD����һ�ֻ����źžֲ��������źŷֽⷽ����
							�÷�����ȡ��С���任��ֱ�����ƣ�
							ͬʱ�˷���С���任����ѡȡС������ȷ���ֽ�߶ȵ����ѣ�
							��˸����ڷ����ԡ���ƽ���źŷ�����
							��һ������Ӧ���źŷֽⷽ����
							�ѱ��ɹ�Ӧ��������о�����
							����ģ̬�ֽ���Ϊһ���µ�ʱƵ����������
							�ӱ����Ͻ��Ƕ�һ���źŽ���ƽ�Ȼ�����
							�����ǽ��ź��в�ͬ�߶ȵĲ����������𼶷ֽ⿪����
							����һϵ�о��в�ͬ�����߶ȵ��������У�
							ÿһ�����д���һ������ģʽ����IMF(Intrinsic Mode Function)��
							�ֽ���ĸ���IMF����ͻ�������ݵľֲ�����������з������Ը�׼ȷ��Ч�ذ���ԭʼ���ݵ�������Ϣ��
							����ģ̬����������������������
						</p>
						<p>�ټ�ֵ����������Ŀ������Ȼ��������һ�㣻</p>
						<p>
							����������ɾֲ�����ֵ�㹹�ɵİ�������ֲ���Сֵ�㹹�ɵİ����ߵ�ƽ��ֵΪ�㡣
							��������<i>x</i>(<i>t</i>)�ľ���ģ̬�ֽⲽ�����£�
						</p>
						<p>1)�ҳ�x(t)�����оֲ�����ֵ��;ֲ���Сֵ�㣻</p>
						<p>
							2)�����оֲ�����ֵ��;ֲ���Сֵ��ֱ�����������������ϳ��������е��ϡ��°�����
							<i>u<sub>0</sub></i>(<i>t</i>)��<i>v<sub>0</sub></i>(<i>t</i>)��
						</p>
						<p>	3)���ϡ��°����ߵ�ƽ��������Ϊ<i>m<sub>0</sub></i>(<i>t</i>):</p>
						<p style="text-align:center;"><img src="../../IMAGE/Mix/EMD_1.jpg"></p>
						<p>
							��ԭ��������<i>x</i>(<i>t</i>)��<i>m<sub>0</sub></i>(<i>t</i>)֮��Ϊ��
							<i>h<sub>0</sub></i>(<i>t</i>)=
							<i>x</i>(<i>t</i>)-<i>m<sub>0</sub></i>(<i>t</i>)��
						</p>
						<p>
							4)�ж�<i>h<sub>0</sub></i>(<i>t</i>)�Ƿ�����IMF���������ʡ�
							�����㣬��<i>h<sub>0</sub></i>(<i>t</i>)ΪIMF��
							���򣬼�<i>h<sub>0</sub></i>(<i>t</i>)Ϊ<i>x</i>(<i>t</i>)��
							�ظ�����1)-3)��
							ֱ���õ�һ��IMF��
							��Ϊ<i>c<sub>1</sub></i>(<i>t</i>)��
						</p>
						<p>
							5)��<i>r<sub>1</sub></i>(<i>t</i>)=
							<i>x</i>(<i>t</i>)-<i>c<sub>1</sub></i>(<i>t</i>)Ϊ�µ��������У�
							�ظ�����1)~4)��
							�õ��ڶ���IMF��
							��Ϊ<i>c<sub>2</sub></i>(<i>t</i>)��
							����һֱ�ظ���ȥֱ������<i>r<sub>n</sub></i>(<i>t</i>)
							��һ�������������л�<i>r<sub>n</sub></i>(<i>t</i>)��ֵС��Ԥ�ȸ�������ֵ��
							�ֽ������
						</p>
						<p>
							������
							���տɵõ�<i>n</i>��IMFs<i>c<sub>1</sub></i>(<i>t</i>),
							<i>c<sub>2</sub></i>(<i>t</i>),...,<i>c<sub>n</sub></i>(<i>t</i>)��
							����Ϊ<i>c<sub>n</sub></i>(<i>t</i>)��
							��ˣ�ԭʼ��������<i>x</i>(<i>t</i>)�ɱ�ʾΪ��
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Mix/EMD_2.jpg"></p>
						<p>
							��ƽ�ȵ�ʧЧ�������о���EMD�ֽ��Ժ�
							��IMF��������������ƽ�ȣ�
							���Ԥ���������ġ�
							����ÿһIMF�������Ƕ����ʧЧ��������������һ����ʵ��Ӧ��
							ͨ����ʧЧ�������еĸ��������ֱ����Ԥ�⴦��
							Ȼ���ٶԸ�Ԥ�������������ع���
							�Ϳ��Եõ����������Ԥ��Ч����
						</p>
					</div>
				</div>
				<div id="EMD_con2" style="display:none">
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
				<div id="EMD_con3" style="display:none">
					<div class="subtitle">�ֽ�����</div>
					<div class="setup">
						<form action="../../resultshow/resultMix_Resolve.jsp" method="post"
							target="SHOWDATA_EMD_RESOLVE"
							onsubmit="return validate_EMD_resolve(this);;">
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
							<div class="parametersetup_title">������ƽ��ֵ��</div>
							<div class="parametersetup_content">
								<input type="text" name="EMD_parameter1" value="10.0">
								(���÷�Χ������0�����ƾ���ģ̬�ֽ������Ŀ�����ֵԽ������Խ�졣 )
							</div>
							<div class="parametersetup_title">���ֽ������</div>
							<div class="parametersetup_content">
								<input type="text" name="EMD_parameter2" value="8">
								(���÷�Χ��2-9���ֽ����������ֵ�����������ֵ����ֹͣ�ֽ⡣ )
							</div>
							<div style="text-align:center">
								<input type="hidden" id="model" name="model" value="EMD">
								<input type="submit" class="button button-pill button-primary" value="�ֽ�">
							</div>	
  						</form>
					</div>
				</div>
				<div id="EMD_con4" style="display:none">
					<iframe name="SHOWDATA_EMD_RESOLVE" 
					src="../../resultshow/resultMix_Resolve.jsp"></iframe>
				</div>
				<div id="EMD_con5" style="display:none">
					<iframe name="SHOWDATA_EMD_MERGER" 
					src="../../resultshow/resultMix_Merger.jsp"></iframe>
				</div>	
			</div>
		</div>
	</body>
</html>
