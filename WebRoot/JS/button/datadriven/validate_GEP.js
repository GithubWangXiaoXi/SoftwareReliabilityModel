function validate_GEP(form,type)		//GEPģ���ύ��֤
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
	var cs1=form.GEP_parameter1.value;		//��ȡ��Ⱥ��С
	var cs2=form.GEP_parameter2.value;		//��ȡ�ع�ά��
	var cs3=form.GEP_parameter3.value;		//��ȡ����ͷ������
	var cs4=form.GEP_parameter4.value;		//��ȡ��������
	var cs5=form.GEP_parameter5.value;		//��ȡ����������
	var cs6=form.GEP_parameter6.value;		//��ȡISǨ�Ƹ���
	var cs7=form.GEP_parameter7.value;		//��ȡRISǨ�Ƹ���
	var cs8=form.GEP_parameter8.value;		//��ȡ�����������
	var cs9=form.GEP_parameter9.value;		//��ȡ˫���������
	var cs10=form.GEP_parameter10.value;	//��ȡ�����������
	var cs11=form.GEP_parameter11.value;	//��ȡѵ������
	var cs12=form.GEP_parameter12.value;	//��ȡ��ֵ
	if(!isNaN(cs1)&&parseInt(cs1)==cs1)		//������Ⱥ��С����������
	{
		if(cs1<30||cs1>100)
		{
			returnvalue=returnvalue+"��Ⱥ��С���뷶ΧΪ30-100��\n";	//��Ⱥ��С���뷶ΧΪ30-100
		}
	}
	else
	{
		returnvalue=returnvalue+"��Ⱥ��С�����ʽ����\n";	//��Ⱥ��С�����ʽ����
	}
	if(!isNaN(cs2)&&parseInt(cs2)==cs2)			//�����ع�ά������������
	{
		if(cs2<3||cs2>10)
		{
			returnvalue=returnvalue+"�ع�ά�����뷶ΧΪ3-10��\n";	//�ع�ά�����뷶ΧΪ3-10
		}
	}
	else
	{
		returnvalue=returnvalue+"�ع�ά�������ʽ����\n";	//�ع�ά�������ʽ����
	}
	if(!isNaN(cs3)&&parseInt(cs3)==cs3)			//���˻���ͷ�����ȵ���������
	{
		if(cs3<5||cs3>15)
		{
			returnvalue=returnvalue+"����ͷ���������뷶ΧΪ5-15��\n";	//����ͷ���������뷶ΧΪ5-15
		}
	}
	else
	{
		returnvalue=returnvalue+"����ͷ�����������ʽ����\n";	//����ͷ�����������ʽ����
	}
	if(!isNaN(cs4)&&parseInt(cs4)==cs4)			//���˻�����������������
	{
		if(cs4<2||cs4>10)
		{
			returnvalue=returnvalue+"�����������뷶ΧΪ2-10��\n";	//�����������뷶ΧΪ2-10
		}
	}
	else
	{
		returnvalue=returnvalue+"�������������ʽ����\n";	//�������������ʽ����
	}
	if(!isNaN(cs5))			//���˻��������ʵ���������
	{
		if(cs5<0||cs5>1)
		{
			returnvalue=returnvalue+"�������������뷶ΧΪ0-1��\n";	//�������������뷶ΧΪ0-1
		}
	}
	else
	{
		returnvalue=returnvalue+"���������������ʽ����\n";	//���������������ʽ����
	}
	if(!isNaN(cs6))		//����ISǨ�Ƹ��ʵ���������	
	{
		if(cs6<0||cs6>1)
		{
			returnvalue=returnvalue+"ISǨ�Ƹ������뷶ΧΪ0-1��\n";	//ISǨ�Ƹ������뷶ΧΪ0-1
		}
	}
	else
	{
		returnvalue=returnvalue+"ISǨ�Ƹ��������ʽ����\n";		//ISǨ�Ƹ��������ʽ����
	}
	if(!isNaN(cs7))		//����RISǨ�Ƹ��ʵ���������	
	{
		if(cs7<0||cs7>1)
		{
			returnvalue=returnvalue+"RISǨ�Ƹ������뷶ΧΪ0-1��\n";	//RISǨ�Ƹ������뷶ΧΪ0-1
		}
	}
	else
	{
		returnvalue=returnvalue+"RISǨ�Ƹ��������ʽ����\n";	//RISǨ�Ƹ��������ʽ����
	}
	if(!isNaN(cs8))			//���˵���������ʵ���������
	{
		if(cs8<0||cs8>1)
		{
			returnvalue=returnvalue+"��������������뷶ΧΪ0-1��\n";	//��������������뷶ΧΪ0-1
		}
	}
	else
	{
		returnvalue=returnvalue+"����������������ʽ����\n";	//����������������ʽ����
	}
	if(!isNaN(cs9))			//����˫��������ʵ���������
	{
		if(cs9<0||cs9>1)
		{
			returnvalue=returnvalue+"˫������������뷶ΧΪ0-1��\n";	//˫������������뷶ΧΪ0-1
		}
	}
	else
	{
		returnvalue=returnvalue+"˫��������������ʽ����\n";	//˫��������������ʽ����
	}
	if(!isNaN(cs10))			//���˻���������ʵ���������
	{
		if(cs10<0||cs10>1)
		{
			returnvalue=returnvalue+"��������������뷶ΧΪ0-1��\n";	//��������������뷶ΧΪ0-1
		}
	}
	else
	{
		returnvalue=returnvalue+"����������������ʽ����\n";	//����������������ʽ����
	}
	if(!isNaN(cs11)&&parseInt(cs11)==cs11)	//����ѵ����������������
	{
		if(cs11<10||cs11>100000)
		{
			returnvalue=returnvalue+"ѵ���������뷶ΧΪ10-100000��\n";	//ѵ���������뷶ΧΪ10-100000
		}
	}
	else
	{
		returnvalue=returnvalue+"ѵ�����������ʽ����\n";	//ѵ�����������ʽ����
	}
	if(!isNaN(cs12))		//������ֵ����������
	{
		if(cs12<0||cs12>100)
		{
			returnvalue=returnvalue+"��ֵ���뷶ΧΪ0-1��\n";	//��ֵ���뷶ΧΪ0-100
		}
	}
	else
	{
		returnvalue=returnvalue+"��ֵ�����ʽ����\n";	//��ֵ�����ʽ����
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