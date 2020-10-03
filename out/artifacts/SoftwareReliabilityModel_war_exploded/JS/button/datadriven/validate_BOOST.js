function validate_BOOST(form,type)		//BOOST模型提交验证
{
	var returnvalue="";		//声明一个返回空字符串，如果函数运行结束时字符串有内容，那代表验证不通过
	var height = form.height.value;
	var times = form.times.value;
	var threshold = form.threshold.value;
	var dimension = form.dimension.value;
	var val = Number(dimension);
	if(!isNaN(height))			//过滤参数1的奇异输入
	{
		if(height <= 1 || height > dimension + 1)
		{
			returnvalue=returnvalue+"树的高度输入范围为2-" + val + "！\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"树的高度输入格式错误！\n";
	}
	if(!isNaN(times))			//过滤参数2的奇异输入
	{
		if(times<0||times>1000)
		{
			returnvalue=returnvalue+"训练次数输入范围为0-1000！\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"训练次数输入格式错误！\n";
	}
	if(!isNaN(threshold))			//过滤参数2的奇异输入
	{
		if(threshold < 0 || threshold > 1)
		{
			returnvalue=returnvalue+"误差阈值输入范围为0-1！\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"误差阈值输入格式错误！\n";
	}
	if(returnvalue=="")
	{
		if(type=="1")
		{
            // alert(1)
			document.getElementById("loader_container").style.display="block";
			//把执行等待滚动条打开
			document.getElementById("flag").value++;	//启动检查通过标志
			return true;
		}
		if(type=="2")
		{
            // alert(2)
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
            // alert(3)
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