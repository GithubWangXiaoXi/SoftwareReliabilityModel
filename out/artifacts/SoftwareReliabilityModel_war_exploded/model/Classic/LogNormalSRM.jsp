<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="system.*" %>
<!-- javabean:inputdata 当前使用数据 | parameterinfo 默认参数信息 -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<%
	String step = parameterinfo.getstep();
	String[] parameter = parameterinfo.getparameter("LogNormalSRM");
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
    	<title>LogNormalSRM模型</title>
    	<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/classic/validate_LogNormalSRM.js" 
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
		
		
		<div class="titlename">LogNormalSRM模型</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="LogNormalSRM_tab1" onClick="setTab('LogNormalSRM',1,4)" class="hover">模型简介</li> 
					<li id="LogNormalSRM_tab2" onClick="setTab('LogNormalSRM',2,4)" >失效数据</li> 
					<li id="LogNormalSRM_tab3" onClick="setTab('LogNormalSRM',3,4)">预测分析</li> 
					<li id="LogNormalSRM_tab4" onClick="setTab('LogNormalSRM',4,4)" style="display:none">分析结果</li> 
				</ul> 
			</div>
			<div class="main_tab_content"> 
				<div id="LogNormalSRM_con1">
					<div class="subtitle">模型简介</div>
					<div class="scrollbox">
						<p>对数正态分布（logarithmic normal distribution）是指一个随机变量的对数服从正态分布，则该随机变量服从对数正态分布。
						对数正态分布从短期来看，与正态分布非常接近。但长期来看，对数正态分布向上分布的数值更多一些。</p>
						
						<p>
							对数正态分布用于某些种类的机械零件的可靠性分析和疲劳寿命。其主要用途是在维修性分析中对修理时间数据进行确切的分析。
  							已知对数正态分布的密度函数，就可以根据可靠度与不可靠度函数的定义计算出该分布的可靠度函数和不可靠度函数的表达式。
						</p>
						<p>其概率密度函数为：</p>
						<p style="text-align:center;"><img src="../../IMAGE/Classic/LogNormal1.jpg"></p>

						
					</div>
				</div>
				<div id="LogNormalSRM_con2" style="display:none">
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
				<div id="LogNormalSRM_con3" style="display:none">
					<div class="subtitle">分析设置</div>
					<div class="setup">
						<form action="../../resultshow/resultClassic.jsp" method="post"
							target="SHOWDATA_LogNormalSRM" name="parameterform" 
							onsubmit="return validate_LogNormalSRM(this,1);">
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
								<input type="hidden" id="model" name="model" value="LogNormalSRM">
								<input type="hidden" id="flag" value="0">
								<input type="hidden" id="current_tab" value="3">
								
								<!-- <input type="button" class="button button-pill button-primary" 
								onClick="saveparameter();" value="保存"> -->
							   <input type="submit" class="button button-pill button-primary" value="预测">
							</div>	
  						</form>
					</div>
				</div>
				<div id="LogNormalSRM_con4" style="display:none">
					<iframe name="SHOWDATA_LogNormalSRM" src="../../resultshow/resultClassic.jsp"></iframe>
				</div> 
			</div> 
		</div>	
	</body>
</html>
