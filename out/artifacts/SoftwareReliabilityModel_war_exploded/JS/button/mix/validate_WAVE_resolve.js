function validate_WAVE_resolve(form)		//WAVE分解提交验证
{
	var returnvalue="";		//声明一个返回空字符串，如果函数运行结束时字符串有内容，那代表验证不通过
	var cs1=form.WAVE_parameter1.value;
	var cs2=form.WAVE_parameter2.value;
	if(!isNaN(cs1)||parseInt(cs1)==cs1)		//过滤分解维数的奇异输入
	{
		if(cs1<2||cs1>10)
		{
			returnvalue=returnvalue+"分解维数输入范围为2-10！\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"分解维数输入格式错误！\n";
	}
	if(!isNaN(cs2))			//过滤参数2的奇异输入
	{
		if(cs2<=0||cs2>1)
		{
			returnvalue=returnvalue+"参数2输入范围为0-1！\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"参数2输入格式错误！\n";
	}
	if(returnvalue=="")
	{
		document.getElementById("loader_container").style.display="block";
		//把执行等待滚动条打开
		document.getElementById("mergerflag").value="0";
		document.getElementById("flag").value++;	//启动检查通过标志
		return true;
	}
	else
	{
		alert(returnvalue);		//如果returnvalue有内容，代表有错误
		return false;
	}
}