function addmodel()	//����ģ��
{
	var number = document.getElementById("number").value;	//��ȡ����ģ����
	if(number>=11)
	{
		alert("����ϵ�ģ�Ͳ�����11����");		//ģ�����Ϊ6��
	}
	else
	{
		number++;
		document.getElementById("model"+number).style.display="block";
	}
	document.getElementById("number").value=number;
}
function submodel()	//����ģ��
{
	var number = document.getElementById("number").value;	//��ȡ����ģ����
	if(number<=2)
	{
		alert("����ϵ�ģ�Ͳ�����2����");		//ģ������Ϊ2��
	}
	else
	{
		document.getElementById("model"+number).style.display="none";
		number--;
	}
	document.getElementById("number").value=number;
}