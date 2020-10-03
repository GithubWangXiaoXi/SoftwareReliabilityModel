function validate_LN_resolve(form)		//L+N分解提交验证
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
		returnvalue=returnvalue+"预测步长输入格式错误！\n";		//预测步长输入格式错误
	}
	if(returnvalue=="")
	{
		document.getElementById("loader_container").style.display="block";
		//把执行等待滚动条打开
		document.getElementById("mergerflag").value="0";	//mergerflag置0
		document.getElementById("flag").value++;	//启动检查通过标志
	}
	else
	{
		alert(returnvalue);		//如果returnvalue有内容，代表有错误
		return false;
	}
}

function validata_LN_merger(form)
{
	parent.document.getElementById("loader_container").style.display="block";
	//把执行等待滚动条打开
	parent.document.getElementById("mergerflag").value++;	//mergerflag置1
	return true;
}