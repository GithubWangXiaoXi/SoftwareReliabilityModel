function validate_BPN(form,type)		//BPNģ���ύ��֤
{
	var returnvalue="";		//����һ�����ؿ��ַ���������������н���ʱ�ַ��������ݣ��Ǵ�����֤��ͨ��
	if(type=="1")
	{
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
	}
	var cs1=form.BPN_parameter1.value;	//��ȡѧϰϵ��
	var cs2=form.BPN_parameter2.value;	//��ȡ�ع�ά��
	var cs3=form.BPN_parameter3.value;	//��ȡѵ������
	var cs4=form.BPN_parameter4.value;	//��ȡ��ֵ
	if(!isNaN(cs1))			//����ѧϰϵ������������
	{
		if(cs1<=0||cs1>1)
		{
			returnvalue=returnvalue+"ѧϰϵ�����뷶ΧΪ0-1��\n";		//ѧϰϵ�����뷶ΧΪ0-1
		}
	}
	else
	{
		returnvalue=returnvalue+"ѧϰϵ�������ʽ����\n";		//ѧϰϵ�������ʽ����
	}
	if(!isNaN(cs2)&&parseInt(cs2)==cs2)		//�����ع�ά������������
	{
		if(cs2<3||cs2>10)
		{
			returnvalue=returnvalue+"�ع�ά�����뷶ΧΪ3-10��\n";	//�ع�ά�����뷶ΧΪ3-10
		}
	}
	else
	{
		returnvalue=returnvalue+"�ع�ά�������ʽ����\n";		//�ع�ά�������ʽ����
	}
	if(!isNaN(cs3)&&parseInt(cs3)==cs3)	//����ѵ����������������
	{
		if(cs3<10||cs3>100000)
		{
			returnvalue=returnvalue+"ѵ���������뷶ΧΪ10-100000��\n";	//ѵ���������뷶ΧΪ10-100000
		}
	}
	else
	{
		returnvalue=returnvalue+"ѵ�����������ʽ����\n";		//ѵ�����������ʽ����
	}
	if(!isNaN(cs4))		//������ֵ����������
	{
		if(cs4<0||cs4>100)
		{
			returnvalue=returnvalue+"��ֵ���뷶ΧΪ0-100��\n";	//��ֵ���뷶ΧΪ0-1
		}
	}
	else
	{
		returnvalue=returnvalue+"��ֵ�����ʽ����\n";		//��ֵ�����ʽ����
	}
	if(returnvalue=="")
	{
		if(type=="1")
		{
			document.getElementById("loader_container").style.display="block";
			//��ִ�еȴ���������
			document.getElementById("flag").value++;	//�������ͨ����־
			return true;
		}
		if(type=="2")
		{
			if(confirm("ȷ��Ҫ����ΪĬ�ϲ�����"))
			{
				document.getElementById("loader_container").style.display="block";
				//��ִ�еȴ���������
				document.parameterform.action="../../datainfo/parameterinfo/saveparameter.jsp";
				//�޸ı��ύҳ���·��
				document.parameterform.target="MODIFYPARAMETER";
				//�޸ı��ύҳ���Ҫ��ʾ�ĵط�
				document.parameterform.submit();
				//�ύ��
			}
			return false;
		}
		if(type=="3")
		{
			if(confirm("ȷ��Ҫ�޸�Ĭ�ϲ�����"))
			{
				return true;
			}
			return false;
		}
	}
	else
	{
		alert(returnvalue);		//���returnvalue�����ݣ������д���
		return false;
	}
}