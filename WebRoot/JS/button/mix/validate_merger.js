function validata_merger(form)
{
	var returnvalue="";		//����һ�����ؿ��ַ���������������н���ʱ�ַ��������ݣ��Ǵ�����֤��ͨ��
	var prestep=form.prestep.value;		//��ȡԤ�ⲽ��
	if(!isNaN(prestep)&&parseInt(prestep)==prestep)		//����Ԥ�ⲽ������������
	{
		if(prestep<0||prestep>100)
		{
			returnvalue=returnvalue+"Ԥ�ⲽ�����뷶ΧΪ0-100��\n";	//Ԥ�ⲽ�����뷶ΧΪ0-100
		}
	}
	else
	{
		returnvalue=returnvalue+"Ԥ�ⲽ�������ʽ����\n";		//Ԥ�ⲽ�������ʽ����
	}
	if(returnvalue=="")
	{
		parent.document.getElementById("loader_container").style.display="block";
		//��ִ�еȴ���������
		parent.document.getElementById("mergerflag").value++;	//mergerflag��0
		return true;
	}
	else
	{
		alert(returnvalue);		//���returnvalue�����ݣ������д���
		return false;
	}
}

function validata_combination(form)
{
	var resolvenumber = document.getElementById("resolvenumber").value;	//��ȡ�ֽ����
	var check = document.getElementsByName("select");	//��ȡѡ��ϲ��ֽ���
	var count = 0;
	for(var i=0;i<check.length;i++)
	{
		if(check[i].checked == true) count++;	//����check���Ի�ȡ��ѡ�е�check
	}
	if(resolvenumber==count)
	{
		alert("�ϲ���ķֽ���������2����");	//�ϲ���ķֽ���������2��
		return false;
	}
	if(count<=1)
	{
		alert("�ϲ�����ѡ���������Ϸֽ�����");	//�ϲ�����ѡ���������Ϸֽ���
		return false;
	}
	if(confirm("ȷ��Ҫ�ϲ���"))
	{
		parent.document.getElementById("loader_container").style.display="block";
		//��ִ�еȴ���������
		return true;
	}
	return false;
}

function aftersame(n)
{
	var x=document.getElementById("modelselect"+n.toString()).value;
	//��ȡ��ǰѡ�е�ģ����
	for(var i=n;i<=document.getElementById("resolvenumber").value;i++)
	{
	document.getElementById("modelselect"+i.toString()).value=x;
	//��n֮�������ģ��������Ϊ��ǰѡ�е�ģ����
	}
}