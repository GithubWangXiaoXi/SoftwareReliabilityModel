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
		<title>WAVEģ��</title>
   		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/onload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/mix/validate_WAVE_resolve.js" 
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
							target="SHOWDATA_WAVE_RESOLVE"
							name="resolve">
			<input type="hidden" name="Combination" value="1">
			<input type="hidden" name="Sequence" value="<%= Sequence%>">
			<input type="hidden" name="resolvename" value="<%= resolvename%>">
			<input type="hidden" name="model" value="<%= model%>">
		</form>
		<div class="titlename">С���ֽ�ģ��</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="WAVE_tab1" onClick="setTab('WAVE',1,5)" class="hover">ģ�ͼ��</li> 
					<li id="WAVE_tab2" onClick="setTab('WAVE',2,5)">ʧЧ����</li> 
					<li id="WAVE_tab3" onClick="setTab('WAVE',3,5)">�ֽ�����</li>
					<li id="WAVE_tab4" onClick="setTab('WAVE',4,5)" style="display:none;">�ֽ�����ʾ</li>
					<li id="WAVE_tab5" onClick="setTab('WAVE',5,5)" style="display:none;">��Ͻ����ʾ</li> 
				</ul> 
			</div> 
			<div class="main_tab_content">
				<div id="WAVE_con1">
				<div class="subtitle" style="top-margin:2mm">ģ�ͼ��</div>
					<div class="scrollbox">
						<p>
							С���ֽ���Ϊ����Ƶ�ʵı仯�Զ�������������С�ķ������ߣ�
							��80������������õ���Ѹ�͵ķ�չ��
							�����źŴ���������Ӿ���ͼ��������������ϳɵ��ڶ������õ�Ӧ�á�
						</p>
						<p>
						����Ҷ�任�Ļ���������sin��cos��С���任�Ļ���������С������(basic wavelet)����ͬ��С���ڲ������нϴ�Ĳ��죬
						���Ƶ�С������һ��С����(family)��С�����������ľֲ�����:ֻ�������޵�������ȡֵ��Ϊ0��������Կ��Ժܺõ����ڱ�ʾ���м��� 
						���������źš�
						</p>
						<p>
							���źŴ���ĽǶ������� С����ǿ������ʱƵ�����ߣ�
							���ڿ˷�����Ҷ�任ȱ��Ļ����Ϸ�չ�����ģ�
							����ѧ�ĽǶ�������
							����һ���Ա���Ϊʱ��<i>t</i>�ĺ���<i>f</i>(<i>t</i>)��
							��Ϊ�ź�ʱ�������޵ģ���
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Mix/WAVE_1.jpg"></p>
												<p>
						С���任<i>a=W<sup>T</sup>f</i>
						</p>
						<p>
						���� <i>a</i>��ʾ�任�õ���С��ϵ����<i>W</i>����������<i>f</i> �������źš�
						</p>
						<p>
						�ض���С��������basic wavelet����һ���ض���С���˲�ϵ��(wavelet filter coefficients)���ɡ�
						��ѡ����С�����������Ӧ������С���˲���ϵ����֪������С���˲���ϵ�����첻ͬά�ȵĵ�ͨ�˲����͸�ͨ�˲���
						�������������W��������Щϵ����������ģ�����ͨ�˲������Կ���Ϊһ��ƽ���˲���(smoothing filter)��
						�������˲�������ͨ�͸�ͨ�˲������ֱַ𱻳�Ϊ�߶�(scaling)��С���˲���(wavelet filter)��
						һ����������������˲�����ͨ���ݹ�ֽ��㷨(Ҳ��Ϊ�������㷨(pyramid algorithm),���㷨(tree algorithm)
						���õ�ˮƽ��ֱ��ʱ�ʾ���źš�
						</p>
						<p>
						���㷨��ԭʼ�ź�ͨ����ͨ�˲����õ���Ƶϵ�� (approximate coefficients), ͨ����ͨ�˲����õ���Ƶϵ��
						��detail coefficients�����ѵ�һ��ĵ�Ƶϵ����Ϊ�ź����룬�ֵõ�һ��approximate coefficients��detail
						 coefficients���ٰѵõ���approximate coefficients��Ϊ�ź����룬�õ��ڶ����approximate
						  coefficients��detail coefficients���Դ����ƣ�ֱ�������趨�ķּ��ȼ�,���ķֽ�ȼ�Ϊ<i>log<sub>2</sub></i><i>N</i>��
						  ����ѧ�����ǣ�
						ԭʼ�źſɿ���0����Ƶϵ�� <i>a<sub>0</sub> = ( f<sub>0</sub>, f<sub>1</sub>, ..., f<sub>n</sub> )</i>; ��ô<i>a<sup>m</sup>=G*a<sup>m-1</sup>, d<sup>m</sup> = H*a<sup>m-1</sup>,G, H</i> �ֱ��ʾ��ͨ�˲����͸�ͨ�˲������þ����ʾ��
                                                                                   ���źŵ��ع����£�
						</p>
                    	<p style="text-align:center;"><img src="../../IMAGE/Mix/WAVE_2.jpg"></p>
					</div>
				</div>
				<div id="WAVE_con2" style="display:none">
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
				<div id="WAVE_con3" style="display:none">
					<div class="subtitle">�ֽ�����</div>
					<div class="setup">
						<form action="../../resultshow/resultMix_Resolve.jsp" method="post"
							target="SHOWDATA_WAVE_RESOLVE"
							onsubmit="return validate_WAVE_resolve(this);;">
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
							<div class="parametersetup_title">�ֽ�ά����</div>
							<div class="parametersetup_content">
								<input type="text" name="WAVE_parameter1" value="6">
								(���÷�Χ��2-10�� )
							</div>
							<div class="parametersetup_title">����֮����</div>
							<div class="parametersetup_content">
								<input type="text" name="WAVE_parameter2" value="0.2">
								(���÷�Χ��0-1�� )
							</div>
							<div style="text-align:center">
								<input type="hidden" id="model" name="model" value="WAVE">
								<input type="submit" class="button button-pill button-primary" value="�ֽ�">
							</div>	
  						</form>
					</div>
				</div>
				<div id="WAVE_con4" style="display:none">
					<iframe name="SHOWDATA_WAVE_RESOLVE" 
					src="../../resultshow/resultMix_Resolve.jsp"></iframe>
				</div>
				<div id="WAVE_con5" style="display:none">
					<iframe name="SHOWDATA_WAVE_MERGER" 
					src="../../resultshow/resultMix_Merger.jsp"></iframe>
				</div>
			</div>
		</div>
	</body>
</html>