function saveparameter()
{
  	var model=document.getElementById("model").value;	//提取模型名
  	eval("validate_"+model+"(parameterform,2);");		//执行对应模型名的表单验证函数
}