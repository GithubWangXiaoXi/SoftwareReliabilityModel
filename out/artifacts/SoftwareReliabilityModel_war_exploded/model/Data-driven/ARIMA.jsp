<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="system.*" %>
<!-- javabean:inputdata 当前使用数据 | parameterinfo 默认参数信息 -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<%
	String step = parameterinfo.getstep();
	String[] parameter = parameterinfo.getparameter("ARIMA");
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
    	<title>ARIMA模型</title>
   		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">	
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/datadriven/validate_ARIMA.js" 
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
		<div class="titlename">ARIMA模型</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="ARIMA_tab1" onClick="setTab('ARIMA',1,4)" class="hover">模型简介</li> 
					<li id="ARIMA_tab2" onClick="setTab('ARIMA',2,4)" >失效数据</li> 
					<li id="ARIMA_tab3" onClick="setTab('ARIMA',3,4)">预测分析</li> 
					<li id="ARIMA_tab4" onClick="setTab('ARIMA',4,4)" style="display:none">分析结果</li> 
				</ul> 
			</div> 
			<div class="main_tab_content">
				<div id="ARIMA_con1">
					<div class="subtitle">模型简介</div>
					<div class="scrollbox">
						<p>
							ARIMA模型全称为整合自回归移动平均模型（Autoregressive Integrated Moving Aver- age Model）
							是由Box和Jenkins 于20世纪70年代初提出的时间序列预测方法，
							又称之为B-J模型。
							差分自回归滑动平均模型（ARIMA）是非常流行的线性时间序列预测模型之一。
							在ARIMA模型中，
							假设时间序列的将来值是过去的观测值和随即误差的线性函数。
							一个离散的随即过程时间序列<i>Y<sub>t</sub></i>，<i>t</i>=1，2，...，<i>k</i>，
							那么ARIMA(<i>p, d, q</i>) 模型的一般形式如下：
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/ARIMA_1.jpg"></p>
						<p>
							其中<i>X<sub>t</sub></i>原始时间序列<i>Y<sub>t</sub></i>通过若干次的差分得到的平稳序列，
							但每一次差分都会导致原数据信息的部分损失，因此要注意差分的次数。
							例如，
							常用的一阶差分公式为：
							<i>X<sub>t-1</sub></i>=<i>Y<sub>t</sub></i>-<i>Y<sub>t-1</sub></i>，
							非负整数<i>p</i>为自回归阶数，
							<i>φ<sub>i</sub></i>，（<i>i</i>=1，2，...，<i>p</i>）为自回归系数，
							非负整数<i>q</i>为移动平均阶数，
							<i>θ<sub>i</sub></i>，
							（<i>i</i>=1，2，...，
							<i>q</i>）为移动平均系数，
							{<i>ε<sub>t</sub></i>}独立同分布于均值为0，
							方差为<i>σ<sup>2</sup></i>的白噪声过程。
							ARIMA模型可分为以下三种：
						</p>
						<p>1）当 q=0,该模型为AR(p)过程</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/ARIMA_2.jpg"></p>
						<p>2）当p=0,该模型为MA(q)过程</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/ARIMA_3.jpg"></p>
						<p>3）当d=0,该模型为ARMA(p, q)过程</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/ARIMA_4.jpg"></p>
						<p>
							ARIMA模型的建模过程包括：平稳性检验、模型识别、参数估计/定阶和参数/模型检验四个步骤。具体流程图如下：
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/ARIMA_5.jpg"></p>
						<p>
							ARIMA的基本思想是建立在随机过程理论基础上，利用数据之间的连续来建立模型，具有结构简单、
							建模速度快、预测精度高等优点，并且解决了非平稳时间序列的处理问题，非常适合处理随机性和波动性较强的问题。
							模型的具体形式可分为自回归（AR）模型、滑动平均（MA）模型和自回归滑动平均（ARMA）模型，
							究竟是哪种形式可以通过自相关函数和偏相关函数来判定。虽然ARIMA模型在大数据和线性的数据中有较高的预测精度，
							但在处理小的、非线性的数据中的鲁棒性较差。
						</p>
					</div>
				</div>
				<div id="ARIMA_con2" style="display:none">
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
				<div id="ARIMA_con3" style="display:none">
					<div class="subtitle">分析设置</div>
					<div class="setup">
						<form action="../../resultshow/resultDriven.jsp" method="post"
							target="SHOWDATA_ARIMA" name="parameterform" 
							onsubmit="return validate_ARIMA(this,1);">
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
								(设置范围：1-100。 设置模型向后预测的步数)
							</div>
							<div class="parametersetup_title">参数之一：</div>
							<div class="parametersetup_content">
								<input type="text" name="ARIMA_parameter1" 
									value="<%= parameter[0]%>">
									(设置范围：0-1。 )
							</div>
							<div class="parametersetup_title">参数之二：</div>
							<div class="parametersetup_content">
								<input type="text" name="ARIMA_parameter2" 
								value="<%= parameter[1]%>">
								(设置范围：0-1。 )
							</div>
							<div class="parametersetup_title">参数之三：</div>
							<div class="parametersetup_content">
								<input type="text" name="ARIMA_parameter3" 
								value="<%= parameter[2]%>">
								(设置范围：0-1。 )
							</div>
							<div class="parametersetup_title">参数之四：</div>
							<div class="parametersetup_content">
								<input type="text" name="ARIMA_parameter4" 
								value="<%= parameter[3]%>">
								(设置范围：0-1。 )
							</div>
							<div style="text-align:center">
								<input type="hidden" id="model" name="model" value="ARIMA">
								<input type="hidden" id="flag" value="0">
								<input type="hidden" id="current_tab" value="3">
								<input type="button" class="button button-pill button-primary" 
									onClick="saveparameter();" value="保存">
								<input type="submit" class="button button-pill button-primary" value="预测">
							</div>	
  						</form>
					</div>
				</div>
				<div id="ARIMA_con4" style="display:none">
					<iframe name="SHOWDATA_ARIMA" src="../../resultshow/resultDriven.jsp"></iframe>
				</div> 
			</div> 
		</div>
	</body>
</html>

