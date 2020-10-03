function validata_merger(form)
{
	var returnvalue="";		//声明一个返回空字符串，如果函数运行结束时字符串有内容，那代表验证不通过
	var prestep=form.prestep.value;		//提取预测步长
	if(!isNaN(prestep)&&parseInt(prestep)==prestep)		//过滤预测步长的奇异输入
	{
		if(prestep<0||prestep>100)
		{
			returnvalue=returnvalue+"预测步长输入范围为0-100！\n";	//预测步长输入范围为0-100
		}
	}
	else
	{
		returnvalue=returnvalue+"预测步长输入格式错误！\n";		//预测步长输入格式错误
	}
	if(returnvalue=="")
	{
		parent.document.getElementById("loader_container").style.display="block";
		//把执行等待滚动条打开
		parent.document.getElementById("mergerflag").value++;	//mergerflag置0
		return true;
	}
	else
	{
		alert(returnvalue);		//如果returnvalue有内容，代表有错误
		return false;
	}
}

function validata_combination(form)
{
	var resolvenumber = document.getElementById("resolvenumber").value;	//提取分解个数
	var check = document.getElementsByName("select");	//提取选择合并分解数
	var count = 0;
	for(var i=0;i<check.length;i++)
	{
		if(check[i].checked == true) count++;	//遍历check，以获取被选中的check
	}
	if(resolvenumber==count)
	{
		alert("合并后的分解数不少于2个！");	//合并后的分解数不少于2个
		return false;
	}
	if(count<=1)
	{
		alert("合并必须选择两个以上分解名！");	//合并必须选择两个以上分解名
		return false;
	}
	if(confirm("确定要合并吗？"))
	{
		parent.document.getElementById("loader_container").style.display="block";
		//把执行等待滚动条打开
		return true;
	}
	return false;
}

function aftersame(n)
{
	var x=document.getElementById("modelselect"+n.toString()).value;
	//提取当前选中的模型名
	for(var i=n;i<=document.getElementById("resolvenumber").value;i++)
	{
	document.getElementById("modelselect"+i.toString()).value=x;
	//在n之后的所有模型名都改为当前选中的模型名
	}
}