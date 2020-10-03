function validate_dataformat_manual(form)	//预导入数据格式验证
{
	var n=5;
	var returnvalue="";
	var number = form.number.value;
	var dimension = form.dimension.value;
	for(var i=1;i<=dimension;i++)		//验证每个数据的格式以及范围
	{
		for(var j = 1;j <= number; j++)
		{
			var data = document.getElementById("data_"+j+"_"+i).value;
			if(n>0)
			{
				if(data == "")
				{
					returnvalue = returnvalue+"第"+i+"列，第"+j+"行：数据不能为空！\n";
					n--;
				}
				else
				{
					if(!isNaN(data))
					{
						if(data < 0||data > 1000000000000000000000)
						{
							returnvalue = returnvalue+"第"+i+"列，第"+j+"行：数据输入范围为0-10000000！\n";
							n--;
						}
					}
					else
					{
						returnvalue = returnvalue+"第"+i+"列，第"+j+"行：数据格式错误！\n";
						n--;
					}
				}
			}
		}
	}
	if(returnvalue == "")
	{
		if(confirm("确定要提交吗？"))	//确定提交后，跳转到数据导入设置窗口
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
		alert(returnvalue);		//如果returnvalue有内容，代表有错误
		return false;
	}
}


function validate_dataformat_file(form)		//文件截取的格式验证
{
	var head = document.getElementById("Interception_head").value;
	var tail = document.getElementById("Interception_tail").value; 
	var number = tail - head + 1;
	/*if(number<10)	//数据总数不能少于10个
	{
		alert("数据总数不能少于10个！");
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
						returnvalue=returnvalue+"第"+i+"列，第"+j+"行：数据不能为空！\n";
						n--;
					}
					else
					{
						if(!isNaN(data))
						{
							if(data<0||data>10000000000000000000000)
							{
								returnvalue=returnvalue+"第"+i+"列，第"+j+"行：数据输入范围为0-10000000！\n";
								n--;
							}
						}
						else
						{
							returnvalue=returnvalue+"第"+i+"列，第"+j+"行：数据格式错误！\n";
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
		alert("请选择需要导入的列！");
		return false;
	}
	//alert(111);
	if(returnvalue=="")
	{
		if(confirm("确定要提交吗？"))
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
		alert(returnvalue);		//如果returnvalue有内容，代表有错误
		return false;
	}
}