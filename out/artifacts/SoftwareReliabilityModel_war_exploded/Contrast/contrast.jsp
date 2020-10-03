<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<!-- javabean:inputdata 当前使用数据|contrastdata 对比数据集-->
<jsp:useBean id="inputdata" class="system.InputData" scope="session"></jsp:useBean>
<jsp:useBean id="contrastdata" class="system.ContrastData" scope="session"></jsp:useBean>
<%
	int number = contrastdata.getnumber(); //提取比较数据的长度
	int dimension = inputdata.getdimension(); //提取比较数据的维度
	String[] colname = new String[dimension]; //将数据以列的形式提取出来
	for (int i = 0; i < dimension; i++)
	{
		colname[i] = inputdata.getcolname(i + 1);
	}
%>
<html>
	<head>
    	<title>性能对比</title>
       	<link rel="stylesheet" type="text/css" href="../CSS/universal.css" />
		<link rel="stylesheet" type="text/css" href="../CSS/maintab.css" />
		<link rel="stylesheet" type="text/css" href="../CSS/table.css" />
		<link rel="stylesheet" type="text/css" href="../CSS/waitload.css" />
		<link rel="stylesheet" type="text/css" href="../CSS/showtab.css" />
		<link rel="stylesheet" type="text/css" href="../CSS/buttons.css">
		<script type="text/javascript" src="../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../JS/waitload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../JS/button/validate_contrast.js" 
		charset="gb2312"></script>
	</head>
  
	<body>
	  	<div id="loader_container" style="display:none">
			<div id="loader">
				<div align="center">正在处理，请稍后 ...</div>
				<div id="loader_bg">
					<div id="progress"></div>
				</div>
			</div>
		</div>
		<input type="hidden" id="model" value="contrast">
  		<input type="hidden" id="flag" value="0">
  		<input type="hidden" id="current_tab" value="2">
  		<div class="titlename">预测性能对比</div>
  		<div id="main_tab"> 
			<div class="main_tab_menu"> 
				<ul> 
					<li id="contrast_tab1" onClick="setTab('contrast',1,3)" 
					class="hover">预测对比简介</li> 
					<li id="contrast_tab2" onClick="setTab('contrast',2,3)">选择对比模型</li> 
					<li id="contrast_tab3" onClick="setTab('contrast',3,3)" 
					style="display:none">对比结果显示</li> 
				</ul> 
			</div> 
			<div class="main_tab_content"> 
				<div id="contrast_con1">
					<div class="subtitle">预测性能对比</div>
					<div class="scrollbox">
						<p>
							预测性能对比功能是指对于同一组数据集，
							对采用不同模型的预测结果或者是同一模型不同参数的预测结果进行对比分析。
						</p>
						<p>
							具体的过程主要是分别通过各模型所预测出的数据结果与真实数据所保留的预测集进行对比，
							得出各模型的性能参数，从而使用户很清晰地对比出不同模型对于该数据集的预测性能优劣，
							主要从均值误差平方和MSE， 回归曲线方程的相关指数R_Square， 均值误差AE，
							均方百分比误差MSPE这四个性能参数角度去做衡量。
						</p>
					</div>
				</div> 
				<div id="contrast_con2" style="display:none">
				<%	if(inputdata.getlength_test()==0)
					{%>
						<div class="subtitle">无测试集数据，无法对比！！！</div>
				<%	}
					else
					{%>
						<div class="show_tab_menu">
	    				<div style="width:100%;">
	    					<ul>
	    					<%	for(int i=0; i<dimension; i++)
								{%>
									<li id="col_tab<%= String.valueOf(i+1)%>" 
									onClick="setTab('col',<%= String.valueOf(i+1)%>,
									<%= String.valueOf(dimension)%>)" 
									<%if(i==0) {%>class="hover"<%}%>>
									<%= colname[i]%></li>
							<%	}%>
							</ul>
		    			</div>
	    				</div>
		    			<div class="show_tab_content">
						<%	for(int i=0; i<dimension; i++)
							{%>
								<div id="col_con<%= String.valueOf(i+1)%>"
									<%if(i!=0) {%> style="display:none" <%}%>>
									<div class="subtitle"><%= colname[i]%>模型对比</div>
									<div class="scrollbox" align="center" style="height:500px">
										<form action="../resultshow/showcontrast.jsp" 
										method="post" target="SHOWDATA_contrast" 
										onsubmit="return validate_contrast(this);;">
	  				    					<table class="contrast">
	   											<tr>
	   												<th>选择</th>
	  	 											<th>模型名</th>
	  	 											<th>运行时间</th>
	  	 											<th>参数设置</th>
	  	 										</tr>
	  	 									<%	for(int j=0;j<number;j++)
	  	 										{
	  	 											if(contrastdata.getsequence(j)==i+1)
	  	 											{%>
	  	 												<tr>
	  	 													<td>
	  	 														<input type="checkbox" name="select" value="<%= String.valueOf(j)%>">
	  	 													</td>
	  	 													<td><%= contrastdata.getmodelname(j)%></td>
	  	 													<td><%= contrastdata.getdate(j)%></td>
	  	 													<td align="left"><%= contrastdata.getinfo(j)%></td>
	  	 												</tr>
	  	 										<%	}%>	
		 									<%	}%>
	  										</table>
	  										<br>
	  										<input type="hidden" name="model" value="contrast">
	  										<input type="hidden" name="Sequence" value="<%= String.valueOf(i+1)%>">
											<input type="submit" name="contrast_submit" class="button button-pill button-primary" value="对比分析">
	  									</form>
									</div>
								</div>
						<%	}%>
						</div>
				<%	}%>
				</div>
				<div id="contrast_con3" style="display:none">
					<iframe name="SHOWDATA_contrast" src="../resultshow/showcontrast.jsp"></iframe>
				</div> 
			</div> 
		</div> 
	</body>
</html>
