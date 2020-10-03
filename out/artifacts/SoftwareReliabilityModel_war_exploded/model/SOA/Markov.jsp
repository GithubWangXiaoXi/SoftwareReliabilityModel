<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="model.soar.Utils" %>
<%@ page import="system.*" %>
<!-- javabean:inputdata 当前使用数据 | parameterinfo 默认参数信息 -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<%
	//InputData inputdata =new InputData();
	HistoryData historydata=new HistoryData();
	ReadTable rt = new ReadTable();
	ContrastData contrastdata =new ContrastData();
	ArrayList<DataSet> list=rt.getDataSet(1);
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
	int dimension = inputdata.getdimension();	
	double[][] data_train = new double[dimension][];	//将当前数据训练集读入一份到页面
	for(int i=0;i<dimension;i++)
	{
		data_train[i] = inputdata.getdata_train(i+1).clone();
	}
	double[][] temp=Utils.transferMartix(data_train);
	String json=Utils.reverseParse(temp);
	
%>
<html>
	<head>
		<title>SOA服务组合模型</title>
		<link rel="stylesheet" type="text/css" href="../../CSS/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">	
		<script type="text/javascript" src="../../JS/tab.js" charset="utf-8"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="utf-8"></script>
		<script type="text/javascript" src="../../JS/addsubmodel.js" charset="utf-8"></script>
		<script type="text/javascript" src="../../JS/button/combination/validate_Combination.js" 
  		charset="utf-8"></script>
  		<script type="text/javascript" src="../../JS/jquery1.8.3.min.js"></script>
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
		<div class="titlename">服务组合模型</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="DW_tab1" onClick="setTab('DW',1,4)" class="hover">模型简介</li> 
					<li id="DW_tab2" onClick="setTab('DW',2,4)" >失效数据</li> 
					<li id="DW_tab3" onClick="setTab('DW',3,4)">参数设置</li>
					<li id="DW_tab4" onClick="setTab('DW',4,4)" style="display:none">分析结果</li> 
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
					<div class="subtitle">参数设置<button id="fastcommit"class="button button-pill button-primary pull-right"style="margin-right: 150px;">使用当前测试集</button></div>
					<div class="setup" style="height:84%">
						<form id="myform"action="combination.jsp" method="post"
								target="SHOWDATA_DW" onsubmit="return validate_Combination(this);"onkeydown="if(event.keyCode==13){return false;}">
							<div class="parametersetup_title">模型组件个数：</div>
							<div class="parametersetup_content">
								<input style=""type="text" name="snum" value=""id="snum">
										(设置当前服务组合模型的组件个数,点击其他部分输入失效率、状态转移矩阵)
							</div>
							<div id="data-table"style="display:none;">
							
							</div>
							
						
							<div style="text-align:center">
								<input type="hidden" id="model" name="model" value="DW">
								<input type="hidden" id="number" name="number" value="<%=temp.length%>">
								<input type="hidden"  name="prestep" value="2">
								<input type="hidden" id="tdata" name="tdata" value='<%= json%>'>
								<input type="hidden" id="current_tab" value="3">
								<input type="submit" class="button button-pill button-primary" value="预测"id="smit">
							</div>
						</form>
					</div>	
				</div>
				<div id="DW_con4" style="display:none">
					<iframe name="SHOWDATA_DW" src="combination.jsp"></iframe>
				</div>
			</div>		
		</div>
		<script type="text/javascript">
		/* $(function(){
			 $("td").live('click',function(event){
			  //td中已经有了input,则不需要响应点击事件
			  	if($(this).children("input").length > 0)
			   		return false;
			  	var tdObj = $(this);
				  var preText = tdObj.html();
				  //得到当前文本内容
				  var inputObj = $("<input type='text' />");
				  //创建一个文本框元素
				  tdObj.html(""); //清空td中的所有元素
				  inputObj
				   .width(tdObj.width())
				   //设置文本框宽度与td相同
				   .height(tdObj.height())
				   .css({border:"0px",fontSize:"17px",font:"宋体"})
				   .val(preText)
				   .appendTo(tdObj)
				   //把创建的文本框插入到tdObj子节点的最后
				   .trigger("focus")
				   //用trigger方法触发事件
				   .trigger("select");
				  inputObj.keyup(function(event){
				   if(13 == event.which)
				   //用户按下回车
				   {
				    var text = $(this).val();
				    tdObj.html(text);
				   }
				   else if(27 == event.which)
				   //ESC键
				   {
				    tdObj.html(preText);
				   }
				  });
				  //已进入编辑状态后，不再处理click事件
				  inputObj.click(function(){
				   return false;
				  });
				 });
				}); */
			$('#snum').blur(function () {
				//console.log()
				if($('#data-table').css('display')!='none')return;
				//console.log($('#data-table').css('display'))
				if($(this).val()==null||$(this).val()=='')return;
				var num=parseInt($(this).val());
				if(num<=0) {
					alert("请输入有效数据");
					return;
				}
				if(num>12){
					var heightper=(num-12)*7;
					$(".setup").css("height",(95+heightper)+"%")
				}
				if(num>26){
					$(".setup").css("width",(80+(num-26)*3)+"%")
				}
				var html1='<table contenteditable="true" class="table table-bordered"><thead><th>组件编号</th><th>描述信息</th><th>失效率</th>';
				for(var i=1;i<=num;i++){
					html1+='<th>Pi'+i+'</th>';
				}
				html1+='</thead>';
				var tbody='';
				for(var i=0;i<num;i++){
					tbody+='<tr><td><span contenteditable="true">'+(i+1)+'</span></td><td><span contenteditable="true"></span></td><td><span contenteditable="true">0</span></td>';
					for(var j=0;j<num;j++){
						tbody+='<td><span contenteditable="true">0</span></td>';
					}
					tbody+='</tr>';
				}	  
				var html2='</table>';
				$('#data-table').html(html1+tbody+html2).show();
			});
			
			$('#smit').click(function(){
				var set = [];
				$('#data-table tr').each(function() {
				    var row = [];
				    
				    $(this).find('span').each(function() {
				        row.push($(this).text());
				    });
				    
				    set.push(row);
				});
				set.splice(0,1);
				$('#tdata').val(JSON.stringify(set));
				console.log($('#tdata').val())
			});
			$('#fastcommit').click(function () {
					var len=$("#number").val();
					console.log(len);
					
					$("#snum").val(len);
					
					console.log($("#snum").val());
					$('#smit').unbind().click();
				})
		</script>
	</body>
</html>