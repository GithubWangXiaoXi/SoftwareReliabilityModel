function validate_fileinput(form)	//�ļ�������֤
{
	var returnvalue = "";
	var name = form.fileinput.value;
	if(name == "")	//�����ļ�·��
	{
		returnvalue=returnvalue+"�������ļ�·����";
	}
	else
	{
		var extension = getextension(name);
		if(!(extension == "xls"||extension=="txt"||extension=="csv"))	//ֻ����3�и�ʽ���ļ����ܵ���
		{
			returnvalue=returnvalue+"�ļ�·������ʽ����";
		}
	}
	if(returnvalue=="")
	{
		document.getElementById("loader_container").style.display="block";
		return true;
	}
	else
	{
		alert(returnvalue);		//���returnvalue�����ݣ������д���
		return false;
	}
}

function getextension(pathfilename)  	//�����ļ������׺��
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