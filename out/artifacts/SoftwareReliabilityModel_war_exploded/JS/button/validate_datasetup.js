function validate_datasetup(form)	//��֤���ݵ����
{
	var n=5;
	var returnvalue="";
	var dataname=form.data_name.value;
	var dimension=form.dimension.value;
	var datadescription=form.data_description.value;
	if(dataname.length==0)		//�������Ʋ���Ϊ��
	{
		returnvalue=returnvalue+"�������Ʋ���Ϊ�գ�\n";
		n--;
	}
	else if(dataname.length>100)		//�������Ʋ��ܳ���10����
	{
		returnvalue=returnvalue+"�������Ʋ��ܳ���100���֣�\n";
		n--;
	}
	if(datadescription.length==0)		//������������Ϊ��
	{
		returnvalue=returnvalue+"������������Ϊ�գ�\n";
		n--;
	}
	else if(datadescription.length>100)		//�����������ܳ���100����
	{
		returnvalue=returnvalue+"�����������ܳ���100���֣�\n";
		n--;
	}
	for(var i=1;i<=dimension;i++)	//���в���Ϊ�գ�Ҳ���ܳ���10����
	{
		if(n>0)
		{
			var colname=document.getElementById("colname"+i).value;
			if(colname.length==0)
			{
				returnvalue=returnvalue+"���ݵ�"+i+"�����Ʋ���Ϊ�գ�\n";
				n--;
			}
			else if(colname.length>100)
			{
				returnvalue=returnvalue+"���ݵ�"+i+"�����Ʋ��ܳ���100���֣�\n";
				n--;
			}
		}
	}

	if(returnvalue=="")
	{
		if(confirm("ע�⣡�����������ݣ��Ա����ݼ�¼����գ�ȷ��Ҫ������"))
		{
			parent.document.getElementById("loader_container").style.display="block";
			return true;
		}
		return false;
	}
	else
	{
		if(n==0) returnvalue=returnvalue+"......";
		alert(returnvalue);
		return false;
	}
}