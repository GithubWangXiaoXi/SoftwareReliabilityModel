function validate_dataformat_manual(form)	//Ԥ�������ݸ�ʽ��֤
{
	var n=5;
	var returnvalue="";
	var number = form.number.value;
	var dimension = form.dimension.value;
	for(var i=1;i<=dimension;i++)		//��֤ÿ�����ݵĸ�ʽ�Լ���Χ
	{
		for(var j = 1;j <= number; j++)
		{
			var data = document.getElementById("data_"+j+"_"+i).value;
			if(n>0)
			{
				if(data == "")
				{
					returnvalue = returnvalue+"��"+i+"�У���"+j+"�У����ݲ���Ϊ�գ�\n";
					n--;
				}
				else
				{
					if(!isNaN(data))
					{
						if(data < 0||data > 1000000000000000000000)
						{
							returnvalue = returnvalue+"��"+i+"�У���"+j+"�У��������뷶ΧΪ0-10000000��\n";
							n--;
						}
					}
					else
					{
						returnvalue = returnvalue+"��"+i+"�У���"+j+"�У����ݸ�ʽ����\n";
						n--;
					}
				}
			}
		}
	}
	if(returnvalue == "")
	{
		if(confirm("ȷ��Ҫ�ύ��"))	//ȷ���ύ����ת�����ݵ������ô���
		{
			parent.document.getElementById("INPUT_tab1").className="";
			parent.document.getElementById("INPUT_tab4").className="hover";
			parent.document.getElementById("INPUT_con1").style.display="none";
			parent.document.getElementById("INPUT_tab4").style.display="block";
			parent.document.getElementById("INPUT_con4").style.display="block";
			return true;
		}
		return false;
	}
	else
	{
		if(n==0) returnvalue=returnvalue+"......";
		alert(returnvalue);		//���returnvalue�����ݣ������д���
		return false;
	}
}


function validate_dataformat_file(form)		//�ļ���ȡ�ĸ�ʽ��֤
{
	var head = document.getElementById("Interception_head").value;
	var tail = document.getElementById("Interception_tail").value; 
	var number = tail - head + 1;
	/*if(number<10)	//����������������10��
	{
		alert("����������������10����");
		return false;
	}*/
	var n=5;
	var returnvalue="";
	var check_array = document.getElementsByName("check");
	var count = 0;
	for(var i=1;i<=check_array.length;i++)
	{
		if(check_array[i-1].checked == true)
		{
			for(var j=parseInt(head); j<=parseInt(tail); j++)
			{				
				if(n>0)
				{
					var data=document.getElementById("predata_"+j+"_"+i).value;
					if(data=="")
					{
						returnvalue=returnvalue+"��"+i+"�У���"+j+"�У����ݲ���Ϊ�գ�\n";
						n--;
					}
					else
					{
						if(!isNaN(data))
						{
							if(data<0||data>10000000000000000000000)
							{
								returnvalue=returnvalue+"��"+i+"�У���"+j+"�У��������뷶ΧΪ0-10000000��\n";
								n--;
							}
						}
						else
						{
							returnvalue=returnvalue+"��"+i+"�У���"+j+"�У����ݸ�ʽ����\n";
							n--;
						}
					}
				}
			}
			count++;
		}
	}
	if(count==0)
	{
		alert("��ѡ����Ҫ������У�");
		return false;
	}
	//alert(111);
	if(returnvalue=="")
	{
		if(confirm("ȷ��Ҫ�ύ��"))
		{
			var col = 1;
			for(var i=1;i<=check_array.length;i++)
			{
				if(check_array[i-1].checked == true)
				{
					row =1;
					for(var j=parseInt(head); j<=parseInt(tail); j++)
					{
						document.getElementById("data_"+row+"_"+col).value =
							document.getElementById("predata_"+j+"_"+i).value;
						row++;
					}
					col++;
				}
			}
			form.number.value = number;
			form.dimension.value = count;
			parent.document.getElementById("INPUT_tab2").className="";
			parent.document.getElementById("INPUT_tab3").className="";
			parent.document.getElementById("INPUT_tab4").className="hover";
			parent.document.getElementById("INPUT_con2").style.display="none";
			parent.document.getElementById("INPUT_con3").style.display="none";
			parent.document.getElementById("INPUT_tab4").style.display="block";
			parent.document.getElementById("INPUT_con4").style.display="block";
			return true;
		}
		return false;
	}
	else
	{
		if(n==0) returnvalue=returnvalue+"......";
		alert(returnvalue);		//���returnvalue�����ݣ������д���
		return false;
	}
}