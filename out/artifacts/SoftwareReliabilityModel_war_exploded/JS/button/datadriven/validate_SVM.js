function validate_SVM(form,type)		//SVMģ���ύ��֤
{
	var returnvalue="";		//����һ�����ؿ��ַ���������������н���ʱ�ַ��������ݣ��Ǵ�����֤��ͨ��
	if(type=="1")
	{
		var prestep=form.prestep.value;		//��ȡԤ�ⲽ��
		if(!isNaN(prestep)&&parseInt(prestep)==prestep)		//����Ԥ�ⲽ������������
		{
			if(prestep<1||prestep>100)
			{
				returnvalue=returnvalue+"Ԥ�ⲽ�����뷶ΧΪ1-100��\n";
			}
		}
		else
		{
			returnvalue=returnvalue+"Ԥ�ⲽ�������ʽ����\n";
		}
	}
	var cs3=form.SVM_parameter3.value;
	var cs4=form.SVM_parameter4.value;
	var cs5=form.SVM_parameter5.value;
	var cs6=form.SVM_parameter6.value;
	var cs7=form.SVM_parameter7.value;
	var cs8=form.SVM_parameter7.value;
	if(!isNaN(cs3))			//���˲���1����������
	{
		if(cs3<=0||cs3>100000)
		{
			returnvalue=returnvalue+"�ͷ�ϵ�����뷶ΧΪ0-100000��\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"�ͷ�ϵ�������ʽ����\n";
	}
	if(!isNaN(cs4))			//���˲���2����������
	{
		if(cs4<0||cs4>1)
		{
			returnvalue=returnvalue+"gammaֵ���뷶ΧΪ0-1��\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"gammaֵ�����ʽ����\n";
	}
	if(!isNaN(cs5))			//���˲���2����������
	{
		if(cs5<0||cs5>1)
		{
			returnvalue=returnvalue+"��ʧ�������뷶ΧΪ0-1��\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"��ʧ���������ʽ����\n";
	}
	if(!isNaN(cs6))			//���˲���2����������
	{
		if(cs6<0||cs6>1)
		{
			returnvalue=returnvalue+"nu�������뷶ΧΪ0-1��\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"nu���������ʽ����\n";
	}
	if(!isNaN(cs7))			//���˲���2����������
	{
		if(cs7<0||cs7>1)
		{
			returnvalue=returnvalue+"S�ͺ˲������뷶ΧΪ0-1��\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"S�ͺ˲��������ʽ����\n";
	}
	if(!isNaN(cs8))			//���˲���2����������
	{
		if(cs8<0||cs8>1)
		{
			returnvalue=returnvalue+"��ֹ�������뷶ΧΪ0-1��\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"��ֹ���������ʽ����\n";
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