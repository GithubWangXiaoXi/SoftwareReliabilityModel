<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="system.*" %>


<!-- javabean:inputdata 当前使用数据 | parameterinfo 默认参数信息 -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<%
	String step = parameterinfo.getstep();
	String[] parameter = parameterinfo.getparameter("JM");
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
    	<title>JM模型</title>
    	<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/classic/validate_JM.js" 
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
		
		
		<div class="titlename">JM模型</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="JM_tab1" onClick="setTab('JM',1,4)" class="hover">模型简介</li> 
					<li id="JM_tab2" onClick="setTab('JM',2,4)">失效数据</li> 
					<li id="JM_tab3" onClick="setTab('JM',3,4)">预测分析</li>
					<li id="JM_tab4" onClick="setTab('JM',4,4)" style="display:none">分析结果</li> 
				</ul> 
			</div>
			<div class="main_tab_content"> 
				<div id="JM_con1">
					<div class="subtitle">模型简介</div>
					<div class="scrollbox">
						<p>JM可靠性模型的基本假设：</p>
						<P>(1)在软件实际运行阶段，故障被检测出的几率与软件目前剩余的故障成正比。</P>
						<P>(2)测试运行方式和实际运行剖面是不同的。</P>
						<P>(3)每个故障的级别是相同的。</P>
						<P>(4)所有故障导致软件危险失效的可能性均相同，并且相互独立。</P>
						<P>(5)失效率在相邻的失效时间间隔内是保持不变的。</P>
						<P>(6)所有检测出的错误都即刻被修复，且在修复的过程中可能会引进新的错误。</P>
						<P>(7)软件开始测试时剩余的故障数为 ，为一个确定的常数。</P>
						<p>
							根据可靠性模型的基本假设，以第i-1次失效为起点的第i次失效发生的测试用例的数量是一个随机变量，
							它服从指数分布，参数为
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Classic/JM_1.jpg"></p>
						<p>且它的概率密度函数为：</p>
						<p style="text-align:center;"><img src="../../IMAGE/Classic/JM_2.jpg"></p>
						<p>其分布函数为：</p>
						<p style="text-align:center;"><img src="../../IMAGE/Classic/JM_3.jpg"></p>

						







					</div>
				</div>
				<div id="JM_con2" style="display:none">
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
				<div id="JM_con3" style="display:none">
					<div class="subtitle">分析设置</div>
					<div class="setup">
						<form action="../../resultshow/resultClassic.jsp" method="post"
							target="SHOWDATA_JM" name="parameterform" 
							onsubmit="return validate_JM(this,1);">
							<div class="parametersetup_title">失 效 数 据：</div>
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
								<input type="text" name="JM_parameter1" 
								value="<%= parameter[0]%>" style="height:30px;width:200px;font-size:18px">
								(设置范围：0-1。 )
							</div>
							<div class="parametersetup_title">预测精度ey：</div>
							<div class="parametersetup_content">
								<input type="text" name="JM_parameter2" 
								value="<%= parameter[1]%>" style="height:30px;width:200px;font-size:18px">
								(设置范围：0-1。 )
							</div>
							<div style="text-align:center">
								<input type="hidden" id="model" name="model" value="JM">
								<input type="hidden" id="flag" value="0">
								<input type="hidden" id="current_tab" value="3">
								
								<input type="button" class="button button-pill button-primary" 
								onClick="saveparameter();" value="保存">
							<input type="submit" class="button button-pill button-primary" value="预测">
							</div>	
  						</form>
					</div> 
				</div>
				<div id="JM_con4" style="display:none">
					<iframe name="SHOWDATA_JM" src="../../resultshow/resultClassic.jsp"></iframe>
				</div> 
			</div> 
		</div>	
	</body>
</html>
