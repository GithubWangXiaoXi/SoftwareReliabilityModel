<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page contentType="text/html;charset= utf-8"%>
<!-- javabean:parameterinfo 默认参数信息 -->
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="session"></jsp:useBean>
<%
	String[] parameter;		//用于在当前页面暂存模型默认参数
	String flag = request.getParameter("flag");	//flag标志，用于判断是否是上个页面跳转到此页面
 %>

<html>
	<head>
		<title>默认参数信息</title>
    	<link rel="stylesheet" type="text/css" href="../../CSS/universal.css" />
  		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css" />
  		<link rel="stylesheet" type="text/css" href="../../CSS/table.css" />
  		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css"> 
  		<script type="text/javascript" src="../../JS/onload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/modifyparameter.js" 
		charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/button/datadriven/validate_BPN.js" 
		charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/button/datadriven/validate_CPHSRM.js" 
		charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/button/datadriven/validate_RBFN.js" 
		charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/button/datadriven/validate_GEP.js" 
		charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/button/datadriven/validate_GM.js" 
		charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/button/datadriven/validate_SVM.js" 
		charset="gb2312"></script>
		<!-- <script type="text/javascript" src="../../JS/button/datadriven/validate_HyperErlangSRM.js" 
		charset="gb2312"></script> -->
		<script type="text/javascript" src="../../JS/button/datadriven/validate_ARIMA.js" 
		charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/button/classic/validate_JM.js" 
		charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/button/classic/validate_MO.js" 
		charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/button/classic/validate_GO.js" 
		charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/button/classic/validate_WEIBULL.js" 
		charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/button/classic/validate_DUANE.js" 
		charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/button/classic/validate_GammaSRM.js" 
		charset="utf-8"></script>
		<!-- <script type="text/javascript" src="../../JS/button/classic/validate_LogLogisticSRM.js" 
		charset="gb2312"></script> -->
		<script type="text/javascript" src="../../JS/button/classic/validate_SCHNEIDEWIND.js" 
		charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/button/classic/validate_ExponentialSRM.js" 
		charset="gb2312"></script>
		<!-- <script type="text/javascript" src="../../JS/button/classic/validate_TruncatedExtremeValueMaxSRM.js" 
		charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/button/classic/validate_TruncatedExtremeValueMinSRM.js" 
		charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/button/classic/validate_TruncatedLogisticSRM.js" 
		charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/button/classic/validate_TruncatedNormalSRM.js" 
		charset="gb2312"></script> -->
		<script type="text/javascript" src="../../JS/button/classic/validate_LogNormalSRM.js" 
		charset="gb2312"></script>
		<!-- <script type="text/javascript" src="../../JS/button/classic/validate_LogExtremeValueMaxSRM.js" 
		charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/button/classic/validate_LogExtremeValueMinSRM.js" 
		charset="gb2312"></script> -->
	</head>
  
	<body onload="onload_parameter();">
		<input type="hidden" id="flag" value=<%= flag%>>
		<div id="loader_container" style="display:none">   <!-- 执行等待条 -->
			<div id="loader">
				<div align="center">正在执行，请稍后 ...</div>
				<div id="loader_bg">
					<div id="progress"></div>
				</div>
			</div>
		</div>
		<div class="titlename">模型参数</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="parameter_tab1" onClick="setTab('parameter',1,2)" 
					class="hover">模型参数</li> 
					<li id="parameter_tab2" onClick="setTab('parameter',2,2)" 
					style="display:none">参数修改</li>  
				</ul> 
			</div> 
			<div class="main_tab_content">
				<div id="parameter_con1">
					<table style="width:80%;">
						<tr>
							<th style="background:#EEE;"></th>
							<th style="background:#EEE;">模型参数</th>
							<th style="background:#EEE;"></th>
						</tr>
						<tr><th style="background:#326ea5; color:white;width:150px;">经典数学模型</th></tr>
					<% 	parameter = parameterinfo.getparameter("JM"); %>
						<tr class="altrow">
							<td>J_M</td>
							<td style="text-align:left;">
								参数精度ex：<%= parameter[0]%>
								，参数精度ey：<%= parameter[1]%>
							</td>
							<td>
								<input type="button" class="button button-primary" 
								value="修改" onClick="modify('JM');">
							</td>
						</tr>
					<%-- <% 	parameter = parameterinfo.getparameter("DUANE"); %>
						<tr>
							<td>DUANE</td>
							<td style="text-align:left;">
								无参数
							</td>
							<td>
							
							</td>
						</tr>
						<% 	parameter = parameterinfo.getparameter("GammaSRM"); %>
						<tr class="altrow">
							<td>GammaSRM</td>
							<td style="text-align:left;">
								无参数
							</td>
							<td>
							</td>
						</tr>
						<% 	parameter = parameterinfo.getparameter("ExponentialSRM"); %>
						<tr>
							<td>ExponentialSRM</td>
							<td style="text-align:left;">
								无参数
							</td>
							<td>
							
							</td>
						</tr> --%>
						<%-- <% 	parameter = parameterinfo.getparameter("TruncatedExtremeValueMaxSRM"); %>
						<tr class="altrow">
							<td>TruncatedExtremeValueMaxSRM</td>
							<td style="text-align:left;">
								无参数
							</td>
							<td>
							
							</td>
						</tr>
						<% 	parameter = parameterinfo.getparameter("TruncatedExtremeValueMinSRM"); %>
						<tr>
							<td>TruncatedExtremeValueMinSRM</td>
							<td style="text-align:left;">
								无参数
							</td>
							<td>
							
							</td>
						</tr>
						<% 	parameter = parameterinfo.getparameter("TruncatedLogisticSRM"); %>
						<tr class="altrow">
							<td>TruncatedLogisticSRM</td>
							<td style="text-align:left;">
								无参数
							</td>
							<td>
							
							</td>
						</tr>
						<% 	parameter = parameterinfo.getparameter("TruncatedNormalSRM"); %>
						<tr>
							<td>TruncatedNormalSRM</td>
							<td style="text-align:left;">
								无参数
							</td>
							<td>
							
							</td>
						</tr> --%>
						<%-- <% 	parameter = parameterinfo.getparameter("LogNormalSRM"); %>
						<tr class="altrow">
							<td>LogNormalSRM</td>
							<td style="text-align:left;">
								无参数
							</td>
							<td>
							
							</td>
						</tr> --%>
						<%-- <% 	parameter = parameterinfo.getparameter("LogExtremeValueMaxSRM"); %>
						<tr>
							<td>LogExtremeValueMaxSRM</td>
							<td style="text-align:left;">
								无参数
							</td>
							<td>
							
							</td>
						</tr>
						<% 	parameter = parameterinfo.getparameter("LogExtremeValueMinSRM"); %>
						<tr class="altrow">
							<td>LogExtremeValueMinSRM</td>
							<td style="text-align:left;">
								无参数
							</td>
							<td>
							
							</td>
						</tr>
						<% 	parameter = parameterinfo.getparameter("LogLogisticSRM"); %>
						<tr>
							<td>LogLogisticSRM</td>
							<td style="text-align:left;">
								无参数
							</td>
							<td>
							
							</td>
						</tr> --%>
						<% 	parameter = parameterinfo.getparameter("GO"); %>
						<tr class="altrow">
							<td>G_O</td>
							<td style="text-align:left;">
								参数精度ex：<%= parameter[0]%>
								，参数精度ey：<%= parameter[1]%>
							</td>
							<td>
								<input type="button" class="button button-primary" 
								value="修改" onClick="modify('GO');">
							</td>
						</tr>
						
					<%-- <% 	parameter = parameterinfo.getparameter("WEIBULL"); %>
						<tr>
							<td>Weibull</td>
							<td style="text-align:left;">
								无参数
							</td>
							<td>
							
							</td>
						</tr> --%>
					
						<% 	parameter = parameterinfo.getparameter("SCHNEIDEWIND"); %>
						<tr>
							<td>Schneidewind</td>
							<td style="text-align:left;">
								参数精度ex：<%= parameter[0]%>
								，参数精度ey：<%= parameter[1]%>
							</td>
							<td>
								<input type="button" class="button button-primary" 
								value="修改" onClick="modify('SCHNEIDEWIND');">
							</td>
						</tr>
						<% 	parameter = parameterinfo.getparameter("MO"); %>
						<tr class="altrow">
							<td>M_O</td>
							<td style="text-align:left;">
								参数精度ex：<%= parameter[0]%>
								，参数精度ey：<%= parameter[1]%>
							</td>
							<td>
								<input type="button" class="button button-primary" 
								value="修改" onClick="modify('MO');">
							</td>
						</tr>
<!-- *******************************增加模型接口************************************* -->
<!-- *******************************增加模型接口************************************* -->
<!-- *******************************增加模型接口************************************* -->
<!-- *******************************增加模型接口************************************* -->
<!-- *******************************增加模型接口************************************* -->
						<tr><th style="background:#326ea5; color:white">人工智能模型</th></tr>
						<% parameter = parameterinfo.getparameter("BPN"); %>
						<tr class="altrow">
							<td>BPN</td>
							<td style="text-align:left;">
								学习系数：<%= parameter[0]%>
								，重构维数：<%= parameter[1]%>
								，训练代数：<%= parameter[2]%>
								，阈值：<%= parameter[3]%>
							</td>
							<td>
								<input type="button" class="button button-primary" 
								value="修改" onClick="modify('BPN');">
							</td>
						</tr>
						
						
						<% parameter = parameterinfo.getparameter("RBFN"); %>
						<tr>
							<td>RBFN</td>
							<td style="text-align:left;">
								重构维数：<%= parameter[0]%>
								，中心系数：<%= parameter[1]%>
							</td>
							<td>
								<input type="button" class="button button-primary" 
								value="修改" onClick="modify('RBFN');">
							</td>
						</tr>
						<% parameter = parameterinfo.getparameter("GEP"); %>
						<tr class="altrow">
							<td>GEP</td>
							<td style="text-align:left;">
								种群大小：<%= parameter[0]%>
								，重构维数：<%= parameter[1]%>
								，基因头部长度：<%= parameter[2]%>
								，基因数量：<%= parameter[3]%>
								，基因变异概率：<%= parameter[4]%>
								，IS迁移概率：<%= parameter[5]%>
								，RIS迁移概率：<%= parameter[6]%>
								，单点重组概率：<%= parameter[7]%>
								，双点重组概率：<%= parameter[8]%>
								，基因重组概率：<%= parameter[9]%>
								，训练代数：<%= parameter[10]%>
								，阈值：<%= parameter[11]%>
							</td>
							<td>
								<input type="button" class="button button-primary" 
								value="修改" onClick="modify('GEP');">
							</td>
						</tr>
						<% parameter = parameterinfo.getparameter("GM"); %>
						<tr>
							<td>GM</td>
							<td style="text-align:left;">
								指数分量：<%= parameter[0]%>
							</td>
							<td>
								<input type="button" class="button button-primary" 
								value="修改" onClick="modify('GM');">
							</td>
						</tr>
						<% parameter = parameterinfo.getparameter("SVM"); %>
						<tr class="altrow">
							<td>SVM</td>
							<td style="text-align:left;">
								SVM类型：
							<%	if(parameter[0].equals("3")) {out.print("epsilon-SVR");}
								if(parameter[0].equals("4")) {out.print("nu-SVR");}%>
								，核函数类型：
							<%	if(parameter[1].equals("0")) {out.print("线性核");}
								if(parameter[1].equals("2")) {out.print("径向基核");}
								if(parameter[1].equals("3")) {out.print("S型核");}%>
								，惩罚系数：<%= parameter[2]%>
								，gamma值：<%= parameter[3]%>
								，损失函数值：<%= parameter[4]%>
								，nu参数：<%= parameter[5]%>
								，S型核参数：<%= parameter[6]%>
								，终止条件：<%= parameter[7]%>
							</td>
							<td>
								<input type="button" class="button button-primary" 
								value="修改" onClick="modify('SVM');">
							</td>
						</tr>
						<% parameter = parameterinfo.getparameter("ARIMA"); %>
						<tr>
							<td>ARIMA</td>
							<td style="text-align:left;">
								参数之一：<%= parameter[0]%>
								，参数之二：<%= parameter[1]%>
								，参数之三：<%= parameter[2]%>
								，参数之四：<%= parameter[3]%>
							</td>
							<td>
								<input type="button" class="button button-primary" 
								value="修改" onClick="modify('ARIMA');">
							</td>
						</tr>
						<%-- <% 	parameter = parameterinfo.getparameter("CPHSRM"); %>
						<tr class="altrow">
							<td>CPHSRM</td>
							<td style="text-align:left;">
								无参数
							</td>
							<td>
							
							</td>
						</tr>
						<% 	parameter = parameterinfo.getparameter("HyperErlangSRM"); %>
						<tr>
							<td>HyperErlangSRM</td>
							<td style="text-align:left;">
								无参数
							</td>
							<td>
							
							</td>
						</tr> --%>
						
						
<!-- **********************************增加模型接口********************************** -->
<!-- **********************************增加模型接口********************************** -->
<!-- **********************************增加模型接口********************************** -->
<!-- **********************************增加模型接口********************************** -->
<!-- **********************************增加模型接口********************************** -->
					</table>
				</div>
				<div id="parameter_con2" style="display:none">
					<div id="modify_BPN" style="height:100%;width:100%;display:none;">
						<% parameter = parameterinfo.getparameter("BPN"); %>
						<div class="subtitle">BPN模型默认参数修改</div>
						<div class="setup">
							<form action="modifyparameter.jsp" method="post" 
							onsubmit="return validate_BPN(this,3);">
								学习系数：<input type="text" name="BPN_parameter1" 
								value="<%= parameter[0]%>">
								<span class="setup_description">
								(设置范围：0-1。 控制神经网络每轮学习的快慢，越接近于1学习越快)
								</span><br><br>
				  				重构维数：<input type="text" name="BPN_parameter2" 
				  				value="<%= parameter[1]%>">
				  				<span class="setup_description">
				  				(设置范围：3-10。 设置神经网络结构输入层节点的个数)
				  				</span><br><br>
								训练代数：<input type="text" name="BPN_parameter3" 
								value="<%= parameter[2]%>">
								<span class="setup_description">
								(设置范围：10-100000。 当训练到指定代数，终止训练)
								</span><br><br>
								阈值：<input type="text" name="BPN_parameter4" 
								value="<%= parameter[3]%>">
								<span class="setup_description">
								(设置范围：0-100。 当阈值小于指定值，终止训练)
								</span><br><br>
								<div style="text-align:center">
									<input type="hidden" name="model" value="BPN">
									<input type="submit" class="button button-primary" value="修改参数">
								</div>
							</form>	
						</div>
					</div>
					<div id="modify_RBFN" style="height:100%;width:100%;display:none;">
						<% parameter = parameterinfo.getparameter("RBFN"); %>
						<div class="subtitle">RBFN模型默认参数修改</div>
						<div class="setup">
							<form action="modifyparameter.jsp" method="post" 
							onsubmit="return validate_RBFN(this,3);">
								重构维数：<input type="text" name="RBFN_parameter1" 
								value="<%= parameter[0]%>">
								<span class="setup_description">
									(设置范围：设置径向基神经网络结构输入层节点的个数。 )
								</span><br><br>
			  					中心系数：<input type="text" name="RBFN_parameter2" 
			  					value="<%= parameter[1]%>">
			  					<span class="setup_description">
			  						(设置范围：0-1。控制径向基网络中各中心的相关性 )
			  					</span><br><br>
								<div style="text-align:center">
									<input type="hidden" name="model" value="RBFN">
									<input type="submit" class="button button-primary" value="修改参数">
								</div>
							</form>	
						</div>
					</div>
					<div id="modify_GEP" style="height:100%;width:100%;display:none;">
						<% parameter = parameterinfo.getparameter("GEP"); %>
						<div class="subtitle">GEP模型默认参数修改</div>
						<div class="setup" style="height:85%;overflow:auto;">
							<form action="modifyparameter.jsp" method="post" 
							onsubmit="return validate_GEP(this,3);">
								种群大小：<input type="text" name="GEP_parameter1" 
								value="<%= parameter[0]%>">
								<span class="setup_description">
									(设置范围：30-100。 设置种群中包含染色体的个数 )
								</span><br><br>
			  					重构维数：<input type="text" name="GEP_parameter2" 
			  					value="<%= parameter[1]%>">
			  					<span class="setup_description">
			  						(设置范围：3-10。 设置相空间重构的维数)
			  					</span><br><br>
								基因头部长度：<input type="text" name="GEP_parameter3" 
								value="<%= parameter[2]%>">
								<span class="setup_description">
									(设置范围：5-15。 设置基因头部的长度h，基因的总长度为2*h+1)
								</span><br><br>
								基因数量：<input type="text" name="GEP_parameter4" 
								value="<%= parameter[3]%>">
								<span class="setup_description">
									(设置范围：2-10。 设置一个染色体重包含基因的个数)
								</span><br><br>
								基因变异概率：<input type="text" name="GEP_parameter5" 
								value="<%= parameter[4]%>">
								<span class="setup_description">
									(设置范围：0-1。 设置每代中基因发生变异的概率)
								</span><br><br>
								IS迁移概率：<input type="text" name="GEP_parameter6" 
								value="<%= parameter[5]%>">
								<span class="setup_description">
									(设置范围：0-1。 设置每代中染色体发生IS迁移的概率)
								</span><br><br>
								RIS迁移概率：<input type="text" name="GEP_parameter7" 
								value="<%= parameter[6]%>">
								<span class="setup_description">
									(设置范围：0-1。 设置每代中染色体发生RIS迁移的概率)
								</span><br><br>
								单点重组概率：<input type="text" name="GEP_parameter8" 
								value="<%= parameter[7]%>">
								<span class="setup_description">
									(设置范围：0-1。 设置每代中染色体发生单点重组的概率)
								</span><br><br>
								双点重组概率：<input type="text" name="GEP_parameter9" 
								value="<%= parameter[8]%>">
								<span class="setup_description">
									(设置范围：0-1。 设置每代中染色体发生双点重组的概率)
								</span><br><br>
								基因重组概率：<input type="text" name="GEP_parameter10" 
								value="<%= parameter[9]%>">
								<span class="setup_description">
									(设置范围：0-1。 设置每代中染色体发生基因重组的概率)
								</span><br><br>
								训练代数：<input type="text" name="GEP_parameter11" 
								value="<%= parameter[10]%>">
								<span class="setup_description">
									(设置范围：10-100000。 当训练到指定代数，终止训练)
								</span><br><br>
								阈值：<input type="text" name="GEP_parameter12" 
								value="<%= parameter[11]%>">
								<span class="setup_description">
									(设置范围：0-100。 当阈值小于指定值，终止训练)
								</span><br><br>
								
								<div style="text-align:center">
									<input type="hidden" name="model" value="GEP">
									<input type="submit" class="button button-primary" value="修改参数">
								</div>
							</form>	
						</div>
					</div>
					<div id="modify_GM" style="height:100%;width:100%;display:none;">
						<% parameter = parameterinfo.getparameter("GM"); %>
						<div class="subtitle">GM模型默认参数修改</div>
						<div class="setup">
							<form action="modifyparameter.jsp" method="post" 
							onsubmit="return validate_GM(this,3);">
								指数分量：
				  				<select name="GM_parameter1">
									<option value="1"
									<% if(parameter[0].equals("1")) {%> selected <%}%>>1
									</option>
									<option value="2"
									<% if(parameter[0].equals("2")) {%> selected <%}%>>2
									</option>
								</select>
				  				<span class="setup_description">
				  				(设置微分方程的阶数，以确定不同的灰色模型方程)
				  				</span><br><br>
				  				<div style="text-align:center">
									<input type="hidden" name="model" value="GM">
									<input type="submit" class="button button-primary" value="修改参数">
								</div>
							</form>	
						</div>
					</div>
					<div id="modify_SVM" style="height:100%;width:100%;display:none;">
						<% parameter = parameterinfo.getparameter("SVM"); %>
						<div class="subtitle">SVM模型默认参数修改</div>
						<div class="setup">
							<form action="modifyparameter.jsp" method="post" 
							onsubmit="return validate_SVM(this,3);">
								SVM类型：
								<select name="SVM_parameter1">
									<option value="3" <%if(parameter[0].equals("3")) {%>selected<%}%>>
										epsilon-SVR
									</option>
									<option value="4" <%if(parameter[0].equals("4")) {%>selected<%}%>>
										nu-SVR
									</option>
								</select>
								<span class="setup_description">
									(设置范围：0-1。 )
								</span><br><br>
			  					核函数类型：
								<select name="SVM_parameter2">
									<option value="0" <%if(parameter[1].equals("0")) {%>selected<%}%>>
										线性核
									</option>
									<option value="2" <%if(parameter[1].equals("2")) {%>selected<%}%>>
										径向基核
									</option>
									<option value="3" <%if(parameter[1].equals("3")) {%>selected<%}%>>
										S型核
									</option>
								</select>
			  					<span class="setup_description">
			  						(设置范围：0-1。 )
			  					</span><br><br>
								惩罚系数：<input type="text" name="SVM_parameter3" 
								value="<%= parameter[2]%>">
								<span class="setup_description">
									(设置范围：0-100000。值越大效果越精确，但会增加算法的迭代次数)
								</span><br><br>
								gamma值：<input type="text" name="SVM_parameter4" 
								value="<%= parameter[3]%>">
								<span class="setup_description">
									(设置范围：0-1。 )
								</span><br><br>
								损失函数值：<input type="text" name="SVM_parameter5" 
								value="<%= parameter[4]%>">
								<span class="setup_description">
									(设置范围：0-1。 )
								</span><br><br>
								nu参数：<input type="text" name="SVM_parameter6" 
								value="<%= parameter[5]%>">
								<span class="setup_description">
									(设置范围：0-1。 )
								</span><br><br>
								S型核参数：<input type="text" name="SVM_parameter7" 
								value="<%= parameter[6]%>">
								<span class="setup_description">
									(设置范围：0-1。 )
								</span><br><br>
								终止条件：<input type="text" name="SVM_parameter8" 
								value="<%= parameter[7]%>">
								<span class="setup_description">
									(设置范围：0-1。 )
								</span><br><br>
								<div style="text-align:center">
									<input type="hidden" name="model" value="SVM">
									<input type="submit" class="button button-primary" value="修改参数">
								</div>
							</form>	
						</div>
					</div>
					<div id="modify_ARIMA" style="height:100%;width:100%;display:none;">
						<% parameter = parameterinfo.getparameter("ARIMA"); %>
						<div class="subtitle">ARIMA模型默认参数修改</div>
						<div class="setup">
							<form action="modifyparameter.jsp" method="post" 
							onsubmit="return validate_ARIMA(this,3);">
								参数之一：<input type="text" name="ARIMA_parameter1" 
								value="<%= parameter[0]%>">
								<span class="setup_description">
									(设置范围：0-1。 )
								</span><br><br>
			  					参数之二：<input type="text" name="ARIMA_parameter2" 
			  					value="<%= parameter[1]%>">
			  					<span class="setup_description">
			  						(设置范围：0-1。 )
			  					</span><br><br>
								参数之三：<input type="text" name="ARIMA_parameter3" 
								value="<%= parameter[2]%>">
								<span class="setup_description">
									(设置范围：0-1。 )
								</span><br><br>
								参数之四：<input type="text" name="ARIMA_parameter4" 
								value="<%= parameter[3]%>">
								<span class="setup_description">
									(设置范围：0-1。 )
								</span><br><br>
								<div style="text-align:center">
									<input type="hidden" name="model" value="ARIMA">
									<input type="submit" class="button button-primary" value="修改参数">
								</div>
							</form>	
						</div>
					</div>
					<div id="modify_JM" style="height:100%;width:100%;display:none;">
						<% parameter = parameterinfo.getparameter("JM"); %>
						<div class="subtitle">J_M模型默认参数修改</div>
						<div class="setup">
							<form action="modifyparameter.jsp" method="post" 
							onsubmit="return validate_JM(this,3);">
								参数精度ex：<input type="text" name="JM_parameter1" 
								value="<%= parameter[0]%>">
								<span class="setup_description">
									(设置范围：0-1。 )
								</span><br><br>
			  					参数精度ey：<input type="text" name="JM_parameter2" 
			  					value="<%= parameter[1]%>">
			  					<span class="setup_description">
			  						(设置范围：0-1。 )
			  					</span><br><br>
								<div style="text-align:center">
									<input type="hidden" name="model" value="JM">
									<input type="submit" class="button button-primary" value="修改参数">
								</div>
							</form>	
						</div>
					</div>
					<div id="modify_MO" style="height:100%;width:100%;display:none;">
						<% parameter = parameterinfo.getparameter("MO"); %>
						<div class="subtitle">M_O模型默认参数修改</div>
						<div class="setup">
							<form action="modifyparameter.jsp" method="post" 
							onsubmit="return validate_MO(this,3);">
								参数精度ex：<input type="text" name="MO_parameter1" 
								value="<%= parameter[0]%>">
								<span class="setup_description">
									(设置范围：0-1。 )
								</span><br><br>
			  					参数精度ey：<input type="text" name="MO_parameter2" 
			  					value="<%= parameter[1]%>">
			  					<span class="setup_description">
			  						(设置范围：0-1。 )
			  					</span><br><br>
								<div style="text-align:center">
									<input type="hidden" name="model" value="MO">
									<input type="submit" class="button button-primary" value="修改参数">
								</div>
							</form>	
						</div>
					</div>
					<div id="modify_GO" style="height:100%;width:100%;display:none;">
						<% parameter = parameterinfo.getparameter("GO"); %>
						<div class="subtitle">G_O模型默认参数修改</div>
						<div class="setup">
							<form action="modifyparameter.jsp" method="post" 
							onsubmit="return validate_GO(this,3);">
								参数精度ex：<input type="text" name="GO_parameter1" 
								value="<%= parameter[0]%>">
								<span class="setup_description">
									(设置范围：0-1。 )
								</span><br><br>
			  					参数精度ey：<input type="text" name="GO_parameter2" 
			  					value="<%= parameter[1]%>">
			  					<span class="setup_description">
			  						(设置范围：0-1。 )
			  					</span><br><br>
								<div style="text-align:center">
									<input type="hidden" name="model" value="GO">
									<input type="submit" class="button button-primary" value="修改参数">
								</div>
							</form>	
						</div>
					</div>
					<div id="modify_WEIBULL" style="height:100%;width:100%;display:none;">
						<% parameter = parameterinfo.getparameter("WEIBULL"); %>
						<div class="subtitle">Weibull模型默认参数修改</div>
						<div class="setup">
							<form action="modifyparameter.jsp" method="post" 
							onsubmit="return validate_WEIBULL(this,3);">
								<div style="text-align:center">
									<input type="hidden" name="model" value="WEIBULL">
									<input type="submit" class="button button-primary" value="修改参数">
								</div>
							</form>	
						</div>
					</div>
					<div id="modify_DUANE" style="height:100%;width:100%;display:none;">
						<% parameter = parameterinfo.getparameter("DUANE"); %>
						<div class="subtitle">DUANE模型默认参数修改</div>
						<div class="setup">
							<form action="modifyparameter.jsp" method="post" 
							onsubmit="return validate_DUANE(this,3);">
								<div style="text-align:center">
									<input type="hidden" name="model" value="DUANE">
									<input type="submit" class="button button-primary" value="修改参数">
								</div>
							</form>	
						</div>
					</div>
					<div id="modify_GammaSRM" style="height:100%;width:100%;display:none;">
						<% parameter = parameterinfo.getparameter("GammaSRM"); %>
						<div class="subtitle">GammaSRM模型默认参数修改</div>
						<div class="setup">
							<form action="modifyparameter.jsp" method="post" 
							onsubmit="return validate_GammaSRM(this,3);">
							
								<div style="text-align:center">
									<input type="hidden" name="model" value="GammaSRM">
									<input type="submit" class="button button-primary" value="修改参数">
								</div>
							</form>	
						</div>
					</div>
					<div id="modify_ExponentialSRM" style="height:100%;width:100%;display:none;">
						<% parameter = parameterinfo.getparameter("ExponentialSRM"); %>
						<div class="subtitle">ExponentialSRM模型默认参数修改</div>
						<div class="setup">
							<form action="modifyparameter.jsp" method="post" 
							onsubmit="return validate_ExponentialSRM(this,3);">
							
			  					
								<div style="text-align:center">
									<input type="hidden" name="model" value="ExponentialSRM">
									<input type="submit" class="button button-primary" value="修改参数">
								</div>
							</form>	
						</div>
					</div>
					<div id="modify_LogNormalSRM" style="height:100%;width:100%;display:none;">
						<% parameter = parameterinfo.getparameter("LogNormalSRM"); %>
						<div class="subtitle">LogNormalSRM模型默认参数修改</div>
						<div class="setup">
							<form action="modifyparameter.jsp" method="post" 
							onsubmit="return validate_LogNormalSRM(this,3);">
							
								<div style="text-align:center">
									<input type="hidden" name="model" value="LogNormalSRM">
									<input type="submit" class="button button-primary" value="修改参数">
								</div>
							</form>	
						</div>
					</div>
					<%-- <div id="modify_TruncatedExtremeValueMaxSRM" style="height:100%;width:100%;display:none;">
						<% parameter = parameterinfo.getparameter("TruncatedExtremeValueMaxSRM"); %>
						<div class="subtitle">TruncatedExtremeValueMaxSRM模型默认参数修改</div>
						<div class="setup">
							<form action="modifyparameter.jsp" method="post" 
							onsubmit="return validate_TruncatedExtremeValueMaxSRM(this,3);">
								<div style="text-align:center">
									<input type="hidden" name="model" value="TruncatedExtremeValueMaxSRM">
									<input type="submit" class="button" value="修改参数">
								</div>
							</form>	
						</div>
					</div>
					<div id="modify_TruncatedExtremeValueMinSRM" style="height:100%;width:100%;display:none;">
						<% parameter = parameterinfo.getparameter("TruncatedExtremeValueMinSRM"); %>
						<div class="subtitle">TruncatedExtremeValueMinSRM模型默认参数修改</div>
						<div class="setup">
							<form action="modifyparameter.jsp" method="post" 
							onsubmit="return validate_TruncatedExtremeValueMinSRM(this,3);">
								<div style="text-align:center">
									<input type="hidden" name="model" value="TruncatedExtremeValueMinSRM">
									<input type="submit" class="button" value="修改参数">
								</div>
							</form>	
						</div>
					</div>
					<div id="modify_TruncatedLogisticSRM" style="height:100%;width:100%;display:none;">
						<% parameter = parameterinfo.getparameter("TruncatedLogisticSRM"); %>
						<div class="subtitle">TruncatedLogisticSRM模型默认参数修改</div>
						<div class="setup">
							<form action="modifyparameter.jsp" method="post" 
							onsubmit="return validate_TruncatedLogisticSRM(this,3);">
								<div style="text-align:center">
									<input type="hidden" name="model" value="TruncatedLogisticSRM">
									<input type="submit" class="button" value="修改参数">
								</div>
							</form>	
						</div>
					</div>
					<div id="modify_TruncatedNormalSRM" style="height:100%;width:100%;display:none;">
						<% parameter = parameterinfo.getparameter("TruncatedNormalSRM"); %>
						<div class="subtitle">TruncatedNormalSRM模型默认参数修改</div>
						<div class="setup">
							<form action="modifyparameter.jsp" method="post" 
							onsubmit="return validate_TruncatedNormalSRM(this,3);">
								<div style="text-align:center">
									<input type="hidden" name="model" value="TruncatedNormalSRM">
									<input type="submit" class="button" value="修改参数">
								</div>
							</form>	
						</div>
					</div> --%>
					
					<%-- <div id="modify_LogExtremeValueMaxSRM" style="height:100%;width:100%;display:none;">
						<% parameter = parameterinfo.getparameter("LogExtremeValueMaxSRM"); %>
						<div class="subtitle">LogExtremeValueMaxSRM模型默认参数修改</div>
						<div class="setup">
							<form action="modifyparameter.jsp" method="post" 
							onsubmit="return validate_LogExtremeValueMaxSRM(this,3);">
								<div style="text-align:center">
									<input type="hidden" name="model" value="LogExtremeValueMaxSRM">
									<input type="submit" class="button" value="修改参数">
								</div>
							</form>	
						</div>
					</div>
					<div id="modify_LogExtremeValueMinSRM" style="height:100%;width:100%;display:none;">
						<% parameter = parameterinfo.getparameter("LogExtremeValueMinSRM"); %>
						<div class="subtitle">LogExtremeValueMinSRM模型默认参数修改</div>
						<div class="setup">
							<form action="modifyparameter.jsp" method="post" 
							onsubmit="return validate_LogExtremeValueMinSRM(this,3);">
								<div style="text-align:center">
									<input type="hidden" name="model" value="LogExtremeValueMinSRM">
									<input type="submit" class="button" value="修改参数">
								</div>
							</form>	
						</div>
					</div>
					<div id="modify_LogLogisticSRM" style="height:100%;width:100%;display:none;">
						<% parameter = parameterinfo.getparameter("LogLogisticSRM"); %>
						<div class="subtitle">LogLogisticSRM模型默认参数修改</div>
						<div class="setup">
							<form action="modifyparameter.jsp" method="post" 
							onsubmit="return validate_LogLogisticSRM(this,3);">
								<div style="text-align:center">
									<input type="hidden" name="model" value="LogLogisticSRM">
									<input type="submit" class="button" value="修改参数">
								</div>
							</form>	
						</div>
					</div>
					<div id="modify_CPHSRM" style="height:100%;width:100%;display:none;">
						<% parameter = parameterinfo.getparameter("CPHSRM"); %>
						<div class="subtitle">CPHSRM模型默认参数修改</div>
						<div class="setup">
							<form action="modifyparameter.jsp" method="post" 
							onsubmit="return validate_CPHSRM(this,3);">
								<div style="text-align:center">
									<input type="hidden" name="model" value="CPHSRM">
									<input type="submit" class="button" value="修改参数">
								</div>
							</form>	
						</div>
					</div>
					<div id="modify_HyperErlangSRM" style="height:100%;width:100%;display:none;">
						<% parameter = parameterinfo.getparameter("HyperErlangSRM"); %>
						<div class="subtitle">HyperErlangSRM模型默认参数修改</div>
						<div class="setup">
							<form action="modifyparameter.jsp" method="post" 
							onsubmit="return validate_HyperErlangSRM(this,3);">
								<div style="text-align:center">
									<input type="hidden" name="model" value="HyperErlangSRM">
									<input type="submit" class="button" value="修改参数">
								</div>
							</form>	
						</div>
					</div> --%>
					<div id="modify_SCHNEIDEWIND" style="height:100%;width:100%;display:none;">
						<% parameter = parameterinfo.getparameter("SCHNEIDEWIND"); %>
						<div class="subtitle">Schneidewind模型默认参数修改</div>
						<div class="setup">
							<form action="modifyparameter.jsp" method="post" 
							onsubmit="return validate_SCHNEIDEWIND(this,3);">
								参数精度ex：<input type="text" name="SCHNEIDEWIND_parameter1" 
								value="<%= parameter[0]%>">
								<span class="setup_description">
									(设置范围：0-1。 )
								</span><br><br>
			  					参数精度ey：<input type="text" name="SCHNEIDEWIND_parameter2" 
			  					value="<%= parameter[1]%>">
			  					<span class="setup_description">
			  						(设置范围：0-1。 )
			  					</span><br><br>
								<div style="text-align:center">
									<input type="hidden" name="model" value="SCHNEIDEWIND">
									<input type="submit" class="button button-primary" value="修改参数">
								</div>
							</form>	
						</div>
					</div>
<!-- *******************************增加模型接口************************************* -->
<!-- *******************************增加模型接口************************************* -->
<!-- *******************************增加模型接口************************************* -->
<!-- *******************************增加模型接口************************************* -->
<!-- *******************************增加模型接口************************************* -->
				</div>
			</div>
		</div>
	</body>
</html>
