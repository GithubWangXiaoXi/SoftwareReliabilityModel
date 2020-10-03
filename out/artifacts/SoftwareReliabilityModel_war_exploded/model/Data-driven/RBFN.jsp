<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<!-- javabean:inputdata 当前使用数据 | parameterinfo 默认参数信息 -->
<%@ page import="system.*" %>
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<%
	String step = parameterinfo.getstep();
	String[] parameter = parameterinfo.getparameter("RBFN");
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
    	<title>RBFN模型</title>
   		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/datadriven/validate_RBFN.js" 
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
		<div class="titlename">RBFN模型</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="RBFN_tab1" onClick="setTab('RBFN',1,4)" class="hover">模型简介</li> 
					<li id="RBFN_tab2" onClick="setTab('RBFN',2,4)">失效数据</li> 
					<li id="RBFN_tab3" onClick="setTab('RBFN',3,4)">预测分析</li> 
					<li id="RBFN_tab4" onClick="setTab('RBFN',4,4)" style="display:none">分析结果</li> 
				</ul> 
			</div> 
			<div class="main_tab_content"> 
				<div id="RBFN_con1">
					<div class="subtitle">模型简介</div>
					<div class="scrollbox">
						<p>
							径向基神经网络（Radial Basis Function Network， RBFN）的基本思想是：
							用RBF作为隐单元的“基”构成隐含层空间，
							这样就可以将输入矢量直接（即不需要通过权接）映射到隐空间。
							当RBF的中心点确定以后， 这种映射关系也就确定了。
							而隐含层空间到输出空间的映射是线性的， 即网络的输出是隐单元输出的线性加权和。
							此处的权即为网络可调参数。 由此可见， 从总体上看， 网络由输入到输出的映射是非线性的，
							而网络输出对可调参数而言却又是线性的。 这样网络的权就可由线性方程直接解出，
							从而大大加快学习速度并避免局部极小问题。	
						</p>
						<p>
							RBF网络是一个三层的网络， 除了输入输出层之外仅有一个隐层。
							隐层中的转换函数是局部响应的高斯函数， 而其他前向型网络， 转换函数一般都是全局响应函数。
							由于这样的不同， 要实现同样的功能， RBF需要更多的神经元，
							这就是RBF网络不能取代标准前向型网络的原因。 但是RBF的训练时间更短。
							它对函数的逼近是最优的， 可以以任意精度逼近任意连续函数。 隐层中的神经元越多， 逼近越精确。
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/RBFN_1.jpg"></p>
						<p>径向基神经网络中常用的径向基函数是高斯函数， 因此径向基神经网络的激活函数可表示为:</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/RBFN_2.jpg"></p>
						<p>径向基神经网络的结构可得到网络的输出为:</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/RBFN_3.jpg"></p>
						<p>
							对于一个给定的非线性函数，用径向基函数神经网络可以以任意精度全局逼近它。
							而且重要的是， 它避免了输入层与隐层间反向传播的繁琐冗长的计算，
							使学习可以比通常的神经网络快很多。	
						</p>
					</div>
				</div>
				<div id="RBFN_con2" style="display:none">
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
				<div id="RBFN_con3" style="display:none">
					<div class="subtitle">分析设置</div>
					<div class="setup">
						<form action="../../resultshow/resultDriven.jsp" method="post"
							target="SHOWDATA_RBFN" name="parameterform" 
							onsubmit="return validate_RBFN(this,1);">
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
							<div class="parametersetup_title">重构维数：</div>
							<div class="parametersetup_content">
								<input type="text" name="RBFN_parameter1" 
								value="<%= parameter[0]%>">
									(设置范围：3-10。 设置神经网络结构输入层节点的个数)
							</div>
							<div class="parametersetup_title">中心相关系数：</div>
							<div class="parametersetup_content">
								<input type="text" name="RBFN_parameter2" 
								value="<%= parameter[1]%>">
								(设置范围：0-1。控制径向基网络中各中心的相关性 )
							</div>
							<div style="text-align:center">
								<input type="hidden" id="model" name="model" value="RBFN">
								<input type="hidden" id="flag" value="0">
								<input type="hidden" id="current_tab" value="3">
								<input type="button" class="button button-pill button-primary" 
								onClick="saveparameter();" value="保存">
								<input type="submit" class="button button-pill button-primary" value="预测">
							</div>	
  						</form>
					</div> 
				</div>
				<div id="RBFN_con4" style="display:none">
					<iframe name="SHOWDATA_RBFN" src="../../resultshow/resultDriven.jsp"></iframe>
				</div> 
			</div> 
		</div>
	</body>
</html>