function validate_Combination(form)		//���ģ���ύ�ύ��֤
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
		returnvalue=returnvalue+"Ԥ�ⲽ�������ʽ����\n";	//Ԥ�ⲽ�������ʽ����
	}
	if(returnvalue=="")
	{
		document.getElementById("loader_container").style.display="block";	//��ʾִ�еȴ�������
		document.getElementById("flag").value++;	//�������ͨ����־
		return true;
	}
	else
	{
		alert(returnvalue);		//���returnvalue�����ݣ������д���
		return false;
	}
}