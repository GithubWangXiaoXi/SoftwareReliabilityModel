<%@ page language="java" import="java.util.*,system.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<!-- javabean:inputdata 当前使用数据 -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="resolve" class="system.Resolve" scope="page"></jsp:useBean>
<% 
	if(request.getParameter("resolveflag") != null)
	{
		String select[] = request.getParameterValues("select");
		resolve.setselect(select);
	}
	String model = request.getParameter("model");
	String resolveflag = request.getParameter("resolveflag");
	String Sequence = request.getParameter("Sequence");
	String resolvename = request.getParameter("resolvename");

	
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
		<title>EMD模型</title>
   		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/onload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/mix/validate_EMD_resolve.js" 
  		charset="gb2312"></script>
	</head>
  
  	<body onload="onload_resolve(<%= resolveflag%>)">
		<div id="loader_container" style="display:none">   <!-- 执行等待条 -->
			<div id="loader">
				<div align="center">正在执行，请稍后 ...</div>
				<div id="loader_bg">
					<div id="progress"></div>
				</div>
			</div>
		</div>
		<input type="hidden" id="flag" value="0">
		<input type="hidden" id="mergerflag" value="0">
		<input type="hidden" id="current_tab" value="3">
		<form action="../../resultshow/resultMix_Resolve.jsp" method="post"
							target="SHOWDATA_EMD_RESOLVE"
							name="resolve">
			<input type="hidden" name="Combination" value="1">
			<input type="hidden" name="Sequence" value="<%= Sequence%>">
			<input type="hidden" name="resolvename" value="<%= resolvename%>">
			<input type="hidden" name="model" value="<%= model%>">
		</form>
		<div class="titlename">EMD分解模型</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="EMD_tab1" onClick="setTab('EMD',1,5)" class="hover">模型简介</li> 
					<li id="EMD_tab2" onClick="setTab('EMD',2,5)">失效数据</li> 
					<li id="EMD_tab3" onClick="setTab('EMD',3,5)">分解设置</li>
					<li id="EMD_tab4" onClick="setTab('EMD',4,5)" style="display:none;">分解结果显示</li>
					<li id="EMD_tab5" onClick="setTab('EMD',5,5)" style="display:none;">组合结果显示</li> 
				</ul> 
			</div> 
			<div class="main_tab_content">
				<div id="EMD_con1">
					<div class="subtitle">模型简介</div>
					<div class="scrollbox">
						<p>
							经验模态分解（Empirical Model Decomposition, EMD）是一种基于信号局部特征的信号分解方法。
							该方法吸取了小波变换多分辨的优势，
							同时克服了小波变换中需选取小波基与确定分解尺度的困难，
							因此更适于非线性、非平稳信号分析，
							是一种自适应的信号分解方法，
							已被成功应用于诸多研究领域。
							经验模态分解作为一种新的时频分析方法，
							从本质上讲是对一个信号进行平稳化处理，
							其结果是将信号中不同尺度的波动或趋势逐级分解开来，
							产生一系列具有不同特征尺度的数据序列，
							每一个序列代表一个本征模式函数IMF(Intrinsic Mode Function)。
							分解出的各个IMF分量突出了数据的局部特征对其进行分析可以更准确有效地把握原始数据的特征信息。
							本征模态函数必须满足两个条件：
						</p>
						<p>①极值点与过零点数目必须相等或至多相差一点；</p>
						<p>
							②在任意点由局部极大值点构成的包络线与局部极小值点构成的包络线的平均值为零。
							数据序列<i>x</i>(<i>t</i>)的经验模态分解步骤如下：
						</p>
						<p>1)找出x(t)的所有局部极大值点和局部极小值点；</p>
						<p>
							2)对所有局部极大值点和局部极小值点分别用三次样条函数拟合出数据序列的上、下包络线
							<i>u<sub>0</sub></i>(<i>t</i>)和<i>v<sub>0</sub></i>(<i>t</i>)；
						</p>
						<p>	3)记上、下包络线的平均包络线为<i>m<sub>0</sub></i>(<i>t</i>):</p>
						<p style="text-align:center;"><img src="../../IMAGE/Mix/EMD_1.jpg"></p>
						<p>
							记原数据序列<i>x</i>(<i>t</i>)与<i>m<sub>0</sub></i>(<i>t</i>)之差为：
							<i>h<sub>0</sub></i>(<i>t</i>)=
							<i>x</i>(<i>t</i>)-<i>m<sub>0</sub></i>(<i>t</i>)。
						</p>
						<p>
							4)判断<i>h<sub>0</sub></i>(<i>t</i>)是否满足IMF的两条性质。
							若满足，则<i>h<sub>0</sub></i>(<i>t</i>)为IMF；
							否则，记<i>h<sub>0</sub></i>(<i>t</i>)为<i>x</i>(<i>t</i>)，
							重复步骤1)-3)，
							直到得到一个IMF，
							记为<i>c<sub>1</sub></i>(<i>t</i>)。
						</p>
						<p>
							5)记<i>r<sub>1</sub></i>(<i>t</i>)=
							<i>x</i>(<i>t</i>)-<i>c<sub>1</sub></i>(<i>t</i>)为新的数据序列，
							重复步骤1)~4)，
							得到第二个IMF，
							记为<i>c<sub>2</sub></i>(<i>t</i>)，
							这样一直重复下去直到余项<i>r<sub>n</sub></i>(<i>t</i>)
							是一个单调数据序列或<i>r<sub>n</sub></i>(<i>t</i>)的值小于预先给定的阈值，
							分解结束。
						</p>
						<p>
							这样，
							最终可得到<i>n</i>个IMFs<i>c<sub>1</sub></i>(<i>t</i>),
							<i>c<sub>2</sub></i>(<i>t</i>),...,<i>c<sub>n</sub></i>(<i>t</i>)，
							余项为<i>c<sub>n</sub></i>(<i>t</i>)。
							因此，原始数据序列<i>x</i>(<i>t</i>)可表示为：
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Mix/EMD_2.jpg"></p>
						<p>
							非平稳的失效数据序列经过EMD分解以后，
							各IMF分量都基本趋于平稳，
							这对预测是有利的。
							而且每一IMF分量都是对软件失效样本数据特征的一种真实反应，
							通过对失效数据序列的各个特征分别进行预测处理，
							然后再对各预测结果分量进行重构，
							就可以得到更加理想的预测效果。
						</p>
					</div>
				</div>
				<div id="EMD_con2" style="display:none">
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
				<div id="EMD_con3" style="display:none">
					<div class="subtitle">分解设置</div>
					<div class="setup">
						<form action="../../resultshow/resultMix_Resolve.jsp" method="post"
							target="SHOWDATA_EMD_RESOLVE"
							onsubmit="return validate_EMD_resolve(this);;">
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
							<div class="parametersetup_title">包络线平均值：</div>
							<div class="parametersetup_content">
								<input type="text" name="EMD_parameter1" value="10.0">
								(设置范围：大于0。控制经验模态分解收敛的快慢，值越大收敛越快。 )
							</div>
							<div class="parametersetup_title">最大分解个数：</div>
							<div class="parametersetup_content">
								<input type="text" name="EMD_parameter2" value="8">
								(设置范围：2-9。分解个数的上限值，如果超过该值，则停止分解。 )
							</div>
							<div style="text-align:center">
								<input type="hidden" id="model" name="model" value="EMD">
								<input type="submit" class="button button-pill button-primary" value="分解">
							</div>	
  						</form>
					</div>
				</div>
				<div id="EMD_con4" style="display:none">
					<iframe name="SHOWDATA_EMD_RESOLVE" 
					src="../../resultshow/resultMix_Resolve.jsp"></iframe>
				</div>
				<div id="EMD_con5" style="display:none">
					<iframe name="SHOWDATA_EMD_MERGER" 
					src="../../resultshow/resultMix_Merger.jsp"></iframe>
				</div>	
			</div>
		</div>
	</body>
</html>
