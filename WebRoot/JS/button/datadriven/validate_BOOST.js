function validate_BOOST(form,type)		//BOOSTģ���ύ��֤
{
	var returnvalue="";		//����һ�����ؿ��ַ���������������н���ʱ�ַ��������ݣ��Ǵ�����֤��ͨ��
	var height = form.height.value;
	var times = form.times.value;
	var threshold = form.threshold.value;
	var dimension = form.dimension.value;
	var val = Number(dimension);
	if(!isNaN(height))			//���˲���1����������
	{
		if(height <= 1 || height > dimension + 1)
		{
			returnvalue=returnvalue+"���ĸ߶����뷶ΧΪ2-" + val + "��\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"���ĸ߶������ʽ����\n";
	}
	if(!isNaN(times))			//���˲���2����������
	{
		if(times<0||times>1000)
		{
			returnvalue=returnvalue+"ѵ���������뷶ΧΪ0-1000��\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"ѵ�����������ʽ����\n";
	}
	if(!isNaN(threshold))			//���˲���2����������
	{
		if(threshold < 0 || threshold > 1)
		{
			returnvalue=returnvalue+"�����ֵ���뷶ΧΪ0-1��\n";
		}
	}
	else
	{
		returnvalue=returnvalue+"�����ֵ�����ʽ����\n";
	}
	if(returnvalue=="")
	{
		if(type=="1")
		{
            // alert(1)
			document.getElementById("loader_container").style.display="block";
			//��ִ�еȴ���������
			document.getElementById("flag").value++;	//�������ͨ����־
			return true;
		}
		if(type=="2")
		{
            // alert(2)
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
            // alert(3)
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