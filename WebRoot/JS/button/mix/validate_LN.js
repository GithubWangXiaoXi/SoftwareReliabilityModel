function validate_LN_resolve(form)		//L+N�ֽ��ύ��֤
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
		document.getElementById("loader_container").style.display="block";
		//��ִ�еȴ���������
		document.getElementById("mergerflag").value="0";	//mergerflag��0
		document.getElementById("flag").value++;	//�������ͨ����־
	}
	else
	{
		alert(returnvalue);		//���returnvalue�����ݣ������д���
		return false;
	}
}

function validata_LN_merger(form)
{
	parent.document.getElementById("loader_container").style.display="block";
	//��ִ�еȴ���������
	parent.document.getElementById("mergerflag").value++;	//mergerflag��1
	return true;
}