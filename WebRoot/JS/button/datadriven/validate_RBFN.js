function validate_RBFN(form,type)		//RBFNģ���ύ��֤
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
	var cs1=form.RBFN_parameter1.value;		//��ȡ�ع�ά��
	var cs2=form.RBFN_parameter2.value;		//��ȡ�������ϵ��
	if(!isNaN(cs1)&&parseInt(cs1)==cs1)		//�����ع�ά������������
	{
		if(cs1<3||cs1>10)
		{
			returnvalue=returnvalue+"�ع�ά�����뷶ΧΪ3-10��\n";	//�ع�ά�����뷶ΧΪ3-10
		}
	}
	else
	{
		returnvalue=returnvalue+"�ع�ά�������ʽ����\n";	//�ع�ά�������ʽ����
	}
	if(!isNaN(cs2))			//�����������ϵ������������
	{
		if(cs2<=0||cs2>1)
		{
			returnvalue=returnvalue+"�������ϵ�����뷶ΧΪ0-1��\n";	//�������ϵ�����뷶ΧΪ0-1
		}
	}
	else
	{
		returnvalue=returnvalue+"�������ϵ�������ʽ����\n";	//�������ϵ�������ʽ����
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
				document.parameterform.submit();	//�ύ��
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