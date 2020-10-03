<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<!-- javabean:inputdata 当前使用数据 | parameterinfo 默认参数信息 -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>

<html>
	<head>
		<title>SOA服务度量模型</title>
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
		<div class="titlename">单服务度量模型</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="DW_tab1" onClick="setTab('DW',1,4)" class="hover">模型简介</li> 
					<li id="DW_tab2" onClick="setTab('DW',2,4)" >失效数据</li> 
					<li id="DW_tab3" onClick="setTab('DW',3,4)">参数设置</li>
					<li id="DW_tab4" onClick="setTab('DW',4,4)" style="display:none">预测结果</li> 
				</ul>
			</div>
			<div class="main_tab_content">
				<div id="DW_con1">
					<div class="subtitle">模型简介</div>
					<div class="scrollbox">
						<p>
							面 向 服 务 的 体 系 结 构 ( service-orientedarchitecture, SOA)具有动态性与协同性的本质特征 ,这使得传统的软件可靠性评估方法并不适于评估 SOA应用的可
靠性。 针对这方面的主要问题 ,提出了一种新的可靠性动态评估方法 ,其核心是由在线监测到的数据所驱动的服务组合可靠性模型。
						</p>
						<p>
							该模型通过自底向上的 3个层次来分离目标系统的动态变化 ,即: 服务可靠性的度量模型、服务池容错模型和基于 Markov链的服务组合使用模型。
						</p>
						
						<p style="text-align:center;"><img src="../../IMAGE/SOA/soa.JPG"></p>
						<p>
							可靠性首先是一个时间的概念 ,如以无故障间隔时间 ( M TT F)作为可靠性指标。在数学描述上 ,通常将可靠度定义为服从负指数分布,</p>
							<p>如下式:<br>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;R = e- λt. 
                                                                                     其中: λ(λ∈ [0, 1 ])为失效率 ,一般可取常数; t 表示连续运行的时间。</p>
                                                                                     <p>而对于软件 , t变为离散的调用次数。若考虑多次调用的输入条件是近似随机的 ,则在
一定的使用剖面下 ,由特定输入条件所触发的软件
失效同样也可以认为是随机的。
                                                                                     
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/SOA/soa2.JPG"></p>
						<p>采用稳态分析方法求解。即设其稳态分布为η= (Z1 ,Z2 ,… ,ZN ,ZC ,ZF ) , 则有η= ηP </p>
					<p> 再联立全体稳态概率和为 1的约束条件可得如下方程组:</p>
					<img alt="" src="../../IMAGE/SOA/fangcheng.JPG">
					<h3>矩阵乘法求解该方程过程如下：</h3>
					<p>再联立如下两个方程，即可求出该模型的整体可靠性：</p>
					<img alt="" src="../../IMAGE/SOA/f2.JPG">
					<img alt="" src="../../IMAGE/SOA/f3.JPG">
					</div>
				</div>
				<div id="DW_con2" style="display:none">
					<%-- <div class="subtitle">数据基本信息</div>
					<div class="currentdata">
						数据名称：<%= inputdata.getdataname()%><br><br>
  	 					数据总数：<%= inputdata.getlength_train()+inputdata.getlength_test()%><br><br>
  	 					训练数据：<%= inputdata.getlength_train()%><br><br>
  	 					测试数据：<%= inputdata.getlength_test()%><br><br>
						数据维数： <%= inputdata.getdimension()%><br><br>
  	 					数据描述：<%= inputdata.getdatainfo()%>
					</div> --%>
					<iframe id="targetframe"name="targetframe" src="../../resultshow/showhistorydata.jsp"></iframe>
				</div>
				<div id="DW_con3" style="display:none">
					<div class="subtitle">参数设置</div>
					<div class="setup" style="height:84%">
					  <form action="single.jsp" method="post" 
						target="SHOWDATA_DW" onsubmit="return validate_Combination(this);"onkeydown="if(event.keyCode==13){return false;}">
							<div class="parametersetup_title">功能失效率：</div>
							<div class="parametersetup_content">
								<input type="text" name="lamdaf" value="">
										(设置范围：0-1。 设置当前服务的功能失效率)
							</div>
							
							<div class="parametersetup_title">连接失效率：</div>
							<div class="parametersetup_content">
								<input type="text" name="lamdac" value="">
										(设置范围：0-1。 设置当前服务的连接失效率)
							</div>
							<!-- <div style="text-align:center;">
								<input type="button" class="button button-pill button-primary" onClick="addmodel();" value="增加模型">
								<input type="button" class="button button-pill button-primary" onClick="submodel();" value="减少模型">
							</div>
						 -->
						  
							<div style="text-align:center">
						 		<input type="hidden" id="model" name="model" value="DW">
								<input type="hidden" id="number" name="number" value="2">
								<input type="hidden" id="current_tab" value="3">  
								<input type="hidden" name="prestep" value="3">  
								<input type="submit" class="button button-pill button-primary" value="预测">
							</div>
						</form> 
						
						
						
					</div>	
				</div>
				<div id="DW_con4" style="display:none">
					<iframe name="SHOWDATA_DW" src="single.jsp"></iframe>
				</div>
			</div>		
		</div>
	</body>
</html>