<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page contentType="text/html;charset= utf-8"%>
<%@ page import="system.*" %>
<!-- javabean:inputdata 当前使用数据 | parameterinfo 默认参数信息 -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<%
	String step = parameterinfo.getstep();
	String[] parameter = parameterinfo.getparameter("ExponentialSRM");
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
    	<title>ExponentialSRM模型</title>
    	<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/classic/validate_ExponentialSRM.js" 
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
		
		
		<div class="titlename">ExponentialSRM模型</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="ExponentialSRM_tab1" onClick="setTab('ExponentialSRM',1,4)" class="hover">模型简介</li> 
					<li id="ExponentialSRM_tab2" onClick="setTab('ExponentialSRM',2,4)" >失效数据</li> 
					<li id="ExponentialSRM_tab3" onClick="setTab('ExponentialSRM',3,4)">预测分析</li> 
					<li id="ExponentialSRM_tab4" onClick="setTab('ExponentialSRM',4,4)" style="display:none">分析结果</li> 
				</ul> 
			</div>
			<div class="main_tab_content"> 
				<div id="ExponentialSRM_con1">
					<div class="subtitle">模型简介</div>
					<div class="scrollbox">
						<p>指数可靠性模型的基本假设：</p>
						<P>指数分布是描述泊松过程中的事件之间的时间的概率分布，即事件以恒定平均速率连续且独立地发生的过程</P>
						<p>
							根据可靠性模型的基本假设，以第i-1次失效为起点的第i次失效发生的测试用例的数量是一个随机变量，
							它服从指数分布，λ > 0是分布的一个参数，常被称为率参数（rate parameter）。
							即每单位时间内发生某事件的次数。指数分布的区间是[0,∞)。
						</p>
						<p>其概率密度函数为：</p>
						<p style="text-align:center;"><img src="../../IMAGE/Classic/Expon1.jpg"></p>
						
						<p>其分布函数为：</p>
						<p style="text-align:center;"><img src="../../IMAGE/Classic/Expon2.jpg"></p>

					</div>
				</div>
				<div id="ExponentialSRM_con2" style="display:none">
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
				<div id="ExponentialSRM_con3" style="display:none">
					<div class="subtitle">分析设置</div>
					<div class="setup">
						<form action="../../resultshow/resultClassic.jsp" method="post"
							target="SHOWDATA_ExponentialSRM" name="parameterform" 
							onsubmit="return validate_ExponentialSRM(this,1);">
							<div class="parametersetup_title">数据序列：</div>
							<div class="parametersetup_content">
								<select name="Sequence" style="height:30px;width:200px;font-size:18px">
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
								value="<%= step%>" style="height:30px;width:200px;font-size:18px">
								(设置范围：0-100。 设置模型向后预测的步数)
							</div>
							<div style="text-align:center">
								<input type="hidden" id="model" name="model" value="ExponentialSRM">
								<input type="hidden" id="flag" value="0">
								<input type="hidden" id="current_tab" value="3">
								
								<!-- <input type="button" class="button button-pill button-primary" 
								onClick="saveparameter();" value="保存"> -->
								<input type="submit" class="button button-pill button-primary" value="预测">
							</div>	
  						</form>
					</div>
				</div>
				<div id="ExponentialSRM_con4" style="display:none">
					<iframe name="SHOWDATA_ExponentialSRM" src="../../resultshow/resultClassic.jsp"></iframe>
				</div> 
			</div> 
		</div>	
	</body>
</html>
