<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="system.*" %>
<%@ page import="com.alibaba.fastjson.JSON" %>
<!-- javabean:inputdata 当前使用数据 | parameterinfo 默认参数信息 -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<%
	String step = parameterinfo.getstep();
	String[] parameter = parameterinfo.getparameter("BOOST");
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

	String featureName =  JSON.toJSONString(curds.getColname());
	System.out.println(featureName);
%>

<html>
	<head>
    	<title>提升模型</title>
   		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/button/datadriven/validate_SVM.js" 
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
		<div class="titlename">提升模型</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul>
					<li id="SVM_tab1" onClick="setTab('SVM',1,4)" class="hover">模型简介</li> 
					<li id="SVM_tab2" onClick="setTab('SVM',2,4)" >失效数据</li> 
					<li id="SVM_tab3" onClick="setTab('SVM',3,4)">预测分析</li> 
					<li id="SVM_tab4" onClick="setTab('SVM',4,4)" style="display:none">分析结果</li> 
				</ul>
			</div> 
			<div class="main_tab_content"> 
				<div id="SVM_con1">
					<div class="subtitle">模型简介</div>
					<div class="scrollbox">
						<p>
							提升方法（Boosting），是一种可以用来减小监督式学习中偏差的机器学习算法。面对的问题是迈可.肯斯（Michael Kearns）
							提出的：一组“弱学习者”的集合能否生成一个“强学习者”？弱学习者一般是指一个分类器，它的结果只比随机分类好一点点；
							强学习者指分类器的结果非常接近真值。
						</p>
						<p>
							对于训练目标(<i>x<sub>i</sub></i>,<i>y<sub>i</sub></i>)，
							线性回归的目标就是求线性函数：
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/SVM_1.jpg"></p>
						<p>
							设所有训练样本的拟合精度为<i>ε</i>(又称为不敏感系数)，即满足下式：
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/SVM_2.jpg"></p>
						<p>
							为考虑超出精度要求的拟合误差，
							引入非负松弛变量<i>ξ<sub>i</sub></i>和<i>ξ<sub>i</sub></i><sup>*</sup>，
							这样函数拟合问题就转化为求解向量<i>w</i>和<i>b</i>二次优化问题，即
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/SVM_3.jpg"></p>
						<p>通过引入拉格朗日乘子，可以得到该优化问题的对式：</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/SVM_4.jpg"></p>
						<p>
							其中，
							<i>a<sub>i</sub></i>和<i>a<sub>i</sub></i><sup>*</sup>是拉格朗日乘子。
							支持向量机理论在处理非线性问题时，实质上是以低维空间样本作为输入的核函数
							<i>K</i>(<i>x<sub>i</sub></i>,<i>y<sub>i</sub></i>)
							值来替代映射至高维空间中样本点的内积值，
							即通过核函数将低维空间中的样本向高维空间中映射，
							直至高维空间中的样本线性可分为止。
							因此，
							最后求得的目标函数为：
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/Data-driven/SVM_5.jpg"></p>
						<p>
							支持向量机的最大特点在于它是针对结构风险最小化原则而提出的，
							改变了传统的经验风险最小化原则，
							具有很好的泛化能力，
							因此提出后在各个领域中得到了广泛应用，
							在软件可靠性领域中也得到了较多学者的研究。
							SVM中提出核函数这一概念，
							它能够将在低维空间中线性不可分问题转化为高维空间中的线性可分问题，
							因此在软件可靠性领域中，处理具有复杂和非线性关系的软件失效数据时具有一定的优势。
						</p>
					</div>
				</div>
				<div id="SVM_con2" style="display:none">
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
				<div id="SVM_con3" style="display:none">
					<div class="subtitle">分析设置</div>
					<div class="setup" style="height:85%;overflow:auto;">
						<form action="../../resultshow/resultDriven1.jsp" method="post"
							target="SHOWDATA_SVM" name="parameterform" 
							onsubmit="return validate_SVM(this,1);">
							<div class="parametersetup_title">数据序列：</div>
							<div class="parametersetup_content">
								<select id="Sequence" name="Sequence">
							<%	for(int i=1;i<=inputdata.getdimension();i++)
								{%>
									<option value="<%= String.valueOf(i)%>"
									<%if(i==1) {%>selected<%}%>><%= inputdata.getcolname(i)%>
									</option>
							<%	}%>
								</select>
							</div>

							<%--<div id="selectAdd">--%>
								<%--<div class="parametersetup_title">所选特征：</div>--%>
								<%--<div class="parametersetup_content">--%>
									<%--<div id="bbb">--%>
										<%--<select id="Feature" name="Feature">--%>
											<%--&lt;%&ndash;<%	for(int i=1;i<=inputdata.getdimension();i++)&ndash;%&gt;--%>
											<%--&lt;%&ndash;{%>&ndash;%&gt;--%>
											<%--&lt;%&ndash;<option value="<%= String.valueOf(i)%>"&ndash;%&gt;--%>
											<%--&lt;%&ndash;<%if(i==1) {%>selected<%}%>><%= inputdata.getcolname(i)%>&ndash;%&gt;--%>
											<%--&lt;%&ndash;</option>&ndash;%&gt;--%>
											<%--&lt;%&ndash;<%	}%>&ndash;%&gt;--%>
										<%--</select>--%>
										<%--<input type="button" value="添加" onclick="add()"/>--%>
									<%--</div>--%>
								<%--</div>--%>
							<%--</div>--%>

							<div class="parametersetup_title">树的高度：</div>
							<div class="parametersetup_content">
								<input type="text" name="SVM_parameter1"
									   value="<%= parameter[0]%>">
								(设置范围：1-(特征数 + 1)。设置树模型的深度，默认为所选特征数+1)
							</div>
							<div class="parametersetup_title">迭代次数：</div>
							<div class="parametersetup_content">
								<input type="text" name="SVM_parameter2"
									   value="<%= parameter[1]%>">
								(设置范围：0-10000。当训练到指定次数，终止训练)
							</div>
							<div class="parametersetup_title">阈值：</div>
							<div class="parametersetup_content">
								<input type="text" name="SVM_parameter3" 
								value="<%= parameter[2]%>">
								(设置范围：0-1。阈值是指弱分类器的分类误差率，当阀值小于指定值，终止训练)
							</div>
							
							<div style="text-align:center">
								<input type="hidden" id="model" name="model" value="SVM">
								<input type="hidden" id="flag" value="0">
								<input type="hidden" id="current_tab" value="3">
								<input type="button" class="button button-pill button-primary" 
								onClick="saveparameter();" value="保存">
								<input type="submit" class="button button-pill button-primary" value="预测">
							</div>	
  						</form>
					</div> 
				</div>
				<div id="SVM_con4" style="display:none">
					<iframe name="SHOWDATA_SVM" src="../../resultshow/resultDriven1.jsp"></iframe>
				</div> 
			</div> 
		</div>
	</body>
</html>

<script type="text/javascript">

	//将java数组转化成json，可和js进行类型转换
    var featureName = <%= featureName%>;  //不知道为啥子不能用el表达式，只能用jsp表达式

    //console.log(featureName)

	//判断"数据序列"选了什么，避免特征选择和数据序列选择重复
	var sequenceId = document.getElementById("Sequence").selectedIndex;
	//console.log((sequenceId))

	innerHTMLStr = "";
	if(sequenceId == 0){
        var k = 0;
        for (var i = 1; i < featureName.length; ++i){
            if(k == 1){
                innerHTMLStr += "<option value =" + (i + 1) + "selected>" +  featureName[i] + "</option>";
			}else{
                innerHTMLStr += "<option value =" + (i + 1) + ">" +  featureName[i] + "</option>";
			}
        }
	}else{
        var k = 0;
        for (var i = 0; i < featureName.length; ++i){
            if(k == 0){
                innerHTMLStr += "<option value =" + (i + 1) + "selected>" +  featureName[i] + "</option>";
            }else if(k != sequenceId){
                innerHTMLStr += "<option value =" + (i + 1) + ">" +  featureName[i] + "</option>";
            }
        }
	}

    document.getElementById("Feature").innerHTML = innerHTMLStr;

    function add(){

        var dom1 = document.createElement('div');
        dom1.className = 'parametersetup_title';
        document.getElementById("selectAdd").appendChild(dom1);

        var dom2 = document.createElement('div');
        dom2.className = 'parametersetup_content';

        var str = "<select>";

        innerHTMLStr = "";
        if(sequenceId == 0){
            var k = 0;
            for (var i = 1; i < featureName.length; ++i){
                if(k == 1){
                    innerHTMLStr += "<option value =" + (i + 1) + "selected>" +  featureName[i] + "</option>";
                }else{
                    innerHTMLStr += "<option value =" + (i + 1) + ">" +  featureName[i] + "</option>";
                }
            }
        }else{
            var k = 0;
            for (var i = 0; i < featureName.length; ++i){
                if(k == 0){
                    innerHTMLStr += "<option value =" + (i + 1) + "selected>" +  featureName[i] + "</option>";
                }else if(k != sequenceId){
                    innerHTMLStr += "<option value =" + (i + 1) + ">" +  featureName[i] + "</option>";
                }
            }
        }

        str += innerHTMLStr + "</select>";
        console.log(str);
        dom2.innerHTML = str;
        document.getElementById("selectAdd").appendChild(dom2);
    }
//    document.querySelector('#add').onclick=add(document.querySelector('#bbb'));
</script>

