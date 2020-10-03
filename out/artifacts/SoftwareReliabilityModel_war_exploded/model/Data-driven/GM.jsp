<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="system.*" %>
<!-- javabean:inputdata 当前使用数据 | parameterinfo 默认参数信息 -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<%
	String step = parameterinfo.getstep();
	String[] parameter = parameterinfo.getparameter("GM");
	ReadTable rt =new ReadTable();
	HistoryData historydata=new HistoryData();
	ArrayList<DataSet> list=rt.getDataSet(0);
	for(int i=0;i<list.size();i++){
		DataSet ds=list.get(i);	
		historydata.entry(ds.getData(), ds.getSetname(), ds.getColname(), ds.getSetinfo());
	
	}
	
		DataSet curds=list.get(list.size()-1);
		inputdata.setdata(curds.getData(),		//用备选数据集中的指定数据替换掉当前数据
		 			curds.getSetname(),
		 			curds.getColname(),
		  			curds.getPercent(),
					curds.getSetinfo());
%>

<html>
	<head>
    	<title>GM模型</title>
   		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/datadriven/validate_GM.js" 
  		charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/saveparameter.js" charset="gb2312"></script>
	</head>
	
	<body>
		 <div id="loader_container" style="display:none">   <!-- 执行等待条 -->
			<div id="loader">
				<div align="center">正在执行，请稍后 ...</div>
				<div id="loader_bg">
					<div id="progress"></div>
				</div>
			</div>
		</div>
		<iframe style="display:none" name="MODIFYPARAMETER" 
		src="../../main/modifyparameter.jsp"></iframe>
		<div class="titlename">GM模型</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="GM_tab1" onClick="setTab('GM',1,4)" class="hover">模型简介</li> 
					<li id="GM_tab2" onClick="setTab('GM',2,4)" >失效数据</li> 
					<li id="GM_tab3" onClick="setTab('GM',3,4)">预测分析</li> 
					<li id="GM_tab4" onClick="setTab('GM',4,4)" style="display:none">分析结果</li> 
				</ul> 
			</div> 
			<div class="main_tab_content"> 
				<div id="GM_con1">
					<div class="subtitle">模型简介</div>
					<div class="scrollbox">
						<p>
							灰色系统模型(Gery Model,
							GM)是利用较少的或不确切的表示灰色系统行为特征的原始数据序列作生成变换后建立的，
							用以描述灰色系统内部事物连续变化过程的模型。
							灰色模型通过累加操作(AGO)的方法，
							对无规则的原始数据进行处理，
							从而弱化原始数据的随机性和波动性，
							生成有规则的准指数规律的数据，
							然后对这些生成的数据进行建模、预测。
							常用的灰色预测模型主要是经典的一阶GM(1,1)模型。
						</p>
						<p>GM(1,1)模型由一个单变量的一阶微分方程构成：</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/GM_1.jpg"></p>
						<p>
							式中<i>a</i>和<i>b</i>为待定的参数，
							<i>X<sub>1</sub></i>为原始数据序列<i>X<sub>0</sub></i>的累加生成值，
							上式也被称为时间响应函数。设<i>X<sub>0</sub></i>为原始数据的<i>n</i>元序列，
							即
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/GM_2.jpg"></p>
						<p>做一次累加后得到一次累加序列：</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/GM_3.jpg"></p>
						<p>令<i>Z</i><sub>1</sub>为<i>X</i><sub>1</sub>的紧邻均值生成序列为：</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/GM_4.jpg"></p>
						<p>由以上条件可以得到时间响应函数的解为：</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/GM_4.jpg"></p>
						<p>由上式可得到GM(1,1)模型的预测值。</p>
					</div>
				</div>
				<div id="GM_con2" style="display:none">
					<%-- <div class="subtitle">数据基本信息</div>
					<div class="currentdata">
						数据名称：<%= inputdata.getdataname()%><br><br>
  	 					数据总数：<%= inputdata.getlength_train()+inputdata.getlength_test()%><br><br>
  	 					训练数据：<%= inputdata.getlength_train()%><br><br>
  	 					测试数据：<%= inputdata.getlength_test()%><br><br>
						数据维数： <%= inputdata.getdimension()%><br><br>
  	 					数据描述：<%= inputdata.getdatainfo()%>
					</div>  --%>
					<iframe src="../../resultshow/showhistorydata2.jsp"></iframe>
				</div>
				<div id="GM_con3" style="display:none">
					<div class="subtitle">分析设置</div>
					<div class="setup">
						<form action="../../resultshow/resultDriven.jsp" method="post"
							target="SHOWDATA_GM" name="parameterform" 
							onsubmit="return validate_GM(this,1);">
							<div class="parametersetup_title">数据序列：</div>
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
							<div class="parametersetup_title">预测步长：</div>
							<div class="parametersetup_content">
								<input type="text" name="prestep" 
									value="<%= step%>">
								(设置范围：0-100。 设置模型向后预测的步数)
							</div>
							<div class="parametersetup_title">指数分量：</div>
							<div class="parametersetup_content">
								<select name="GM_parameter1">
									<option value="1"
									<% if(parameter[0].equals("1")) {%> selected <%}%>>1
									</option>
									<option value="2"
									<% if(parameter[0].equals("2")) {%> selected <%}%>>2
									</option>
								</select>
								(设置微分方程的阶数，以确定不同的灰色模型方程)
							</div>	
							<div style="text-align:center">
								<input type="hidden" id="model" name="model" value="GM">
								<input type="hidden" id="flag" value="0">
								<input type="hidden" id="current_tab" value="3">
								<input type="button" class="button button-pill button-primary" 
								onClick="saveparameter();" value="保存">
								<input type="submit" class="button button-pill button-primary" value="预测">
							</div>	
  						</form>
					</div> 
				</div>
				<div id="GM_con4" style="display:none">
					<iframe name="SHOWDATA_GM" src="../../resultshow/resultDriven.jsp"></iframe>
				</div> 
			</div> 
		</div>
	</body>
</html>