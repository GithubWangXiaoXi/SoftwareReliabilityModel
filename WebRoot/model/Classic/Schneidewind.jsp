<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="system.*" %>
<!-- javabean:inputdata 当前使用数据 | parameterinfo 默认参数信息 -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<%
	String step = parameterinfo.getstep();
	String[] parameter = parameterinfo.getparameter("SCHNEIDEWIND");
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
    	<title>Schneidewind模型</title>
    	<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/classic/validate_SCHNEIDEWIND.js" 
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
		
		
		<div class="titlename">SCHNEIDEWIND模型</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="SCHNEIDEWIND_tab1" onClick="setTab('SCHNEIDEWIND',1,4)" class="hover">模型简介</li> 
					<li id="SCHNEIDEWIND_tab2" onClick="setTab('SCHNEIDEWIND',2,4)" >失效数据</li> 
					<li id="SCHNEIDEWIND_tab3" onClick="setTab('SCHNEIDEWIND',3,4)">预测分析</li> 
					<li id="SCHNEIDEWIND_tab4" onClick="setTab('SCHNEIDEWIND',4,4)" style="display:none">分析结果</li> 
				</ul> 
			</div>
			<div class="main_tab_content"> 
				<div id="SCHNEIDEWIND_con1">
					<div class="subtitle">模型简介</div>
					<div class="scrollbox">
						<p>
							软件的<i>λ</i>(<i>t</i>)值大时，缺陷容易暴露，因此
							<img src="../../IMAGE/Classic/Schneidewind_1.jpg"><i>λ</i>(<i>t</i>)
							应该负的多一些。
							因此，在时间不是非常大的时间区间中，Schneidewind假设
							 <img src="../../IMAGE/Classic/Schneidewind_1.jpg"><i>λ</i>(<i>t</i>)
							 =-<i>βλ</i>(<i>t</i>)，其解为<i>λ</i>(<i>t</i>)=
							 <i>α</i>e<sup>-<i>βt</i></sup>，在Schneidewind模型中，
							 将时间区间从<i>t</i>=0起分为等长的间隔，第i区间内的<i>λ<sub>t</sub></i>)= ，
							 -<i>βλ</i>(<i>t</i>)，所以在第<i>k</i>个区间内
						</p>
							 <p style="text-align:center;"><img src="../../IMAGE/Classic/Schneidewind_2.jpg">
						</p>
						<p>
							于是，可以得到似然函数：
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Classic/Schneidewind_3.jpg">
						<p>
							<i>α</i>和<i>β</i>的最大似然估计满足
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Classic/Schneidewind_4.jpg">
						<p>
							最后，可以求出：
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Classic/Schneidewind_5.jpg">
					</div>
				</div>
				<div id="SCHNEIDEWIND_con2" style="display:none">
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
				<div id="SCHNEIDEWIND_con3" style="display:none">
					<div class="subtitle">分析设置</div>
					<div class="setup">
						<form action="../../resultshow/resultClassic.jsp" method="post"
							target="SHOWDATA_SCHNEIDEWIND" name="parameterform" 
							onsubmit="return validate_SCHNEIDEWIND(this,1);">
							<div class="parametersetup_title">失效数据：</div>
							<div class="parametersetup_content">
								<select name="Sequence"style="height:30px;width:200px;font-size:18px">
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
							<div class="parametersetup_title">模型精度ex：</div>
							<div class="parametersetup_content">
								<input type="text" name="SCHNEIDEWIND_parameter1" 
								value="<%= parameter[0]%>"style="height:30px;width:200px;font-size:18px">
								(设置范围：0-1。 )
							</div>
							<div class="parametersetup_title">模型精度ey：</div>
							<div class="parametersetup_content">
								<input type="text" name="SCHNEIDEWIND_parameter2" 
								value="<%= parameter[1]%>"style="height:30px;width:200px;font-size:18px">
								(设置范围：0-1。 )
							</div>
							<div style="text-align:center">
								<input type="hidden" id="model" name="model" value="SCHNEIDEWIND">
								<input type="hidden" id="flag" value="0">
								<input type="hidden" id="current_tab" value="3">
								
								<input type="button" class="button button-pill button-primary"  
								onClick="saveparameter();" value="保存">
								<input type="submit" class="button button-pill button-primary"  value="预测">
							</div>	
  						</form>
					</div> 
				</div>
				<div id="SCHNEIDEWIND_con4" style="display:none">
					<iframe name="SHOWDATA_SCHNEIDEWIND" src="../../resultshow/resultClassic.jsp"></iframe>
				</div> 
			</div> 
		</div>	
	</body>
</html>