function input_next(name)	//数据导入窗体中下一步按钮的触发事件
{
	if(name=="file")
	{
		parent.document.getElementById("loader_container").style.display="none";
		//把执行等待滚动条打开
	}
	//alert(name);
	parent.document.getElementById(name+"1").style.display="none";	//关闭当前页面
	parent.document.getElementById(name+"2").style.display="block";	//跳到下个页面
}
function input_return(name)	//数据导入窗体中上一步按钮的触发事件
{
	if(name=="oracle"){
	parent.document.getElementById(name+"2").style.display="none";	//关闭当前页面
		parent.document.getElementById(name+"1").style.display="block";	//跳刀上个页面
	}else{
	if(confirm("数据未保存，确定返回码？"))
	{
		parent.document.getElementById(name+"2").style.display="none";	//关闭当前页面
		parent.document.getElementById(name+"1").style.display="block";	//跳刀上个页面
	}
	}
}
