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
		<title>WAVE模型</title>
   		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/onload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/mix/validate_WAVE_resolve.js" 
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
							target="SHOWDATA_WAVE_RESOLVE"
							name="resolve">
			<input type="hidden" name="Combination" value="1">
			<input type="hidden" name="Sequence" value="<%= Sequence%>">
			<input type="hidden" name="resolvename" value="<%= resolvename%>">
			<input type="hidden" name="model" value="<%= model%>">
		</form>
		<div class="titlename">小波分解模型</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="WAVE_tab1" onClick="setTab('WAVE',1,5)" class="hover">模型简介</li> 
					<li id="WAVE_tab2" onClick="setTab('WAVE',2,5)">失效数据</li> 
					<li id="WAVE_tab3" onClick="setTab('WAVE',3,5)">分解设置</li>
					<li id="WAVE_tab4" onClick="setTab('WAVE',4,5)" style="display:none;">分解结果显示</li>
					<li id="WAVE_tab5" onClick="setTab('WAVE',5,5)" style="display:none;">组合结果显示</li> 
				</ul> 
			</div> 
			<div class="main_tab_content">
				<div id="WAVE_con1">
				<div class="subtitle" style="top-margin:2mm">模型简介</div>
					<div class="scrollbox">
						<p>
							小波分解作为能随频率的变化自动调整分析窗大小的分析工具，
							自80年代中期以来得到了迅猛的发展，
							并在信号处理、计算机视觉、图像处理、语音分析与合成等众多的领域得到应用。
						</p>
						<p>
						傅里叶变换的基本方程是sin和cos，小波变换的基本方程是小波函数(basic wavelet)，不同的小波在波形上有较大的差异，
						相似的小波构成一个小波族(family)。小波具有这样的局部特性:只有在有限的区间内取值不为0。这个特性可以很好地用于表示带有尖锐， 
						不连续的信号。
						</p>
						<p>
							从信号处理的角度来讲， 小波是强有力地时频处理工具，
							是在克服傅里叶变换缺点的基础上发展而来的；
							从数学的角度来讲，
							它是一个自变量为时间<i>t</i>的函数<i>f</i>(<i>t</i>)。
							因为信号时能量有限的，即
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Mix/WAVE_1.jpg"></p>
												<p>
						小波变换<i>a=W<sup>T</sup>f</i>
						</p>
						<p>
						其中 <i>a</i>表示变换得到的小波系数，<i>W</i>是正交矩阵。<i>f</i> 是输入信号。
						</p>
						<p>
						特定的小波函数（basic wavelet）由一组特定的小波滤波系数(wavelet filter coefficients)构成。
						当选定了小波函数，其对应的那组小波滤波器系数就知道。用小波滤波器系数构造不同维度的低通滤波器和高通滤波器
						（下面的例子中W就是由这些系数构造出来的）。低通滤波器可以看作为一个平滑滤波器(smoothing filter)。
						这两个滤波器，低通和高通滤波器，又分别被称为尺度(scaling)和小波滤波器(wavelet filter)。
						一旦定义好了这两个滤波器，通过递归分解算法(也称为金字塔算法(pyramid algorithm),树算法(tree algorithm)
						将得到水平多分辨率表示的信号。
						</p>
						<p>
						树算法：原始信号通过低通滤波器得到低频系数 (approximate coefficients), 通过高通滤波器得到高频系数
						（detail coefficients）。把第一层的低频系数作为信号输入，又得到一组approximate coefficients和detail
						 coefficients。再把得到的approximate coefficients作为信号输入，得到第二层的approximate
						  coefficients和detail coefficients。以此类推，直到满足设定的分级等级,最大的分解等级为<i>log<sub>2</sub></i><i>N</i>。
						  用数学表达就是：
						原始信号可看做0级低频系数 <i>a<sub>0</sub> = ( f<sub>0</sub>, f<sub>1</sub>, ..., f<sub>n</sub> )</i>; 那么<i>a<sup>m</sup>=G*a<sup>m-1</sup>, d<sup>m</sup> = H*a<sup>m-1</sup>,G, H</i> 分别表示低通滤波器和高通滤波器，用矩阵表示，
                                                                                   则信号的重构如下：
						</p>
                    	<p style="text-align:center;"><img src="../../IMAGE/Mix/WAVE_2.jpg"></p>
					</div>
				</div>
				<div id="WAVE_con2" style="display:none">
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
				<div id="WAVE_con3" style="display:none">
					<div class="subtitle">分解设置</div>
					<div class="setup">
						<form action="../../resultshow/resultMix_Resolve.jsp" method="post"
							target="SHOWDATA_WAVE_RESOLVE"
							onsubmit="return validate_WAVE_resolve(this);;">
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
							<div class="parametersetup_title">分解维数：</div>
							<div class="parametersetup_content">
								<input type="text" name="WAVE_parameter1" value="6">
								(设置范围：2-10。 )
							</div>
							<div class="parametersetup_title">参数之二：</div>
							<div class="parametersetup_content">
								<input type="text" name="WAVE_parameter2" value="0.2">
								(设置范围：0-1。 )
							</div>
							<div style="text-align:center">
								<input type="hidden" id="model" name="model" value="WAVE">
								<input type="submit" class="button button-pill button-primary" value="分解">
							</div>	
  						</form>
					</div>
				</div>
				<div id="WAVE_con4" style="display:none">
					<iframe name="SHOWDATA_WAVE_RESOLVE" 
					src="../../resultshow/resultMix_Resolve.jsp"></iframe>
				</div>
				<div id="WAVE_con5" style="display:none">
					<iframe name="SHOWDATA_WAVE_MERGER" 
					src="../../resultshow/resultMix_Merger.jsp"></iframe>
				</div>
			</div>
		</div>
	</body>
</html>