function validate_JM(form,type)		//ARIMAģ���ύ��֤
{
	var returnvalue="";		//����һ�����ؿ��ַ���������������н���ʱ�ַ��������ݣ��Ǵ�����֤��ͨ��
	if(type=="1")
	{
		var prestep=form.prestep.value;		//��ȡԤ�ⲽ��
		if(!isNaN(prestep)&&parseInt(prestep)==prestep)		//����Ԥ�ⲽ������������
		{
			if(prestep<0||prestep>100)
			{
				returnvalue=returnvalue+"Ԥ�ⲽ�����뷶ΧΪ0-100��\n";
			}
		}
		else
		{
			returnvalue=returnvalue+"Ԥ�ⲽ�������ʽ����\n";
		}
	}
	var cs1=form.JM_parameter1.value;
	var cs2=form.JM_parameter2.value;
	if(!isNaN(cs1))			//���˲���1����������
	{
		if(cs1<=0||cs1>1)
		{
			returnvalue=returnvalue+"��������ex���뷶ΧΪ0-1��\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"��������ex�����ʽ����\n";
	}
	if(!isNaN(cs2))			//���˲���2����������
	{
		if(cs2<=0||cs2>1)
		{
			returnvalue=returnvalue+"��������ey���뷶ΧΪ0-1��\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"��������ey�����ʽ����\n";
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
				document.parameterform.target="MODIFYPARAMETER";
				document.parameterform.submit();
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