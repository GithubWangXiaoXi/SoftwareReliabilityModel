<%@ page language="java" import="java.util.*,system.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<!-- javabean:inputdata 当前使用数据 | parameterinfo 默认参数信息 -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<%
	
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
		<title>EW模型</title>
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
		<div id="loader_container" style="display:none">   <!-- 执行等待条 -->
			<div id="loader">
				<div align="center">正在执行，请稍后 ...</div>
				<div id="loader_bg">
					<div id="progress"></div>
				</div>
			</div>
		</div>
		<input type="hidden" id="flag" value="0">
		<div class="titlename">等权重组合模型</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="EW_tab1" onClick="setTab('EW',1,4)" class="hover">模型简介</li> 
					<li id="EW_tab2" onClick="setTab('EW',2,4)" >失效数据</li> 
					<li id="EW_tab3" onClick="setTab('EW',3,4)">模型选择</li>
					<li id="EW_tab4" onClick="setTab('EW',4,4)" style="display:none">分析结果</li> 
				</ul>
			</div>
			<div class="main_tab_content">
				<div id="EW_con1">
					<div class="subtitle">模型简介</div>
										<div class="scrollbox">
						<p style="text-align:center;"><img src="../../IMAGE/com/EW.jpg"></p>
					</div>
				</div>
				<div id="EW_con2" style="display:none">
					<%-- <div class="subtitle">数据基本信息</div>
					<div class="currentdata">
						数据名称：<%= inputdata.getdataname()%><br><br>
  	 					数据总数：<%= inputdata.getlength_train()+inputdata.getlength_test()%><br><br>
  	 					训练数据：<%= inputdata.getlength_train()%><br><br>
  	 					测试数据：<%= inputdata.getlength_test()%><br><br>
						数据维数： <%= inputdata.getdimension()%><br><br>
  	 					数据描述：<%= inputdata.getdatainfo()%>
					</div> --%>
					<iframe src="../../resultshow/showhistorydata2.jsp"></iframe>
				</div>
				<div id="EW_con3" style="display:none">
					<div class="subtitle">模型选择</div>
					<div class="setup" style="height:84%">
						<form action="../../resultshow/resultCombination.jsp" method="post"
								target="SHOWDATA_EW" onsubmit="return validate_Combination(this);">
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
								<input type="text" name="prestep" value="<%= parameterinfo.getstep()%>">
										(设置范围：0-100。 设置模型向后预测的步数)
							</div>
							<div style="text-align:center;">
								<input type="button" class="button button-pill button-primary" onClick="addmodel();" value="增加模型">
								<input type="button" class="button button-pill button-primary" onClick="submodel();" value="减少模型">
							</div>
						<%	for(int i=1;i<=6;i++)
							{%>
								<div id="model<%= String.valueOf(i)%>" class="addsubmodel"
									<% if(i>=3) {%> style="display:none" <%}%>>
									模型<%= String.valueOf(i)%>：
									<select name="modelselect<%= String.valueOf(i)%>">
										<option value="BPN" selected>BPN模型</option>
										<option value="RBFN">RBFN模型</option>
										<option value="GEP">GEP模型</option>
										<option value="GM">GM模型</option>
										<option value="SVM">SVM模型</option>
										<option value="ARIMA">ARIMA模型</option>
										<option value="JM">J_M模型</option>
										<option value="DUANE">DUANE模型</option>
										<option value="WEIBULL">Weibull模型</option>
										<option value="GammaSRM">GammaSRM模型</option>
										<option value="ExponentialSRM">ExponentialSRM模型</option>
										<option value="LogNormalSRM">LogNormalSRM模型</option>
										<option value="GO">G_O模型</option>
										<option value="SCHNEIDEWIND">Schneidewind模型</option>
										<option value="MO">M_O模型</option>
	<!-- **********************************增加模型接口********************************** -->
	<!-- **********************************增加模型接口********************************** -->
	<!-- **********************************增加模型接口********************************** -->
	<!-- **********************************增加模型接口********************************** -->
	<!-- **********************************增加模型接口********************************** -->
									</select>
							</div>
						<%	}%>
							<div style="text-align:center">
								<input type="hidden" id="model" name="model" value="EW">
								<input type="hidden" id="number" name="number" value="2">
								<input type="hidden" id="current_tab" value="3">
								<input type="submit" class="button button-pill button-primary" value="预测">
							</div>
						</form>
					</div>	
				</div>
				<div id="EW_con4" style="display:none">
					<iframe name="SHOWDATA_EW" src="../../resultshow/resultCombination.jsp"></iframe>
				</div>
			</div>		
		</div>
	</body>
</html>