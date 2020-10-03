function validate_SVM(form,type)		//SVM模型提交验证
{
	var returnvalue="";		//声明一个返回空字符串，如果函数运行结束时字符串有内容，那代表验证不通过
	if(type=="1")
	{
		var prestep=form.prestep.value;		//提取预测步长
		if(!isNaN(prestep)&&parseInt(prestep)==prestep)		//过滤预测步长的奇异输入
		{
			if(prestep<1||prestep>100)
			{
				returnvalue=returnvalue+"预测步长输入范围为1-100！\n";
			}
		}
		else
		{
			returnvalue=returnvalue+"预测步长输入格式错误！\n";
		}
	}
	var cs3=form.SVM_parameter3.value;
	var cs4=form.SVM_parameter4.value;
	var cs5=form.SVM_parameter5.value;
	var cs6=form.SVM_parameter6.value;
	var cs7=form.SVM_parameter7.value;
	var cs8=form.SVM_parameter7.value;
	if(!isNaN(cs3))			//过滤参数1的奇异输入
	{
		if(cs3<=0||cs3>100000)
		{
			returnvalue=returnvalue+"惩罚系数输入范围为0-100000！\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"惩罚系数输入格式错误！\n";
	}
	if(!isNaN(cs4))			//过滤参数2的奇异输入
	{
		if(cs4<0||cs4>1)
		{
			returnvalue=returnvalue+"gamma值输入范围为0-1！\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"gamma值输入格式错误！\n";
	}
	if(!isNaN(cs5))			//过滤参数2的奇异输入
	{
		if(cs5<0||cs5>1)
		{
			returnvalue=returnvalue+"损失函数输入范围为0-1！\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"损失函数输入格式错误！\n";
	}
	if(!isNaN(cs6))			//过滤参数2的奇异输入
	{
		if(cs6<0||cs6>1)
		{
			returnvalue=returnvalue+"nu参数输入范围为0-1！\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"nu参数输入格式错误！\n";
	}
	if(!isNaN(cs7))			//过滤参数2的奇异输入
	{
		if(cs7<0||cs7>1)
		{
			returnvalue=returnvalue+"S型核参数输入范围为0-1！\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"S型核参数输入格式错误！\n";
	}
	if(!isNaN(cs8))			//过滤参数2的奇异输入
	{
		if(cs8<0||cs8>1)
		{
			returnvalue=returnvalue+"终止条件输入范围为0-1！\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"终止条件输入格式错误！\n";
	}
	if(returnvalue=="")
	{
		if(type=="1")
		{
			document.getElementById("loader_container").style.display="block";
			//把执行等待滚动条打开
			document.getElementById("flag").value++;	//启动检查通过标志
			return true;
		}
		if(type=="2")
		{
			if(confirm("确定要保存为默认参数吗？"))
			{
				document.getElementById("loader_container").style.display="block";
				//把执行等待滚动条打开
				document.parameterform.action="../../datainfo/parameterinfo/saveparameter.jsp";
				document.parameterform.target="MODIFYPARAMETER";
				document.parameterform.submit();
			}
			return false;
		}
		if(type=="3")
		{
			if(confirm("确定要修改默认参数吗？"))
			{
				return true;
			}
			return false;
		}
	}
	else
	{
		alert(returnvalue);		//如果returnvalue有内容，代表有错误
		return false;
	}
}