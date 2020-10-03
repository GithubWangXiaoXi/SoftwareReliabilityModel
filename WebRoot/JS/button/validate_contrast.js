function validate_contrast(form)	//在确认提交对比数据前，对当前条件进行验证
{
	var returnvalue="";		//声明一个返回空字符串，如果函数运行结束时字符串有内容，那代表验证不通过
	var check_array=document.getElementsByName("select");	//提取选择模型号
	var checkednumber=0;
	for(var i=0;i<check_array.length;i++)		//通过遍历得到被选中模型总数
	{
		if(check_array[i].checked==true) checkednumber++;	
	}
	if(checkednumber<1)		//被选中模型数不能为空
	{
		returnvalue="请选择对比模型！";
	}
	if(checkednumber>10)	//被选中模型数不能超过10个
	{
		returnvalue="对比模型不能超过10个！";
	}
	if(returnvalue=="")
	{
		document.getElementById("loader_container").style.display="block"; 
		//把执行等待滚动条打开
		document.getElementById("flag").value++;	//启动检查通过标志
		return true;
	}
	else
	{
		alert(returnvalue);		//如果returnvalue有内容，代表有错误
		return false;
	}
}