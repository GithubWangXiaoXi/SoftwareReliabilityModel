function validate_RBFN(form,type)		//RBFN模型提交验证
{
	var returnvalue="";		//声明一个返回空字符串，如果函数运行结束时字符串有内容，那代表验证不通过
	if(type=="1")
	{
		var prestep=form.prestep.value;		//提取预测步长
		if(!isNaN(prestep)&&parseInt(prestep)==prestep)		//过滤预测步长的奇异输入
		{
			if(prestep<0||prestep>100)
			{
				returnvalue=returnvalue+"预测步长输入范围为0-100！\n";	//预测步长输入范围为0-100
			}
		}
		else
		{
			returnvalue=returnvalue+"预测步长输入格式错误！\n";		//预测步长输入格式错误
		}
	}
	var cs1=form.RBFN_parameter1.value;		//提取重构维数
	var cs2=form.RBFN_parameter2.value;		//提取中心相关系数
	if(!isNaN(cs1)&&parseInt(cs1)==cs1)		//过滤重构维数的奇异输入
	{
		if(cs1<3||cs1>10)
		{
			returnvalue=returnvalue+"重构维数输入范围为3-10！\n";	//重构维数输入范围为3-10
		}
	}
	else
	{
		returnvalue=returnvalue+"重构维数输入格式错误！\n";	//重构维数输入格式错误
	}
	if(!isNaN(cs2))			//过滤中心相关系数的奇异输入
	{
		if(cs2<=0||cs2>1)
		{
			returnvalue=returnvalue+"中心相关系数输入范围为0-1！\n";	//中心相关系数输入范围为0-1
		}
	}
	else
	{
		returnvalue=returnvalue+"中心相关系数输入格式错误！\n";	//中心相关系数输入格式错误
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
				//修改表单提交页面的路径
				document.parameterform.target="MODIFYPARAMETER";
				//修改表单提交页面的要显示的地方
				document.parameterform.submit();	//提交表单
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