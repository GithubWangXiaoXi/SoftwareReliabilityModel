function validate_contrast(form)	//��ȷ���ύ�Ա�����ǰ���Ե�ǰ����������֤
{
	var returnvalue="";		//����һ�����ؿ��ַ���������������н���ʱ�ַ��������ݣ��Ǵ�����֤��ͨ��
	var check_array=document.getElementsByName("select");	//��ȡѡ��ģ�ͺ�
	var checkednumber=0;
	for(var i=0;i<check_array.length;i++)		//ͨ�������õ���ѡ��ģ������
	{
		if(check_array[i].checked==true) checkednumber++;	
	}
	if(checkednumber<1)		//��ѡ��ģ��������Ϊ��
	{
		returnvalue="��ѡ��Ա�ģ�ͣ�";
	}
	if(checkednumber>10)	//��ѡ��ģ�������ܳ���10��
	{
		returnvalue="�Ա�ģ�Ͳ��ܳ���10����";
	}
	if(returnvalue=="")
	{
		document.getElementById("loader_container").style.display="block"; 
		//��ִ�еȴ���������
		document.getElementById("flag").value++;	//�������ͨ����־
		return true;
	}
	else
	{
		alert(returnvalue);		//���returnvalue�����ݣ������д���
		return false;
	}
}