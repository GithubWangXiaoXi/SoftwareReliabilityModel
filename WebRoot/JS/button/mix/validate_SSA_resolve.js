function validate_SSA_resolve(form)		//SSA�ֽ��ύ��֤
{
	var returnvalue="";		//����һ�����ؿ��ַ���������������н���ʱ�ַ��������ݣ��Ǵ�����֤��ͨ��
	var cs1=form.SSA_parameter1.value;	//��ȡ����׶�
	var cs2=form.SSA_parameter2.value;	//���ڳ���
	var wl=document.getElementById("wl").value;
	if(!isNaN(cs1))		//���˷���׶ȵ���������
	{
		if(cs1<=0||cs1>=1)
		{
			returnvalue=returnvalue+"����׶ȵķ�ΧΪ0-1��\n";		//����׶ȵķ�ΧΪ0-1
		}
	}
	else
	{
		returnvalue=returnvalue+"����׶ȸ�ʽ����\n";	//����׶ȸ�ʽ����
	}
	if(!isNaN(cs2)&&parseInt(cs2)==cs2)		//���˷ֽ�ά������������
	{
		if(cs2<2||cs2>wl)
		{
			returnvalue=returnvalue+"���ڳ��ȵķ�ΧΪ2-"+wl+"��\n";	//���ڳ��ȵķ�Χ
		}
	}
	else
	{
		returnvalue=returnvalue+"���ڳ��ȸ�ʽ����\n";	//���ڳ��ȸ�ʽ����
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