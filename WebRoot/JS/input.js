function input_next(name)	//���ݵ��봰������һ����ť�Ĵ����¼�
{
	if(name=="file")
	{
		parent.document.getElementById("loader_container").style.display="none";
		//��ִ�еȴ���������
	}
	//alert(name);
	parent.document.getElementById(name+"1").style.display="none";	//�رյ�ǰҳ��
	parent.document.getElementById(name+"2").style.display="block";	//�����¸�ҳ��
}
function input_return(name)	//���ݵ��봰������һ����ť�Ĵ����¼�
{
	if(name=="oracle"){
	parent.document.getElementById(name+"2").style.display="none";	//�رյ�ǰҳ��
		parent.document.getElementById(name+"1").style.display="block";	//�����ϸ�ҳ��
	}else{
	if(confirm("����δ���棬ȷ�������룿"))
	{
		parent.document.getElementById(name+"2").style.display="none";	//�رյ�ǰҳ��
		parent.document.getElementById(name+"1").style.display="block";	//�����ϸ�ҳ��
	}
	}
}
