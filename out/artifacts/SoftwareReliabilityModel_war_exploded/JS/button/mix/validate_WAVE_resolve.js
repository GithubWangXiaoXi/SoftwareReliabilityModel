function validate_WAVE_resolve(form)		//WAVE�ֽ��ύ��֤
{
	var returnvalue="";		//����һ�����ؿ��ַ���������������н���ʱ�ַ��������ݣ��Ǵ�����֤��ͨ��
	var cs1=form.WAVE_parameter1.value;
	var cs2=form.WAVE_parameter2.value;
	if(!isNaN(cs1)||parseInt(cs1)==cs1)		//���˷ֽ�ά������������
	{
		if(cs1<2||cs1>10)
		{
			returnvalue=returnvalue+"�ֽ�ά�����뷶ΧΪ2-10��\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"�ֽ�ά�������ʽ����\n";
	}
	if(!isNaN(cs2))			//���˲���2����������
	{
		if(cs2<=0||cs2>1)
		{
			returnvalue=returnvalue+"����2���뷶ΧΪ0-1��\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"����2�����ʽ����\n";
	}
	if(returnvalue=="")
	{
		document.getElementById("loader_container").style.display="block";
		//��ִ�еȴ���������
		document.getElementById("mergerflag").value="0";
		document.getElementById("flag").value++;	//�������ͨ����־
		return true;
	}
	else
	{
		alert(returnvalue);		//���returnvalue�����ݣ������д���
		return false;
	}
}