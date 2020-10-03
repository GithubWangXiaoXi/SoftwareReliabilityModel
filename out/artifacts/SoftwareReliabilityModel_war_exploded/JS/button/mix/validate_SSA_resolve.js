function validate_SSA_resolve(form)		//SSA分解提交验证
{
	var returnvalue="";		//声明一个返回空字符串，如果函数运行结束时字符串有内容，那代表验证不通过
	var cs1=form.SSA_parameter1.value;	//提取方差贡献度
	var cs2=form.SSA_parameter2.value;	//窗口长度
	var wl=document.getElementById("wl").value;
	if(!isNaN(cs1))		//过滤方差贡献度的奇异输入
	{
		if(cs1<=0||cs1>=1)
		{
			returnvalue=returnvalue+"方差贡献度的范围为0-1！\n";		//方差贡献度的范围为0-1
		}
	}
	else
	{
		returnvalue=returnvalue+"方差贡献度格式错误！\n";	//方差贡献度格式错误
	}
	if(!isNaN(cs2)&&parseInt(cs2)==cs2)		//过滤分解维数的奇异输入
	{
		if(cs2<2||cs2>wl)
		{
			returnvalue=returnvalue+"窗口长度的范围为2-"+wl+"！\n";	//窗口长度的范围
		}
	}
	else
	{
		returnvalue=returnvalue+"窗口长度格式错误！\n";	//窗口长度格式错误
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