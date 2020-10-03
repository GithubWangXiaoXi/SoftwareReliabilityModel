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
%>
<%
	
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
		<title>SSA模型</title>
   		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/onload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/mix/validate_SSA_resolve.js" 
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
		<input type="hidden" id="wl" 
				value="<%= inputdata.getlength_train()/2%>">
		<input type="hidden" id="flag" value="0">
		<input type="hidden" id="mergerflag" value="0">
		<input type="hidden" id="current_tab" value="3">
		<form action="../../resultshow/resultMix_Resolve.jsp" method="post"
							target="SHOWDATA_SSA_RESOLVE"
							name="resolve">
			<input type="hidden" name="Combination" value="1">
			<input type="hidden" name="Sequence" value="<%= Sequence%>">
			<input type="hidden" name="resolvename" value="<%= resolvename%>">
			<input type="hidden" name="model" value="<%= model%>">
		</form>
		<div class="titlename">SSA分解模型</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="SSA_tab1" onClick="setTab('SSA',1,5)" class="hover">模型简介</li> 
					<li id="SSA_tab2" onClick="setTab('SSA',2,5)">失效数据</li> 
					<li id="SSA_tab3" onClick="setTab('SSA',3,5)">分解设置</li>
					<li id="SSA_tab4" onClick="setTab('SSA',4,5)" style="display:none">分解结果显示</li>
					<li id="SSA_tab5" onClick="setTab('SSA',5,5)" style="display:none">组合结果显示</li> 
				</ul> 
			</div> 
			<div class="main_tab_content">
				<div id="SSA_con1">
					<div class="subtitle">模型简介</div>
					<div class="scrollbox">
						<p>
							奇异谱分析(Singular Spectrum Analysis， SSA)技术是一种基于统计原理的非参数时间序列分析技术，
							结合了统计学、概率论、动态系统和信号处理理论。
							它可将已知的时间序列分解成为若干个相互独立的子时间序列，
							每个子序列都代表原始序列的某种特征，
							如趋势、周期或者准周期以及噪声。
						</p>
						<p>
							时间序列 ： 窗口长度<i>L</i>， 令<i>K</i>=<i>N</i>-<i>L</i>+1。 
							则可获得如下轨道矩阵：
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Mix/SSA_1.jpg"></p>
						<p>
							显然这个轨道矩阵为Hankel 矩阵，即对于矩阵中对角线上的元素<i>a<sub>i,j</sub></i>，
							<i>a<sub>m,n</sub></i>， 当<i>i</i>+<i>j</i>=<i>m</i>+<i>n</i>时，
							有<i>a<sub>i,j</sub></i>=<i>a<sub>m,n</sub></i>成立。
							我们可以得到协方差矩阵<i>S</i>:
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Mix/SSA_2.jpg"></p>
						<p>
							奇异值分解是矩阵分析中一种强大而简洁的技术。
							通过对协方差矩阵 的进行简单的矩阵运算，
							能够得到它的特征值<i>λ<sub>1</sub></i>，<i>λ<sub>2</sub></i>，...，<i>λ<sub>L</sub></i>
							和对应的正交特征向量<i>U<sub>1</sub></i>，<i>U<sub>2</sub></i>，...，<i>U<sub>L</sub></i>，
							则轨道矩阵的奇异值分解可写为：
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Mix/SSA_3.jpg"></p>
						<p>
							将上式的<i>E<sub>i</sub></i>分成若干互不连接的组，
							即将索引集合{1,2,...,<i>d</i>}分成
							<i>I<sub>1</sub></i>，<i>I<sub>2</sub></i>，...，<i>I<sub>m</sub></i>，
							可将第<i>I</i>个分组表示为：
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Mix/SSA_4.jpg"></p>
						<p>
							在SSA中涉及到的两个待定的参数， 其一为窗口长度<i>L</i>，
							另一个为代表轨道矩阵主体部分特征环的个数<i>r</i>。
							一般来说窗口长度<i>L</i>为<i>N</i>/2，
							但如果时间序列包括一个整数周期<i>t</i>，
							可将<i>L</i>定义为<i>t</i>的整数倍； 一般来说来说，
							选出的<i>r</i>个特征环要能够保证他们的贡献度大于一个阈值如大于90%，剩余为噪声部分的特征环贡献度应较小。
							SSA模型将原始的数据序列分解成若干个能够反映出原始数据特征的序列，
							在这些序列中， 方差贡献度最大的序列具有较为良好的平滑性。
						</p>
					</div>
				</div>
				<div id="SSA_con2" style="display:none">
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
				<div id="SSA_con3" style="display:none">
					<div class="subtitle">分解设置</div>
					<div class="setup">
						<form action="../../resultshow/resultMix_Resolve.jsp" method="post"
							target="SHOWDATA_SSA_RESOLVE"
							onsubmit="return validate_SSA_resolve(this);;">
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
							<div class="parametersetup_title">方差贡献度：</div>
							<div class="parametersetup_content">
								<input type="text" name="SSA_parameter1" 
								value="0.9">
								(设置范围：0-1。主体成分占总体的百分比。贡献度越大，噪声越小。)
							</div>
							<div class="parametersetup_title">窗口长度：</div>
							<div class="parametersetup_content">
								<input type="text" name="SSA_parameter2" 
								value="<%= inputdata.getlength_train()/2%>">
								(设置范围：2-<%= inputdata.getlength_train()/2%>
								。 用于决定分解后子序列的个数)
							</div>
							<div style="text-align:center">
								<input type="hidden" id="model" name="model" value="SSA">
								<input type="submit" class="button button-pill button-primary" value="分解">
							</div>	
  						</form>
					</div>
				</div>
				<div id="SSA_con4" style="display:none">
					<iframe name="SHOWDATA_SSA_RESOLVE" 
					src="../../resultshow/resultMix_Resolve.jsp"></iframe>
				</div>
				<div id="SSA_con5" style="display:none">
					<iframe name="SHOWDATA_SSA_MERGER" 
					src="../../resultshow/resultMix_Merger.jsp"></iframe>
				</div>
			</div>
		</div>
	</body>
</html>