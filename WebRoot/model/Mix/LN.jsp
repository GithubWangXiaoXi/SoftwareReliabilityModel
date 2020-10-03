<%@ page language="java" import="java.util.*,system.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<!-- javabean:inputdata 当前使用数据 -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<%
	String step = parameterinfo.getstep();


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
		<title>L+N模型</title>
   		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/mix/validate_LN.js" 
  		charset="gb2312"></script>
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
		<input type="hidden" id="model" value="LN">
		<input type="hidden" id="flag" value="0">
		<input type="hidden" id="mergerflag" value="0">
		<input type="hidden" id="current_tab" value="3">
		<div class="titlename">残差分解模型</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="LN_tab1" onClick="setTab('LN',1,5)" class="hover">模型简介</li> 
					<li id="LN_tab2" onClick="setTab('LN',2,5)">失效数据</li> 
					<li id="LN_tab3" onClick="setTab('LN',3,5)">分解设置</li>
					<li id="LN_tab4" onClick="setTab('LN',4,5)" style="display:none">分解结果显示</li>
					<li id="LN_tab5" onClick="setTab('LN',5,5)" style="display:none">组合结果显示</li> 
				</ul> 
			</div> 
			<div class="main_tab_content">
				<div id="LN_con1">
					<div class="subtitle">模型简介</div>
					<div class="scrollbox">
						<p>基于残差序列的混合模型可用下式来表达：</p>
						<p style="text-align:center;"><img src="../../IMAGE/Mix/LN_1.jpg"></p>
						<p>
							其中 为原始失效时间序列在时刻<i>t</i>的值，<i>L<sub>t</sub></i>表示模型的线性部分，
							<i>N<sub>t</sub></i>表示模型的非线性部分。
						</p>
						<p>
						对时间序列分解出的线性部分和非线性部分数据分别采用经典可靠性模型和机器学习模型进行建模分析，并进行预测，然后对预测分析结果进行组合，获得最终的软件可靠性预测值。
						</p>
					</div>
				</div>
				<div id="LN_con2" style="display:none">
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
				<div id="LN_con3" style="display:none">
					<div class="subtitle">分解设置</div>
					<div class="setup">
						<form action="../../resultshow/LN/resultMix_LN_Resolve.jsp" method="post"
							target="SHOWDATA_LN_RESOLVE"
							onsubmit="return validate_LN_resolve(this);">
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
								<input type="text" name="prestep" value="<%= step%>">
								(设置范围：0-100。 设置模型向后预测的步数)
							</div>
							<div class="parametersetup_title">模型选择：</div>
							<div class="parametersetup_content">
								<select name="modelselect">
									<option value="BPN" selected>BPN模型</option>
									<option value="RBFN">RBFN模型</option>
									<option value="GEP">GEP模型</option>
									<option value="GM">GM模型</option>
									<option value="SVM">SVM模型</option>
									<option value="ARIMA">ARIMA模型</option>
									<option value="JM">J_M模型</option>
									<option value="DUANE">DUANE模型</option>
									<option value="WEIBULL">Weibull模型</option>
									<option value="GO">G_O模型</option>
									<option value="GammaSRM">GammaSRM模型</option>
									<option value="ExponentialSRM">ExponentialSRM模型</option>
									<option value="LogNormalSRM">LogNormalSRM模型</option>
									<option value="SCHNEIDEWIND">Schneidewind模型</option>
									<option value="MO">M_O模型</option>
<!-- **********************************增加模型接口********************************** -->
<!-- **********************************增加模型接口********************************** -->
<!-- **********************************增加模型接口********************************** -->
<!-- **********************************增加模型接口********************************** -->
<!-- **********************************增加模型接口********************************** -->
								</select>
							</div>
							<div style="text-align:center">
								<input type="submit" class="button button-pill button-primary" value="分解">
							</div>	
  						</form>
					</div>
				</div>
				<div id="LN_con4" style="display:none">
					<iframe name="SHOWDATA_LN_RESOLVE" 
					src="../../resultshow/LN/resultMix_LN_Resolve.jsp"></iframe>
				</div>
				<div id="LN_con5" style="display:none">
					<iframe name="SHOWDATA_LN_MERGER" 
					src="../../resultshow/LN/resultMix_LN_Merger.jsp"></iframe>
				</div>
			</div>
		</div>
	</body>
</html>