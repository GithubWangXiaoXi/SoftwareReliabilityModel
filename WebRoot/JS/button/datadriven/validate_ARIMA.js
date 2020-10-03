function validate_ARIMA(form,type)		//ARIMAģ���ύ��֤
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
			returnvalue=returnvalue+"Ԥ�ⲽ�������ʽ����\n";	//Ԥ�ⲽ�������ʽ����
		}
	}
	var cs1=form.ARIMA_parameter1.value;
	var cs2=form.ARIMA_parameter2.value;
	var cs3=form.ARIMA_parameter3.value;
	var cs4=form.ARIMA_parameter4.value;	
	if(!isNaN(cs1))			//���˲���1����������
	{
		if(cs1<=0||cs1>1)
		{
			returnvalue=returnvalue+"����1���뷶ΧΪ0-1��\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"ѧ����1�����ʽ����\n";
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
		returnvalue=returnvalue+"ѧ����2�����ʽ����\n";
	}
	if(!isNaN(cs3))			//���˲���3����������
	{
		if(cs3<=0||cs3>1)
		{
			returnvalue=returnvalue+"����3���뷶ΧΪ0-1��\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"ѧ����3�����ʽ����\n";
	}
	if(!isNaN(cs4))			//���˲���4����������
	{
		if(cs4<=0||cs4>1)
		{
			returnvalue=returnvalue+"����4���뷶ΧΪ0-1��\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"ѧ����4�����ʽ����\n";
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