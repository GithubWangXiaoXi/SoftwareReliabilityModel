function onload()	//ִ�в�����Ϻ���ƺ���ű�����
{
	if(parent.document.getElementById("flag").value!=0)	//�ж��ύҳ���flag�Ƿ�Ϊ0
	{
		var mod=parent.document.getElementById("model").value;	//��ȡmodel��
		var cur_t=parent.document.getElementById("current_tab").value;	//��ȡ��ǰtabҳ
		var nex_t=(parseInt(cur_t)+1);	//��������Ҫ������tabҳ
		if(mod=="EMD"||mod=="LN"||mod=="SSA"||mod=="WAVE")
		{
			parent.document.getElementById(mod+"_tab5").style.display="none";
			parent.document.getElementById(mod+"_tab1").className="";
			parent.document.getElementById(mod+"_con1").style.display="none";
			//����ǻ��ģ�ͣ���ִ�зֽ�ʱ����Ҫ��tabҳ5�����ݸ�ȡ����
		}
		parent.document.getElementById(mod+"_tab"+nex_t).style.display="block";
		//��ʾ��Ҫ������tabҳ
		parent.document.getElementById(mod+"_tab"+cur_t).className="";
		//ȡ����ǰtabҳ����ʽ
		parent.document.getElementById(mod+"_tab"+nex_t).className="hover";
		//��ʾ��Ҫ������tabҳ��ʽ
		parent.document.getElementById(mod+"_con"+cur_t).style.display="none";
		//ȡ����ǰҳ������
		parent.document.getElementById(mod+"_con"+nex_t).style.display="block";
		//��ʾ��һ��ҳ�������
		parent.document.getElementById("loader_container").style.display="none";
		//�ر��ύҳ���ִ�еȴ�������
		alert("ִ����ɣ�");
	}
}
function onload_merger()	//ִ�в�����Ϻ���ƺ���ű�����
{
	if(parent.document.getElementById("mergerflag").value!=0)	//�ж��ύҳ���flag�Ƿ�Ϊ0
	{
		var mod=parent.document.getElementById("model").value;	//��ȡmodel��
		parent.document.getElementById(mod+"_tab5").style.display="block";//��ʾ��Ҫ������tabҳ
		parent.document.getElementById(mod+"_tab4").className="";//ȡ����ǰtabҳ����ʽ
		parent.document.getElementById(mod+"_tab5").className="hover";//��ʾ��Ҫ������tabҳ��ʽ
		parent.document.getElementById(mod+"_con4").style.display="none";//ȡ����ǰҳ������
		parent.document.getElementById(mod+"_con5").style.display="block";//��ʾ��һ��ҳ�������
		parent.document.getElementById("loader_container").style.display="none";
		//�ر��ύҳ���ִ�еȴ�������
		alert("ִ����ɣ�");
	}
}
function onload_show()	//�滻������Ϻ���ƺ���ű�����
{
	if(document.getElementById("changeflag").value=="1")
	{
		alert("�����޸ĳɹ���");	//������ϸ��ύҳ��������changeflag��־������ʾһ��alert��
	}
}
function onload_parameter()		//�����޸���Ϻ���ƺ���ű�����
{
	if(document.getElementById("flag").value=="1")
	{
		alert("�޸ĳɹ���");		//������ϸ��ύҳ��������flag��־������ʾһ��alert��
	}
}
function onload_saveparameter()
{
	if(document.getElementById("model").value!="null")
	{
		model=document.getElementById("model").value;
		parent.document.getElementById("loader_container").style.display="none";
		if(model=="BPN"||model=="RBFN"||model=="GEP"||model=="GM"||model=="ARIMA"||model=="SVM")
		{
			parent.document.parameterform.action="../../resultshow/resultDriven.jsp";
		}
		if(model=="GO"||model=="MO"||model=="JM"||model=="DUANE"||model=="GammaSRM"||model=="LogLogisticSRM"||model=="WEIBULL"||model=="SCHNEIDEWIND"||
				model=="LogNormalSRM"||model=="ParetoSRM"||model=="ExponentialSRM")
		{
			parent.document.parameterform.action="../../resultshow/resultClassic.jsp";
		}

		//�������ݺ���ת���������ҳ�棬������Ԥ��ʱ������ʾ����ɹ�
        if(model=="BOOST")
        {
            parent.document.parameterform.action="../../resultshow/resultDriven1.jsp";
        }

		parent.document.parameterform.target="SHOWDATA_"+model;
		alert("����ɹ���");
	}
}
function onload_input()			//����������Ϻ���ƺ���ű�����
{
	if(document.getElementById("flag").value=="1")
	{
		alert("���ݵ���ɹ���");		//������ϸ��ύҳ��������flag��־������ʾһ��alert��
	}
}
function onload_resolve(resolveflag)
{
	if(resolveflag=="1")
	{
		document.getElementById("mergerflag").value="0";
		document.getElementById("flag").value++;	//�������ͨ����־
		document.resolve.submit();
		document.getElementById("loader_container").style.display="block";
	}
}