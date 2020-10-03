function validate_EMD_resolve(form)		//EMD分解提交验证
{
	var returnvalue="";		//声明一个返回空字符串，如果函数运行结束时字符串有内容，那代表验证不通过
	var cs1=form.EMD_parameter1.value;	//提取零值
	var cs2=form.EMD_parameter2.value;	//提取最大分解个数

	if(!isNaN(cs1))			//过滤零值的奇异输入
	{
		if(cs1<=0)
		{
			returnvalue=returnvalue+"零值必须大于0！\n";	//零值必须大于0
		}
	}
	else
	{
		returnvalue=returnvalue+"零值输入格式错误！\n";		//零值输入格式错误
	}
	if(!isNaN(cs2)&&parseInt(cs2)==cs2)			//过滤最大分解个数的奇异输入
	{
		if(cs2<2||cs2>9)
		{
			returnvalue=returnvalue+"最大分解个数的范围为2-9！\n";	//最大分解个数的范围为2-9
		}
	}
	else
	{
		returnvalue=returnvalue+"最大分解个数格式错误！\n";		//最大分解个数格式错误
	}
	
	if(returnvalue=="")
	{
		document.getElementById("loader_container").style.display="block";
		//把执行等待滚动条打开
		document.getElementById("mergerflag").value="0";	//mergerflag置0
		document.getElementById("flag").value++;	//启动检查通过标志
		return true;
	}
	else
	{
		alert(returnvalue);		//如果returnvalue有内容，代表有错误
		return false;
	}
}