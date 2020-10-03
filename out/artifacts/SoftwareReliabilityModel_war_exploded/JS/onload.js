function onload()	//执行操作完毕后的善后处理脚本函数
{
	if(parent.document.getElementById("flag").value!=0)	//判断提交页面的flag是否为0
	{
		var mod=parent.document.getElementById("model").value;	//提取model名
		var cur_t=parent.document.getElementById("current_tab").value;	//提取当前tab页
		var nex_t=(parseInt(cur_t)+1);	//运行完需要跳到的tab页
		if(mod=="EMD"||mod=="LN"||mod=="SSA"||mod=="WAVE")
		{
			parent.document.getElementById(mod+"_tab5").style.display="none";
			parent.document.getElementById(mod+"_tab1").className="";
			parent.document.getElementById(mod+"_con1").style.display="none";
			//如果是混合模型，在执行分解时，需要把tab页5的内容给取消掉
		}
		parent.document.getElementById(mod+"_tab"+nex_t).style.display="block";
		//显示需要跳到的tab页
		parent.document.getElementById(mod+"_tab"+cur_t).className="";
		//取消当前tab页的样式
		parent.document.getElementById(mod+"_tab"+nex_t).className="hover";
		//显示需要跳到的tab页样式
		parent.document.getElementById(mod+"_con"+cur_t).style.display="none";
		//取消当前页的内容
		parent.document.getElementById(mod+"_con"+nex_t).style.display="block";
		//显示下一个页面的内容
		parent.document.getElementById("loader_container").style.display="none";
		//关闭提交页面的执行等待滚动条
		alert("执行完成！");
	}
}
function onload_merger()	//执行操作完毕后的善后处理脚本函数
{
	if(parent.document.getElementById("mergerflag").value!=0)	//判断提交页面的flag是否为0
	{
		var mod=parent.document.getElementById("model").value;	//提取model名
		parent.document.getElementById(mod+"_tab5").style.display="block";//显示需要跳到的tab页
		parent.document.getElementById(mod+"_tab4").className="";//取消当前tab页的样式
		parent.document.getElementById(mod+"_tab5").className="hover";//显示需要跳到的tab页样式
		parent.document.getElementById(mod+"_con4").style.display="none";//取消当前页的内容
		parent.document.getElementById(mod+"_con5").style.display="block";//显示下一个页面的内容
		parent.document.getElementById("loader_container").style.display="none";
		//关闭提交页面的执行等待滚动条
		alert("执行完成！");
	}
}
function onload_show()	//替换数据完毕后的善后处理脚本函数
{
	if(document.getElementById("changeflag").value=="1")
	{
		alert("数据修改成功！");	//如果在上个提交页面启动了changeflag标志，则显示一个alert框
	}
}
function onload_parameter()		//参数修改完毕后的善后处理脚本函数
{
	if(document.getElementById("flag").value=="1")
	{
		alert("修改成功！");		//如果在上个提交页面启动了flag标志，则显示一个alert框
	}
}
function onload_saveparameter()
{
	if(document.getElementById("model").value!="null")
	{
		model=document.getElementById("model").value;
		parent.document.getElementById("loader_container").style.display="none";
		if(model=="BPN"||model=="RBFN"||model=="GEP"||model=="GM"||model=="ARIMA"||model=="SVM")
		{
			parent.document.parameterform.action="../../resultshow/resultDriven.jsp";
		}
		if(model=="GO"||model=="MO"||model=="JM"||model=="DUANE"||model=="GammaSRM"||model=="LogLogisticSRM"||model=="WEIBULL"||model=="SCHNEIDEWIND"||
				model=="LogNormalSRM"||model=="ParetoSRM"||model=="ExponentialSRM")
		{
			parent.document.parameterform.action="../../resultshow/resultClassic.jsp";
		}

		//保存数据后跳转到数据输出页面，否则点击预测时总是显示保存成功
        if(model=="BOOST")
        {
            parent.document.parameterform.action="../../resultshow/resultDriven1.jsp";
        }

		parent.document.parameterform.target="SHOWDATA_"+model;
		alert("保存成功！");
	}
}
function onload_input()			//导入数据完毕后的善后处理脚本函数
{
	if(document.getElementById("flag").value=="1")
	{
		alert("数据导入成功！");		//如果在上个提交页面启动了flag标志，则显示一个alert框
	}
}
function onload_resolve(resolveflag)
{
	if(resolveflag=="1")
	{
		document.getElementById("mergerflag").value="0";
		document.getElementById("flag").value++;	//启动检查通过标志
		document.resolve.submit();
		document.getElementById("loader_container").style.display="block";
	}
}