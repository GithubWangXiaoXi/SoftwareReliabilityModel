function saveparameter()
{
  	var model=document.getElementById("model").value;	//��ȡģ����
  	eval("validate_"+model+"(parameterform,2);");		//ִ�ж�Ӧģ�����ı���֤����
}