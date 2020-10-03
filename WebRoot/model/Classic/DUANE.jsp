<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="system.*" %>
<!-- javabean:inputdata 当前使用数据 | parameterinfo 默认参数信息 -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<%
	String step = parameterinfo.getstep();
	String[] parameter = parameterinfo.getparameter("DUANE");
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
    	<title>Duane模型</title>
    	<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/classic/validate_DUANE.js" 
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
		
		
		<div class="titlename">DUANE模型</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="DUANE_tab1" onClick="setTab('DUANE',1,4)" class="hover">模型简介</li> 
					<li id="DUANE_tab2" onClick="setTab('DUANE',2,4)" >失效数据</li> 
					<li id="DUANE_tab3" onClick="setTab('DUANE',3,4)">预测分析</li> 
					<li id="DUANE_tab4" onClick="setTab('DUANE',4,4)" style="display:none">分析结果</li> 
				</ul> 
			</div>
			<div class="main_tab_content"> 
				<div id="DUANE_con1">
					<div class="subtitle">模型简介</div>
					<div class="scrollbox">
						<p>
							设<i>t</i>为可修复系统的从软件运行至今的工作时间，<i>N</i>(<i>t</i>)为
							(0,<i>t</i>)中系统累积的失效总数， E[<i>N</i>(<i>t</i>)]为其数字期望，
							<i>C</i>(<i>t</i>)为系统的累积失效率，<i>C</i>(<i>t</i>)可以定义为：
							<i>C</i>(<i>t</i>)=E[<i>N</i>(<i>t</i>)]/<i>t</i>，
							E[<i>N</i>(<i>t</i>)]=<i>αt</i><sup>1-<i>m</i></sup>，其中
							<i>α</i>，<i>m</i>是特定参数，并且与时间<i>t</i>无关，则有
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Classic/DUANE_1.jpg"></p>
						<p>
							对方程两侧取以e为底的对数，得到：
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Classic/DUANE_2.jpg"></p>
						<p>
							设(<i>t<sub>i</sub></i>,<i>N<sub>i</sub></i>)是一组数据，<i>N<sub>i</sub></i>
							不严格要求一定是相继的自然数的集合，并且既可以为失效截尾数据，也可以为时间截尾数据，
							则<i>α</i>,<i>m</i>的最小二乘估计值为：
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Classic/DUANE_3.jpg"></p>
					</div>
				</div>
				<div id="DUANE_con2" style="display:none">
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
				<div id="DUANE_con3" style="display:none">
					<div class="subtitle">分析设置</div>
					<div class="setup">
						<form action="../../resultshow/resultClassic.jsp" method="post"
							target="SHOWDATA_DUANE" name="parameterform" 
							onsubmit="return validate_DUANE(this,1);">
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
								<input type="hidden" id="model" name="model" value="DUANE">
								<input type="hidden" id="flag" value="0">
								<input type="hidden" id="current_tab" value="3">
								
								<!-- <input type="button" class="button button-pill button-primary" 
								onClick="saveparameter();" value="保存"> -->
							<input type="submit" class="button button-pill button-primary" value="预测">
							</div>	
  						</form>
					</div>
				</div>
				<div id="DUANE_con4" style="display:none">
					<iframe name="SHOWDATA_DUANE" src="../../resultshow/resultClassic.jsp"></iframe>
				</div> 
			</div> 
		</div>	
	</body>
</html>
