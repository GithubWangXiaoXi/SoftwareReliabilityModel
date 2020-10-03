function validate_PLR()
{
	document.getElementById("loader_container").style.display="block";
	//把执行等待滚动条打开
	document.getElementById("flag").value++;	//启动检查通过标志
	return true;
}