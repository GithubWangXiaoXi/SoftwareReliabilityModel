<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<!-- javabean:inputdata 当前使用数据 | parameterinfo 默认参数信息 -->
<%@ page import="system.*" %>
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<%
	String step = parameterinfo.getstep();
	String[] parameter = parameterinfo.getparameter("GEP");
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
    	<title>GEP模型</title>
   		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/datadriven/validate_GEP.js" 
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
		<div class="titlename">GEP模型</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="GEP_tab1" onClick="setTab('GEP',1,4)" class="hover">模型简介</li> 
					<li id="GEP_tab2" onClick="setTab('GEP',2,4)" >失效数据</li> 
					<li id="GEP_tab3" onClick="setTab('GEP',3,4)">预测分析</li> 
					<li id="GEP_tab4" onClick="setTab('GEP',4,4)" style="display:none">分析结果</li> 
				</ul> 
			</div> 
			<div class="main_tab_content"> 
				<div id="GEP_con1">
					<div class="subtitle">模型简介</div>
					<div class="scrollbox">
						<p>
							基因表达式编程（Gene Expression Programming , GEP）
							算法是一种基于基因型组和表现型组的新型自适应演化算法，
							它是遗传算法(GA)和遗传程序设计(GP)相结合的产物，
							它集遗传算法和遗传程序设计的优点于一体，
							把个体编码成易于进行遗传操作的固定线性串，
							然后将其表达成长度和形状不同的表达式树（<i>K</i>-表达式）形式。
						</p>
						<p>
							基因表达式编程算法中的每个染色体代表问题的一个解，
							构成染色的基因由终结符和非终结符构成。
							表达式树（ETs）是染色体的表现型，是一个非线性的树形表达形式，
							每个基因作为一个子树在表达式树种存在。
							在GEP中，基因由头部和尾部构成。
							头部由函数符<i>F</i>(如，+,-,*,/+,sin, 等)和终结符<i>T</i>
							（如，程序的输入、常量、变量和无参的函数）构成，尾部只能由终结符构成，
							GEP算法中个体的构成可以用这样一个二元组构成：
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/GEP_1.jpg"></p>
						<p>
							基因头部的长度（<i>h</i>）可由使用者自行确定，
							可在之后使用过程中进行调整。
							当头部的长度确定之后，尾部的长度（<i>t</i>）可表示为：<i>t</i>=
							<i>h</i>(<i>n</i>-1)+1，
							其中<i>n</i>为函数符集中函数符的最大操作数个数。
							假设有一个符号集如下， 
							S<sup>*</sup>={<i>S,*,/,+,-,a,b</i>}，
							其中S为sqrt运算，
							则<i>n</i>=2，
							若令<i>h</i>=7，
							则<i>t</i>=8，
							那个基因总的长度则为7+8=15。
							假设有如下两个基因G1=S*+a+*+aaabbbab，
							G2=*a+*/bSabaaabba并且c“+”作为连接符，
							则个体的表达式树如下：
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/GEP_2.jpg"></p>
						<p>
							GEP与GA和GP在算法上相差不大，
							根据给定问题，
							首先要定义终结点集<i>T</i>和初始函数集<i>F</i>，
							然后确定适应度评价方法
							，并给定运行控制量，
							最后需要确定终止运行的标准。
							进化过程中染色体被表达成表达式树，
							通过一系列遗传操作生成新的个体，
							当遗传代数或适应度值达到预定值则终止进化过程。
							在基因表达式程序设计中，
							染色体通常由多个等长的基因构成，
							且基因个数和基因头部的长度都是预先选定的。
							每一个基因被表达成一个子表达式树，
							子表达式树间相互作用构成更复杂的多子树表达式树，
							这样一些复杂的问题就可以被表示出来了。
							基因表达式程序设计中的遗传操作主要包括选择、变异、变换和重组操作，
							变换操作实际上就是变异操作，
							而重组操作可以看作是交叉操作。
							具体流程图如下：
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/GEP_3.jpg"></p>
						<p>
							基因表达式编程算法借鉴了生物遗传的基因表达规律而提出的，
							综合了GA和GP二者的优点，
							个体编码成易于进行遗传操作的固定线性串，
							然后将其表达成长度和形状不同的表达树形式，
							在遗传算子上引用了前两者所不具备的插串算子和基因重组算子。
							在基因表达式程序设计中，
							终结点集和函数集中元素的选取和遗传程序设计没有太大的区别，
							但将基因的构成分为头部和尾部两部分，
							头部元素既可以是终结点集中的元素，
							也可以是函数集中的元素，
							而尾部元素只能限制在终结点集中的元素。
							GEP很大部分是被用于函数发现，
							但已有学者将其引进了软件可靠性领域中并取得了不错的效果。
						</p>
					</div>
				</div>
				<div id="GEP_con2" style="display:none">
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
				<div id="GEP_con3" style="display:none">
					<div class="subtitle">分析设置</div>
					<div class="setup" style="height:85%;overflow:auto;">
						<form action="../../resultshow/resultDriven.jsp" method="post"
								target="SHOWDATA_GEP" name="parameterform" 
							onsubmit="return validate_GEP(this,1);">
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
							<div class="parametersetup_title">种群大小：</div>
							<div class="parametersetup_content">
								<input type="text" name="GEP_parameter1" 
								value="<%= parameter[0]%>">
									(设置范围：30-100。 设置种群中包含染色体的个数 )
							</div>
							<div class="parametersetup_title">重构维数：</div>
							<div class="parametersetup_content">
								<input type="text" name="GEP_parameter2" 
								value="<%= parameter[1]%>">
									(设置范围：3-10。 设置相空间重构的维数)
							</div>
							<div class="parametersetup_title">基因头部长度：</div>
							<div class="parametersetup_content">
								<input type="text" name="GEP_parameter3" 
								value="<%= parameter[2]%>">
								(设置范围：5-15。 设置基因头部的长度h，基因的总长度为2*h+1)
							</div>
							<div class="parametersetup_title">基因数量：</div>
							<div class="parametersetup_content">
								<input type="text" name="GEP_parameter4" 
								value="<%= parameter[3]%>">
								(设置范围：2-10。 设置一个染色体重包含基因的个数)
							</div>
							<div class="parametersetup_title">基因变异概率：</div>
							<div class="parametersetup_content">
								<input type="text" name="GEP_parameter5" 
								value="<%= parameter[4]%>">
									(设置范围：0-1。 设置每代中基因发生变异的概率)
							</div>
							<div class="parametersetup_title">IS迁移概率：</div>
							<div class="parametersetup_content">
								<input type="text" name="GEP_parameter6" 
								value="<%= parameter[5]%>">
									(设置范围：0-1。 设置每代中染色体发生IS迁移的概率)
							</div>
							<div class="parametersetup_title">RIS迁移概率：</div>
							<div class="parametersetup_content">
								<input type="text" name="GEP_parameter7" 
								value="<%= parameter[6]%>">
								(设置范围：0-1。 设置每代中染色体发生RIS迁移的概率)
							</div>
							<div class="parametersetup_title">单点重组概率：</div>
							<div class="parametersetup_content">
								<input type="text" name="GEP_parameter8" 
								value="<%= parameter[7]%>">
									(设置范围：0-1。 设置每代中染色体发生单点重组的概率)
							</div>
							<div class="parametersetup_title">双点重组概率：</div>
							<div class="parametersetup_content">
								<input type="text" name="GEP_parameter9" 
								value="<%= parameter[8]%>">
									(设置范围：0-1。 设置每代中染色体发生双点重组的概率)
							</div>
							<div class="parametersetup_title">基因重组概率：</div>
							<div class="parametersetup_content">
								<input type="text" name="GEP_parameter10" 
								value="<%= parameter[9]%>">
									(设置范围：0-1。 设置每代中染色体发生基因重组的概率)
							</div>
							<div class="parametersetup_title">训练代数：</div>
							<div class="parametersetup_content">
								<input type="text" name="GEP_parameter11" 
								value="<%= parameter[10]%>">
								(设置范围：10-100000。 当训练到指定代数，终止训练)
							</div>
							<div class="parametersetup_title">阈值：</div>
							<div class="parametersetup_content">
								<input type="text" name="GEP_parameter12" 
								value="<%= parameter[11]%>">
									(设置范围：0-100。 当阈值小于指定值，终止训练)
							</div>
							<div style="text-align:center">
								<input type="hidden" id="model" name="model" value="GEP">
								<input type="hidden" id="flag" value="0">
								<input type="hidden" id="current_tab" value="3">
								<input type="button" class="button button-pill button-primary" 
									onClick="saveparameter();" value="保存">
							<input type="submit" class="button button-pill button-primary" value="预测">
							</div>	
  						</form>
  					</div>
				</div> 
				<div id="GEP_con4" style="display:none">
					<iframe name="SHOWDATA_GEP" src="../../resultshow/resultDriven.jsp"></iframe>
				</div> 
			</div> 
		</div>
	</body>
</html>