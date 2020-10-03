<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="system.*" %>
<!-- javabean:inputdata 当前使用数据 | parameterinfo 默认参数信息 -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<%
	String step = parameterinfo.getstep();
	String[] parameter = parameterinfo.getparameter("GO");
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
    	<title>GO模型</title>
    	<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/classic/validate_GO.js" 
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
		
		
		<div class="titlename">GO模型</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="GO_tab1" onClick="setTab('GO',1,4)" class="hover">模型简介</li> 
					<li id="GO_tab2" onClick="setTab('GO',2,4)" >失效数据</li> 
					<li id="GO_tab3" onClick="setTab('GO',3,4)">预测分析</li> 
					<li id="GO_tab4" onClick="setTab('GO',4,4)" style="display:none">分析结果</li> 
				</ul> 
			</div>
			<div class="main_tab_content"> 
				<div id="GO_con1">
					<div class="subtitle">模型简介</div>
					<div class="scrollbox">
						<p>GO可靠性模型的基本假设：</p>
						<p>(1)时刻<i>t</i>被查出的累积故障数量服从泊松分布；</p>
						<p>(2)所有的错误均是独立的，而且它们具有相同的几率被检测出来。</p>
						<p>(3)所有检测出的错误都即刻被修复，且在修复的过程中不会引进新的错误。</p>
						<p>设在软件测试的过程中，观察到n个故障被发现的时间分别是：</p>
						<p style="text-align:center;"><img src="../../IMAGE/Classic/GO_1.jpg"></p>
						<p>对上式中的<i>a</i>和<i>b</i>求偏导，可以得到下列方程组：</p>
						<p style="text-align:center;"><img src="../../IMAGE/Classic/GO_2.jpg"></p>
						<p>将求偏导得到的方程组中的<i>a</i>消元，可得一个关于<i>b</i>的函数，令</p>
						<p style="text-align:center;"><img src="../../IMAGE/Classic/GO_3.jpg"></p>
						<p>即<i>b</i>在[0,1]上是严格单调递减的，通过快速弦截法可以求解出参数值。</p>
					</div>
				</div>
				<div id="GO_con2" style="display:none">
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
				<div id="GO_con3" style="display:none">
					<div class="subtitle">分析设置</div>
					<div class="setup">
						<form action="../../resultshow/resultClassic.jsp" method="post"
							target="SHOWDATA_GO" name="parameterform" 
							onsubmit="return validate_GO(this,1);">
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
							<div class="parametersetup_title">预测精度ex：</div>
							<div class="parametersetup_content">
								<input type="text" name="GO_parameter1" 
								value="<%= parameter[0]%>" style="height:30px;width:200px;font-size:18px">
								(设置范围：0-1。)
							</div>
							<div class="parametersetup_title">预测精度ey：</div>
							<div class="parametersetup_content">
								<input type="text" name="GO_parameter2" 
								value="<%= parameter[1]%>" style="height:30px;width:200px;font-size:18px">
								(设置范围：0-1。)
							</div>

							<div style="text-align:center">
								<input type="hidden" id="model" name="model" value="GO">
								<input type="hidden" id="flag" value="0">
								<input type="hidden" id="current_tab" value="3">
								
								<input type="button" class="button button-pill button-primary"  
								onClick="saveparameter();" value="保存">
							<input type="submit" class="button button-pill button-primary"  value="预测">
							</div>	
  						</form>
					</div> 
				</div>
				<div id="GO_con4" style="display:none">
					<iframe name="SHOWDATA_GO" src="../../resultshow/resultClassic.jsp"></iframe>
				</div> 
			</div> 
		</div>	
	</body>
</html>
