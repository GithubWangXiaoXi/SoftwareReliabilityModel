function validate_GEP(form,type)		//GEP模型提交验证
{
	var returnvalue="";		//声明一个返回空字符串，如果函数运行结束时字符串有内容，那代表验证不通过
	if(type=="1")
	{
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
			returnvalue=returnvalue+"预测步长输入格式错误！\n";	//预测步长输入格式错误
		}
	}
	var cs1=form.GEP_parameter1.value;		//提取种群大小
	var cs2=form.GEP_parameter2.value;		//提取重构维数
	var cs3=form.GEP_parameter3.value;		//提取基因头部长度
	var cs4=form.GEP_parameter4.value;		//提取基因数量
	var cs5=form.GEP_parameter5.value;		//提取基因变异概率
	var cs6=form.GEP_parameter6.value;		//提取IS迁移概率
	var cs7=form.GEP_parameter7.value;		//提取RIS迁移概率
	var cs8=form.GEP_parameter8.value;		//提取单点重组概率
	var cs9=form.GEP_parameter9.value;		//提取双点重组概率
	var cs10=form.GEP_parameter10.value;	//提取基因重组概率
	var cs11=form.GEP_parameter11.value;	//提取训练代数
	var cs12=form.GEP_parameter12.value;	//提取阈值
	if(!isNaN(cs1)&&parseInt(cs1)==cs1)		//过滤种群大小的奇异输入
	{
		if(cs1<30||cs1>100)
		{
			returnvalue=returnvalue+"种群大小输入范围为30-100！\n";	//种群大小输入范围为30-100
		}
	}
	else
	{
		returnvalue=returnvalue+"种群大小输入格式错误！\n";	//种群大小输入格式错误
	}
	if(!isNaN(cs2)&&parseInt(cs2)==cs2)			//过滤重构维数的奇异输入
	{
		if(cs2<3||cs2>10)
		{
			returnvalue=returnvalue+"重构维数输入范围为3-10！\n";	//重构维数输入范围为3-10
		}
	}
	else
	{
		returnvalue=returnvalue+"重构维数输入格式错误！\n";	//重构维数输入格式错误
	}
	if(!isNaN(cs3)&&parseInt(cs3)==cs3)			//过滤基因头部长度的奇异输入
	{
		if(cs3<5||cs3>15)
		{
			returnvalue=returnvalue+"基因头部长度输入范围为5-15！\n";	//基因头部长度输入范围为5-15
		}
	}
	else
	{
		returnvalue=returnvalue+"基因头部长度输入格式错误！\n";	//基因头部长度输入格式错误
	}
	if(!isNaN(cs4)&&parseInt(cs4)==cs4)			//过滤基因数量的奇异输入
	{
		if(cs4<2||cs4>10)
		{
			returnvalue=returnvalue+"基因数量输入范围为2-10！\n";	//基因数量输入范围为2-10
		}
	}
	else
	{
		returnvalue=returnvalue+"基因数量输入格式错误！\n";	//基因数量输入格式错误
	}
	if(!isNaN(cs5))			//过滤基因变异概率的奇异输入
	{
		if(cs5<0||cs5>1)
		{
			returnvalue=returnvalue+"基因变异概率输入范围为0-1！\n";	//基因变异概率输入范围为0-1
		}
	}
	else
	{
		returnvalue=returnvalue+"基因变异概率输入格式错误！\n";	//基因变异概率输入格式错误
	}
	if(!isNaN(cs6))		//过滤IS迁移概率的奇异输入	
	{
		if(cs6<0||cs6>1)
		{
			returnvalue=returnvalue+"IS迁移概率输入范围为0-1！\n";	//IS迁移概率输入范围为0-1
		}
	}
	else
	{
		returnvalue=returnvalue+"IS迁移概率输入格式错误！\n";		//IS迁移概率输入格式错误
	}
	if(!isNaN(cs7))		//过滤RIS迁移概率的奇异输入	
	{
		if(cs7<0||cs7>1)
		{
			returnvalue=returnvalue+"RIS迁移概率输入范围为0-1！\n";	//RIS迁移概率输入范围为0-1
		}
	}
	else
	{
		returnvalue=returnvalue+"RIS迁移概率输入格式错误！\n";	//RIS迁移概率输入格式错误
	}
	if(!isNaN(cs8))			//过滤单点重组概率的奇异输入
	{
		if(cs8<0||cs8>1)
		{
			returnvalue=returnvalue+"单点重组概率输入范围为0-1！\n";	//单点重组概率输入范围为0-1
		}
	}
	else
	{
		returnvalue=returnvalue+"单点重组概率输入格式错误！\n";	//单点重组概率输入格式错误
	}
	if(!isNaN(cs9))			//过滤双点重组概率的奇异输入
	{
		if(cs9<0||cs9>1)
		{
			returnvalue=returnvalue+"双点重组概率输入范围为0-1！\n";	//双点重组概率输入范围为0-1
		}
	}
	else
	{
		returnvalue=returnvalue+"双点重组概率输入格式错误！\n";	//双点重组概率输入格式错误
	}
	if(!isNaN(cs10))			//过滤基因重组概率的奇异输入
	{
		if(cs10<0||cs10>1)
		{
			returnvalue=returnvalue+"基因重组概率输入范围为0-1！\n";	//基因重组概率输入范围为0-1
		}
	}
	else
	{
		returnvalue=returnvalue+"基因重组概率输入格式错误！\n";	//基因重组概率输入格式错误
	}
	if(!isNaN(cs11)&&parseInt(cs11)==cs11)	//过滤训练代数的奇异输入
	{
		if(cs11<10||cs11>100000)
		{
			returnvalue=returnvalue+"训练代数输入范围为10-100000！\n";	//训练代数输入范围为10-100000
		}
	}
	else
	{
		returnvalue=returnvalue+"训练代数输入格式错误！\n";	//训练代数输入格式错误
	}
	if(!isNaN(cs12))		//过滤阈值的奇异输入
	{
		if(cs12<0||cs12>100)
		{
			returnvalue=returnvalue+"阈值输入范围为0-1！\n";	//阈值输入范围为0-100
		}
	}
	else
	{
		returnvalue=returnvalue+"阈值输入格式错误！\n";	//阈值输入格式错误
	}
	if(returnvalue=="")
	{
		if(type=="1")
		{
			document.getElementById("loader_container").style.display="block";	
			//把执行等待滚动条打开
			document.getElementById("flag").value++;	//启动检查通过标志
			return true;
		}
		if(type=="2")
		{
			if(confirm("确定要保存为默认参数吗？"))
			{
				document.getElementById("loader_container").style.display="block";
				//把执行等待滚动条打开
				document.parameterform.action="../../datainfo/parameterinfo/saveparameter.jsp";
				//修改表单提交页面的路径
				document.parameterform.target="MODIFYPARAMETER";
				//修改表单提交页面的要显示的地方
				document.parameterform.submit();
				//提交表单
			}
			return false;
		}
		if(type=="3")
		{
			if(confirm("确定要修改默认参数吗？"))
			{
				return true;
			}
			return false;
		}
	}
	else
	{
		alert(returnvalue);		//如果returnvalue有内容，代表有错误
		return false;
	}
}