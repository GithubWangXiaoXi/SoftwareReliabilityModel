function modify(model)
{
	document.getElementById("modify_BPN").style.display="none";	//�ر�BPN�����޸�ҳ��
	document.getElementById("modify_RBFN").style.display="none";//�ر�RBFN�����޸�ҳ��
	document.getElementById("modify_GEP").style.display="none";	//�ر�GEP�����޸�ҳ��
	document.getElementById("modify_GM").style.display="none";	//�ر�GM�����޸�ҳ��
	document.getElementById("modify_SVM").style.display="none";//�ر�SVM�����޸�ҳ��
	document.getElementById("modify_ARIMA").style.display="none";	//�ر�ARIMA�����޸�ҳ��
	document.getElementById("modify_WEIBULL").style.display="none";	//�ر�BPN�����޸�ҳ��
	document.getElementById("modify_JM").style.display="none";//�ر�RBFN�����޸�ҳ��
	document.getElementById("modify_MO").style.display="none";	//�ر�GEP�����޸�ҳ��
	document.getElementById("modify_GO").style.display="none";	//�ر�GM�����޸�ҳ��
	/*document.getElementById("modify_GammaSRM").style.display="none";	//�ر�GammaSRM�����޸�ҳ��
	document.getElementById("modify_LogLogisticSRM").style.display="none";//�ر�LogLogisticSRM�����޸�ҳ��
*/	document.getElementById("modify_DUANE").style.display="none";	//�ر�DUANE�����޸�ҳ��
	document.getElementById("modify_SCHNEIDEWIND").style.display="none";//�ر�SCHNEIDEWIND�����޸�ҳ��
	document.getElementById("modify_ExponentialSRM").style.display="none";	//�ر�BPN�����޸�ҳ��
	/*document.getElementById("modify_LogNormalSRM").style.display="none";//�ر�LogLogisticSRM�����޸�ҳ��
	document.getElementById("modify_ParetoSRM").style.display="none";	//�ر�DUANE�����޸�ҳ��
*///**************************************����ģ�ͽӿ�**************************************
//**************************************����ģ�ͽӿ�**************************************
//**************************************����ģ�ͽӿ�**************************************
//**************************************����ģ�ͽӿ�**************************************
//**************************************����ģ�ͽӿ�**************************************
	document.getElementById("modify_"+model).style.display="block";	//��ʾģ�Ͳ����޸�ҳ��
	document.getElementById("parameter_tab2").style.display="block";//��ʾtabҳ2
	document.getElementById("parameter_tab1").className="";			//ȡ��tabҳ1����ʽ
	document.getElementById("parameter_tab2").className="hover";	//��ʾtabҳ2����ʽ
	document.getElementById("parameter_con1").style.display="none";	//ȡ��con1������
	document.getElementById("parameter_con2").style.display="block";//��ʾcon2������
}