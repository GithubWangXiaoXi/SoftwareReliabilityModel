function validate_datasetup(form)	//验证数据导入表单
{
	var n=5;
	var returnvalue="";
	var dataname=form.data_name.value;
	var dimension=form.dimension.value;
	var datadescription=form.data_description.value;
	if(dataname.length==0)		//数据名称不能为空
	{
		returnvalue=returnvalue+"数据名称不能为空！\n";
		n--;
	}
	else if(dataname.length>100)		//数据名称不能超过10个字
	{
		returnvalue=returnvalue+"数据名称不能超过100个字！\n";
		n--;
	}
	if(datadescription.length==0)		//数据描述不能为空
	{
		returnvalue=returnvalue+"数据描述不能为空！\n";
		n--;
	}
	else if(datadescription.length>100)		//数据描述不能超过100个字
	{
		returnvalue=returnvalue+"数据描述不能超过100个字！\n";
		n--;
	}
	for(var i=1;i<=dimension;i++)	//行列不能为空，也不能超过10个子
	{
		if(n>0)
		{
			var colname=document.getElementById("colname"+i).value;
			if(colname.length==0)
			{
				returnvalue=returnvalue+"数据第"+i+"列名称不能为空！\n";
				n--;
			}
			else if(colname.length>100)
			{
				returnvalue=returnvalue+"数据第"+i+"列名称不能超过100个字！\n";
				n--;
			}
		}
	}

	if(returnvalue=="")
	{
		if(confirm("注意！如果导入该数据，对比数据记录将清空，确定要导入吗？"))
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