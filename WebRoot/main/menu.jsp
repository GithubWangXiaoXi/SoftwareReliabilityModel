<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
	<meta charset="UTF-8">
	<title>树型菜单</title>
	<style>

	/*简单粗暴重置默认样式===============================*/
		*{ margin: 0; padding: 0; }
		img{border:0;}
        ul,li{list-style-type:none;}
		a {color:#00007F;text-decoration:none;}
		a:hover {color:#bd0a01;text-decoration:underline;}
		.treebox{ width: 280px; margin: 0 auto; background-color:#1a6cb9; }
		.menu{ overflow: auto; border-color: #ddd; border-style: solid ; border-width: 0 1px 1px ; }
		/*第一层*/
		.menu li.level1>a{ 
			display:block;
			height: 45px;
			line-height: 45px;
			color: #fff;
			padding-left: 50px;
			border-bottom: 1px solid #000; 
			font-size: 20px;
			position: relative;
		 }
		 .menu li.level1 a:hover{ text-decoration: none;background-color:#326ea5;   }
		 .menu li.level1 a.current{ background: #0f4679; }

		/*============修饰图标*/
		 .ico{ width: 20px; height: 20px; display:block;   position: absolute; left: 20px; top: 10px; background-repeat: no-repeat; background-image: url(../IMAGE/ico1.png); }

		 /*============小箭头*/
		 .level1 i{ width: 20px; height: 10px; background-image:url(../IMAGE/arrow.png); background-repeat: no-repeat; display: block; position: absolute; right: 20px; top: 20px; }
		.level1 i.down{ background-position: 0 -10px; }

		 .ico1{ background-position: 0 0; }
		 .ico2{ background-position: 0 -20.5px; }
		 .ico3{ background-position: 0 -37.5px; }
		 .ico4{ background-position: 0 -56px; }
         .ico5{ background-position: 0 -76.6px; }
         .ico6{ background-position: 0 -96px; }
         .ico7{ background-position: 0 -117px; }
		 /*第二层*/
		 .menu li ul{ overflow: hidden; }
		 .menu li ul.level2{ display: none;background: #0f4679; }
		 .menu li ul.level2 li a{
		 	display: block;
			height: 45px;
			line-height: 45px;
			color: #fff;
			text-indent: 60px;
			/*border-bottom: 1px solid #ddd; */
			font-size: 18px;
		 }

	</style>
</head>
<body>
	<div class="treebox">
		<ul class="menu">
			<li class="level1">
				<a href="#none"><em class="ico ico1"></em>基础数据<i class="down"></i></a>
				<ul class="level2">
					<li><a href="../datainfo/inputdata/input.jsp" target="MAIN">数据导入</a></li>
					<li><a href="../datainfo/parameterinfo/parameter.jsp" target="MAIN">模型参数</a></li>
					<!-- <li><a href="../datainfo/showdata/show.jsp" target="MAIN">失效数据</a></li> -->
				</ul>
			</li>
			<li class="level1">
				<a href="#none"><em class="ico ico3"></em>经典可靠性模型<i></i></a>
				<ul class="level2">
					<li><a href="../model/Classic/J_M.jsp" target="MAIN">JM 模型</a></li>
					<li><a href="../model/Classic/G_O.jsp" target="MAIN">GO 模型</a></li>	
					<li><a href="../model/Classic/M_O.jsp" target="MAIN">MO 模型</a></li>										
					<li><a href="../model/Classic/DUANE.jsp" target="MAIN">Duane 模型</a></li>
					<li><a href="../model/Classic/GammaSRM.jsp" target="MAIN">Gamma 模型</a></li>
					<li><a href="../model/Classic/Weibull.jsp" target="MAIN">Weibull 模型</a></li>
					<!-- <li><a href="../model/Classic/LogLogisticSRM.jsp" target="MAIN">LogLogistic 模型</a></li> -->
					<li><a href="../model/Classic/ExponentialSRM.jsp" target="MAIN">Exponential 模型</a></li>		
					<li><a href="../model/Classic/Schneidewind.jsp" target="MAIN">Schneidewind 模型</a></li>	
					<li><a href="../model/Classic/LogNormalSRM.jsp" target="MAIN">LogNormal 模型</a></li>
					<!-- <li><a href="../model/Classic/ParetoSRM.jsp" target="MAIN">Pareto 模型</a></li>	 -->			
					<!-- <li><a href="../model/Classic/TruncatedExtremeValueMaxSRM.jsp" target="MAIN">TrunExValMax 模型</a></li>					
					<li><a href="../model/Classic/TruncatedExtremeValueMinSRM.jsp" target="MAIN">TrunExValMin 模型</a></li>
					<li><a href="../model/Classic/LogExtremeValueMaxSRM.jsp" target="MAIN">LogExValMax 模型</a></li>
					<li><a href="../model/Classic/LogExtremeValueMinSRM.jsp" target="MAIN">LogExValMin 模型</a></li>		
					<li><a href="../model/Classic/TruncatedLogisticSRM.jsp" target="MAIN">TrunLogistic 模型</a></li>		
					<li><a href="../model/Classic/TruncatedNormalSRM.jsp" target="MAIN">TrunNormal 模型</a></li>	 -->						
				</ul>
			</li>
			<li class="level1">
				<a href="#none"><em class="ico ico4"></em>人工智能模型<i></i></a>
				<ul class="level2">
					<li><a href="../model/Data-driven/BPN.jsp" target="MAIN">BPN 模型</a></li>
					<li><a href="../model/Data-driven/RBFN.jsp" target="MAIN">RBF 模型</a></li>
					<li><a href="../model/Data-driven/SVM.jsp" target="MAIN">SVM 模型</a></li>
					<li><a href="../model/Data-driven/GEP.jsp" target="MAIN">GEP 模型</a></li>
					<li><a href="../model/Data-driven/BOOST.jsp" target="MAIN">提升模型</a></li>
					<!-- <li><a href="../model/Data-driven/DL.jsp" target="MAIN">DeepLearning 模型</a></li>	 -->						
				</ul>
			</li>
			<li class="level1">
				<a href="#none"><em class="ico ico2"></em>时间序列模型<i></i></a>
				<ul class="level2">
					<li><a href="../model/Data-driven/GM.jsp" target="MAIN">GM 模型</a></li>					
					<li><a href="../model/Data-driven/ARIMA.jsp" target="MAIN">ARIMA 模型</a></li>			
					<li><a href="../model/Mix/SSA.jsp" target="MAIN">奇异谱分解模型</a></li>
					<li><a href="../model/Mix/EMD.jsp" target="MAIN">经验模态分解模型</a></li>
					<li><a href="../model/Mix/WAVE.jsp" target="MAIN">小波分解模型</a></li>
					<li><a href="../model/Mix/LN.jsp" target="MAIN">残差分解模型</a></li>
				</ul>
			</li>
			<li class="level1">
				<a href="#none"><em class="ico ico5"></em>组合加权模型<i></i></a>
				<ul class="level2">
					<li><a href="../model/Combination/EW.jsp" target="MAIN">等权重模型</a></li>
					<li><a href="../model/Combination/LW.jsp" target="MAIN">线性加权模型</a></li>
					<li><a href="../model/Combination/DW.jsp" target="MAIN">动态加权模型</a></li>
					<li><a href="../model/Combination/BCM.jsp" target="MAIN">贝叶斯加权模型</a></li>
				</ul>
			</li>
			<li class="level1">
				<a href="#none"><em class="ico ico3"></em>SOA可靠性模型<i></i></a>
				<ul class="level2">
					<li><a href="../model/SOA/Evaluate.jsp" target="MAIN">单服务度量模型</a></li>
					<li><a href="../model/SOA/ServicePool.jsp" target="MAIN">服务池容错模型</a></li>
					<li><a href="../model/SOA/Markov.jsp" target="MAIN">Markov组合模型</a></li>
<!-- 					<li><a href="../model/Combination/BCM.jsp" target="MAIN">贝叶斯加权模型</a></li>
 -->				</ul>
			</li>
            <li class="level1">
				<a href="#none"><em class="ico ico6"></em>模型对比分析<i></i></a>
				<ul class="level2">
					<li><a href="../Contrast/PLR.jsp" target="MAIN">PLR对比分析</a></li>
					<li><a href="../Contrast/contrast.jsp" target="MAIN">性能对比分析</a></li>
				</ul>
			</li>
			<li class="level1">
				<a href="#none"><em class="ico ico7"></em>系统管理<i></i></a>
				<ul class="level2">
					<li><a href="../datainfo/showdata/usermanager1.jsp" target="MAIN">用户管理</a></li>
				</ul>
			</li>
		</ul>
	</div>
	<!-- 引入 jQuery -->
<script src="../JS/jquery1.8.3.min.js" type="text/javascript"></script>
<script src="../JS/easing.js"></script>
<script>
//等待dom元素加载完毕.
	$(function(){
		$(".treebox .level1>a").click(function(){
			 var parent = $(this).parent().parent();//获取当前页签的父级的父级
			 var labeul =$(this).parent("li").find(">ul")	 
             if ($(this).parent().hasClass('open') == false) {
                //展开未展开
                   $(this).find('i').addClass('down');   //小箭头向下样式
				   parent.find('ul').slideUp(300);
				   parent.find("li").removeClass("open")
				   parent.find('li a').removeClass("active").find(".arrow").removeClass("open")
                  $(this).parent("li").addClass("open").find(labeul).slideDown(300);
				  $(this).addClass("active").find(".arrow").addClass("open")
            }else{
				 $(this).parent("li").removeClass("open").find(labeul).slideUp(300);
				 $(this).parent('i').removeClass('down');
				  if($(this).parent().find("ul").length>0){
					$(this).removeClass("active").find(".arrow").removeClass("open")
					 $(this).find('i').removeClass('down');   //小箭头向下样式
				  }else{
					$(this).addClass("active") 
				  }
            }

		});
	})
</script>

</body>

</html>