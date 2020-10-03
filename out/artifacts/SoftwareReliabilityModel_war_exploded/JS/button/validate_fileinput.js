function validate_fileinput(form)	//文件导入验证
{
	var returnvalue = "";
	var name = form.fileinput.value;
	if(name == "")	//输入文件路径
	{
		returnvalue=returnvalue+"请输入文件路径！";
	}
	else
	{
		var extension = getextension(name);
		if(!(extension == "xls"||extension=="txt"||extension=="csv"))	//只有这3中格式的文件才能导入
		{
			returnvalue=returnvalue+"文件路径名格式错误！";
		}
	}
	if(returnvalue=="")
	{
		document.getElementById("loader_container").style.display="block";
		return true;
	}
	else
	{
		alert(returnvalue);		//如果returnvalue有内容，代表有错误
		return false;
	}
}

function getextension(pathfilename)  	//分离文件名与后缀名
{  
    var reg = /(\\+)/g;
    var pfn = pathfilename.replace(reg, "#");
    var arrpfn = pfn.split("#");
    var fn = arrpfn[arrpfn.length - 1];
    var arrfn = fn.split(".");
    return arrfn[arrfn.length - 1];
}

function isCon() 
{  
	var user = document.getElementById("user").value;
	var password = document.getElementById("password").value;
    alert(user);
}