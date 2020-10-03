<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="system.*" %>
<!-- javabean:inputdata 当前使用数据 | parameterinfo 默认参数信息 -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<%
	String step = parameterinfo.getstep();
	String[] parameter = parameterinfo.getparameter("WEIBULL");
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
    	<title>Weibull模型</title>
    	<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/classic/validate_WEIBULL.js" 
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
		
		
		<div class="titlename">WEIBULL模型</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="WEIBULL_tab1" onClick="setTab('WEIBULL',1,4)" class="hover">模型简介</li> 
					<li id="WEIBULL_tab2" onClick="setTab('WEIBULL',2,4)" >失效数据</li> 
					<li id="WEIBULL_tab3" onClick="setTab('WEIBULL',3,4)">预测分析</li> 
					<li id="WEIBULL_tab4" onClick="setTab('WEIBULL',4,4)"
					style="display:none">分析结果</li> 
				</ul> 
			</div>
			<div class="main_tab_content"> 
				<div id="WEIBULL_con1">
					<div class="subtitle">模型简介</div>
					<div class="scrollbox">
						<p>
							具有 强度函数的NHPP过程，即非齐次泊松过程，经常被用以分析可修复系统的失效模式。
							以极大似然估计的方法为基础，推导出了Weibull过程在可靠性增长领域中的应用。
						</p>
						<p>
							设两个参数的Weibull分布函数是：
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Classic/Weibull_1.jpg"></p>
						<p>
							其中， <i>α</i>和<i>β</i>分别是模型的尺度参数与形状参数。
						</p>
						<p>
							按从小至大的顺序排列：<img src="../../IMAGE/Classic/Weibull_2.jpg">
							，这里不考虑<i>x</i><sub>1</sub>=<i>x</i><sub>1</sub>=...
							<i>x</i><sub>n</sub>的情况，似然函数是：
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Classic/Weibull_3.jpg"></p>
						<p>
							对似然函数方程式两侧取对数，并且分别对两个参数 进行求导数，整理可得：
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Classic/Weibull_4.jpg"></p>
						<p>
							可取<img src="../../IMAGE/Classic/Weibull_5.jpg">
							，然后代入上式，采用迭代法求出参数<i>β</i>。再将<i>β</i>代入上式中求出参数<i>α</i>。
						</p>
					</div>
				</div>
				<div id="WEIBULL_con2" style="display:none">
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
				<div id="WEIBULL_con3" style="display:none">
					<div class="subtitle">分析设置</div>
					<div class="setup">
						<form action="../../resultshow/resultClassic.jsp" method="post"
							target="SHOWDATA_WEIBULL" name="parameterform" 
							onsubmit="return validate_WEIBULL(this,1);">
							<div class="parametersetup_title">失效数据：</div>
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
								<input type="hidden" id="model" name="model" value="WEIBULL">
								<input type="hidden" id="flag" value="0">
								<input type="hidden" id="current_tab" value="3">
								
								<!-- <input type="button" class="button button-pill button-primary" 
								onClick="saveparameter();" value="保存"> -->
								<input type="submit" class="button button-pill button-primary"  value="预测">
							</div>	
  						</form>
					</div> 
				</div>
				<div id="WEIBULL_con4" style="display:none">
					<iframe name="SHOWDATA_WEIBULL" src="../../resultshow/resultClassic.jsp"></iframe>
				</div> 
			</div> 
		</div>	
	</body>
</html>