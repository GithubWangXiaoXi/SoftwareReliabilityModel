function validate_MO(form,type)		//ARIMA模型提交验证
{
	var returnvalue="";		//声明一个返回空字符串，如果函数运行结束时字符串有内容，那代表验证不通过
	if(type=="1")
	{
		var prestep=form.prestep.value;		//提取预测步长
		if(!isNaN(prestep)&&parseInt(prestep)==prestep)		//过滤预测步长的奇异输入
		{
			if(prestep<0||prestep>100)
			{
				returnvalue=returnvalue+"预测步长输入范围为0-100！\n";
			}
		}
		else
		{
			returnvalue=returnvalue+"预测步长输入格式错误！\n";
		}
	}
	var cs1=form.MO_parameter1.value;
	var cs2=form.MO_parameter2.value;
	if(!isNaN(cs1))			//过滤参数1的奇异输入
	{
		if(cs1<=0||cs1>1)
		{
			returnvalue=returnvalue+"参数精度ex输入范围为0-1！\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"参数精度ex输入格式错误！\n";
	}
	if(!isNaN(cs2))			//过滤参数2的奇异输入
	{
		if(cs2<=0||cs2>1)
		{
			returnvalue=returnvalue+"参数精度ey输入范围为0-1！\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"参数精度ey输入格式错误！\n";
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