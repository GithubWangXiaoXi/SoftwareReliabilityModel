function validate_EMD_resolve(form)		//EMD�ֽ��ύ��֤
{
	var returnvalue="";		//����һ�����ؿ��ַ���������������н���ʱ�ַ��������ݣ��Ǵ�����֤��ͨ��
	var cs1=form.EMD_parameter1.value;	//��ȡ��ֵ
	var cs2=form.EMD_parameter2.value;	//��ȡ���ֽ����

	if(!isNaN(cs1))			//������ֵ����������
	{
		if(cs1<=0)
		{
			returnvalue=returnvalue+"��ֵ�������0��\n";	//��ֵ�������0
		}
	}
	else
	{
		returnvalue=returnvalue+"��ֵ�����ʽ����\n";		//��ֵ�����ʽ����
	}
	if(!isNaN(cs2)&&parseInt(cs2)==cs2)			//�������ֽ��������������
	{
		if(cs2<2||cs2>9)
		{
			returnvalue=returnvalue+"���ֽ�����ķ�ΧΪ2-9��\n";	//���ֽ�����ķ�ΧΪ2-9
		}
	}
	else
	{
		returnvalue=returnvalue+"���ֽ������ʽ����\n";		//���ֽ������ʽ����
	}
	
	if(returnvalue=="")
	{
		document.getElementById("loader_container").style.display="block";
		//��ִ�еȴ���������
		document.getElementById("mergerflag").value="0";	//mergerflag��0
		document.getElementById("flag").value++;	//�������ͨ����־
		return true;
	}
	else
	{
		alert(returnvalue);		//���returnvalue�����ݣ������д���
		return false;
	}
}