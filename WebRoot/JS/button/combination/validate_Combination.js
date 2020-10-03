function validate_Combination(form)		//组合模型提交提交验证
{
	var returnvalue="";		//声明一个返回空字符串，如果函数运行结束时字符串有内容，那代表验证不通过
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
		returnvalue=returnvalue+"预测步长输入格式错误！\n";	//预测步长输入格式错误
	}
	if(returnvalue=="")
	{
		document.getElementById("loader_container").style.display="block";	//显示执行等待滚动条
		document.getElementById("flag").value++;	//启动检查通过标志
		return true;
	}
	else
	{
		alert(returnvalue);		//如果returnvalue有内容，代表有错误
		return false;
	}
}