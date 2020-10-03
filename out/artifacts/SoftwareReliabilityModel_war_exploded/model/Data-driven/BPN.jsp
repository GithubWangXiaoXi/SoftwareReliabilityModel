<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="system.*" %>
<!-- javabean:inputdata 当前使用数据 | parameterinfo 默认参数信息 -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<%
	String step = parameterinfo.getstep();
	String[] parameter = parameterinfo.getparameter("BPN");
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
    	<title>BPN模型</title>
   		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/datadriven/validate_BPN.js" 
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
		<div class="titlename">BPN模型</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="BPN_tab1" onClick="setTab('BPN',1,4)" class="hover">模型简介</li> 
					<li id="BPN_tab2" onClick="setTab('BPN',2,4)" >失效数据</li> 
					<li id="BPN_tab3" onClick="setTab('BPN',3,4)">预测分析</li> 
					<li id="BPN_tab4" onClick="setTab('BPN',4,4)" style="display:none">分析结果</li> 
				</ul> 
			</div>
			<div class="main_tab_content"> 
				<div id="BPN_con1">
					<div class="subtitle">模型简介</div>
					<div class="scrollbox">
						<p>
							反向计算神经网络（Back Propagation Net， BPN）
							是1986年由Rumelhart和McCelland为首的科学家小组提出，
							是一种按误差逆传播算法训练的多层前馈网络， 是目前应用最广泛的神经网络模型之一。
						</p>
						<p>
							BP网络能学习和存贮大量的输入-输出模式映射关系，而无需事前揭示描述这种映射关
							系的数学方程。它的学习规则是使用最速下降法，通过反向传播来不断调整网络的权值
							和阈值，使网络的误差平方和最小。BP神经网络模型拓扑结构包括输入层（input）、
							隐层(hide layer)和输出层(output layer)。
						</p>
						<p>
							单层神经元网络是最基本的神经元网络形式， 由有限个神经元构成，
							所有神经元的输入向量都是同一个向量。 由于每一个神经元都会产生一个标量结果，
							所以单层神经元的输出是一个向量， 向量的维数等于神经元的数目。
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/BPN_1.jpg"></p>
						<p>
							输入层各神经元负责接收来自外界的输入信息， 并传递给中间层各神经元；
							中间层是内部信息处理层， 负责信息变换， 根据信息变化能力的需求，
							中间层可以设计为单隐层或者多隐层结构； 最后一个隐层传递到输出层各神经元的信息，
							经进一步处理后， 完成一次学习的正向传播处理过程， 由输出层向外界输出信息处理结果。
							当实际输出与期望输出不符时， 进入误差的反向传播阶段。 误差通过输出层，
							按误差梯度下降的方式修正各层权值， 向隐层、输入层逐层反传。
							周而复始的信息正向传播和误差反向传播过程， 是各层权值不断调整的过程，
							也是神经网络学习训练的过程， 此过程一直进行到网络输出的误差减少到可以接受的程度，
							或者预先设定的学习次数为止。
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/BPN_2.jpg"></p>
						<p>
							神经网络可以用作分类、聚类、预测等。 神经网络需要有一定量的历史数据，
							通过历史数据的训练， 网络可以学习到数据中隐含的知识。
							在软件可靠性的问题中，首先要找到可靠性的失效数据，用这些数据来训练神经网络。
						</p>
					</div>
				</div>
				<div id="BPN_con2" style="display:none">
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
				<div id="BPN_con3" style="display:none">
					<div class="subtitle">分析设置</div>
					<div class="setup">
						<form action="../../resultshow/resultDriven.jsp" method="post"
						target="SHOWDATA_BPN" name="parameterform" 
						onsubmit="return validate_BPN(this,1);">
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
							<div class="parametersetup_title">学习系数：</div>
							<div class="parametersetup_content">
								<input type="text" name="BPN_parameter1" 
								value="<%= parameter[0]%>">
								(设置范围：0-1。 控制神经网络每轮学习的快慢，越接近于1学习越快)
							</div>
							<div class="parametersetup_title">重构维数：</div>
							<div class="parametersetup_content">
								<input type="text" name="BPN_parameter2" 
								value="<%= parameter[1]%>">
								(设置范围：3-10。 设置神经网络结构输入层节点的个数)
							</div>
							<div class="parametersetup_title">训练代数：</div>
							<div class="parametersetup_content">
								<input type="text" name="BPN_parameter3" 
								value="<%= parameter[2]%>">
								(设置范围：10-100000。 当训练到指定代数，终止训练)
							</div>
							<div class="parametersetup_title">阈值：</div>
							<div class="parametersetup_content">
								<input type="text" name="BPN_parameter4" 
								value="<%= parameter[3]%>">
								(设置范围：0-100。 当阀值小于指定值，终止训练)
							</div>
							<div style="text-align:center">
								<input type="hidden" id="model" name="model" value="BPN">
								<input type="hidden" id="flag" value="0">
								<input type="hidden" id="current_tab" value="3">
								
								<input type="button"class="button button-pill button-primary"  
									onClick="saveparameter();" value="保存">
							    <input type="submit" class="button button-pill button-primary"  value="预测">
							</div>	
  						</form>
					</div> 
				</div>
				<div id="BPN_con4" style="display:none">
					<iframe name="SHOWDATA_BPN" src="../../resultshow/resultDriven.jsp"></iframe>
				</div> 
			</div> 
		</div>
	</body>
</html>
