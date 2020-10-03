function modify(model)
{
	document.getElementById("modify_BPN").style.display="none";	//关闭BPN参数修改页面
	document.getElementById("modify_RBFN").style.display="none";//关闭RBFN参数修改页面
	document.getElementById("modify_GEP").style.display="none";	//关闭GEP参数修改页面
	document.getElementById("modify_GM").style.display="none";	//关闭GM参数修改页面
	document.getElementById("modify_SVM").style.display="none";//关闭SVM参数修改页面
	document.getElementById("modify_ARIMA").style.display="none";	//关闭ARIMA参数修改页面
	document.getElementById("modify_WEIBULL").style.display="none";	//关闭BPN参数修改页面
	document.getElementById("modify_JM").style.display="none";//关闭RBFN参数修改页面
	document.getElementById("modify_MO").style.display="none";	//关闭GEP参数修改页面
	document.getElementById("modify_GO").style.display="none";	//关闭GM参数修改页面
	/*document.getElementById("modify_GammaSRM").style.display="none";	//关闭GammaSRM参数修改页面
	document.getElementById("modify_LogLogisticSRM").style.display="none";//关闭LogLogisticSRM参数修改页面
*/	document.getElementById("modify_DUANE").style.display="none";	//关闭DUANE参数修改页面
	document.getElementById("modify_SCHNEIDEWIND").style.display="none";//关闭SCHNEIDEWIND参数修改页面
	document.getElementById("modify_ExponentialSRM").style.display="none";	//关闭BPN参数修改页面
	/*document.getElementById("modify_LogNormalSRM").style.display="none";//关闭LogLogisticSRM参数修改页面
	document.getElementById("modify_ParetoSRM").style.display="none";	//关闭DUANE参数修改页面
*///**************************************增加模型接口**************************************
//**************************************增加模型接口**************************************
//**************************************增加模型接口**************************************
//**************************************增加模型接口**************************************
//**************************************增加模型接口**************************************
	document.getElementById("modify_"+model).style.display="block";	//显示模型参数修改页面
	document.getElementById("parameter_tab2").style.display="block";//显示tab页2
	document.getElementById("parameter_tab1").className="";			//取消tab页1的样式
	document.getElementById("parameter_tab2").className="hover";	//显示tab页2的样式
	document.getElementById("parameter_con1").style.display="none";	//取消con1的内容
	document.getElementById("parameter_con2").style.display="block";//显示con2的内容
}