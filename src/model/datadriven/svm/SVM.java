package model.datadriven.svm;

import modelinterface.BasicModel;

/***
 * ֧����������
 */


public class SVM implements BasicModel
{
	//���ڲ�����
	private double[] series;	//�������У�һά��
	private double[] predications;	//ģ��Ԥ����
	private double[] fitness;   //���ֵ
	
	private svm_predict predictSVM = new svm_predict();	
	private svm_train trainSVM = new svm_train();
	private svm_model model;
	private String[] str  = null;
 
	
	//ѵ��SVM, ���� �淶�����ݣ� ģ��ѵ����ģ��Ԥ��
	public void runSvm(double[] data)  //throws IOException
	{
					  
			//String[] str ={"-s","4","-t","2","-c","1024","-g","2.0","-p","1"}; 
	 //String[] str ={"-s","3","-t","2","-c","1024","-g","2.0","-p","1","-n","0.5","-e","0.001"};
			
			//@1���-------------------------------------------[��ʱ������]
//			if(isScaleFlag)
//			{
//				svm_scale scaleSVM = new svm_scale();
//				svm_parameter.failureTimeth = scaleSVM.scale(y);
//			}	  	
			 
		 	//@2 ѵ��ģ��-------------------------------------------			
	  		model = trainSVM.getModel(str, data);	
				
		return;
	}

	@Override
	public void inputdata(double[] data, double[] parameter)
	{
		this.series = data.clone();
		
		// ��(lable index:value) value ���и�ֵ
		int len = this.series.length;
		svm_parameter.failureTimeth = new double[len];
		for(int i = 0; i < len; i++)
		{
			svm_parameter.failureTimeth[i] = i+1;
		}
		
		//�������������飬ת��Ϊ�ַ��� 
		
		str = new String[parameter.length*2];
		
		str[0] = "-s ";
		str[1]=""+(int)(parameter[0] + 0.1);
		
		str[2] = "-t ";
		str[3]= ""+(int)(parameter[1] + 0.1);		
		
		str[4] = "-c ";
		str[5] = ""+(parameter[2]);
		
		str[6] = "-g ";
		str[7] = ""+(parameter[3]);
		
		str[8] = "-p ";
		str[9] = ""+(parameter[4]);
		
		str[10] ="-n ";
		str[11] = ""+(parameter[5]);
		
		str[12] = "-r"; 
		str[13] = ""+(parameter[6]);
		
		str[14] = "-e ";
		str[15] =""+(parameter[7]);
		
	
		
		//ѵ��ģ��
		runSvm(series);
		 
		fitness = predictSVM.getPredication(model, series);
	}

	@Override
	public double[] getoutdata(int step)
	{		
		int originalLen = series.length;
		int newLen = originalLen + step;		
		double[] newSeries = new double[newLen];
		
		int i = 0;
		for(; i < series.length; i++)
		{
			newSeries[i] = series[i]; 
		}
		
		for(int j = 0; j < step; j++)
		{
			newSeries[i++] = i;
		}
		
		series = newSeries.clone();
		//���¸��� failureTimeth
		svm_parameter.failureTimeth = new double[newLen];
		for(int n = 0; n < newLen; n++)
		{
			svm_parameter.failureTimeth[n] = n+1;
		}		
		
		double[] results = predictSVM.getPredication(model, series);
		
		predications = new double[step];
		//int len = series.length;
		for(int k = 0; k < step; k++)
		{
			predications[k] = results[originalLen++];
		}
		
		return predications.clone();
	}

	@Override
	public double[] getfitness()
	{	
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//�������ָ�ʽ
		double[] fitness = new double[this.fitness.length];
		for(int i=0;i<fitness.length;i++)
		{
			fitness[i] = Double.parseDouble(df.format(this.fitness[i]));
		}
		return fitness.clone();
	}

	@Override
	public String getprocess() 
	{		
		StringBuffer sb = new StringBuffer();	
		 
		if(model.param.svm_type == svm_parameter.EPSILON_SVR)
		{	
			sb.append("epsilon-SVR|| ");
		    //str.append(" epsilon="+model.param.p); 
		}else		 
		{
			sb.append("nu-SVR|| ");	
			//str.append(" nu="+model.param.nu);			
		}
		if(model.param.kernel_type == svm_parameter.LINEAR)
		{
			sb.append("���Ժ˺�����u'v,");
			//str.append("")
		}
		else if(model.param.kernel_type == svm_parameter.RBF)
		{
			sb.append("RBF������exp(-gamma|u-v|^2),");
			//str.append(" gama="+model.param.gamma);
			
		}else if(model.param.kernel_type == svm_parameter.SIGMOID)
		{
			sb.append("sigmoid��tanh(gamma*u'v + coef0),");
			//str.append(" gama="+model.param.gamma+" coef0="+model.param.coef0);
		}
		
		
			
		String str = null; 
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.0000");	//�������ָ�ʽ
		str = "#iter(��������) = "+svm_parameter.iter+"��obj(���ι滮���õ�����Сֵ) = "
				+Double.parseDouble(df.format(svm_parameter.obj))+"��" +
				"rho(�о������ĳ�����b) = "+Double.parseDouble(df.format(svm_parameter.rh0))
				+"��\r\n"+"nSV(֧����������) = "+(int)svm_parameter.nSV+
				"��nBSV(�߽��ϵ�֧����������) = "+(int)svm_parameter.nBSV+"��";
		
	    sb.append("\r\n"+str);	
	    
		
		return sb.toString();
	}

	@Override
	public String getparameterinfo() 
	{
		String svm_type;
		String kernel_type;
		if(model.param.svm_type == svm_parameter.EPSILON_SVR)
		{
			svm_type = "EPSILON_SVR��";
		}else
		{
			svm_type = "NU_SVR��";
		}
		
		if(model.param.kernel_type == svm_parameter.LINEAR)
		{
			kernel_type = ("���Ժ˺���[u'v]��");
			//str.append("")
		}
		else if(model.param.kernel_type == svm_parameter.RBF)
		{
			kernel_type = ("RBF�˺���[exp(-gama|u-v|^2)]��");
			//str.append(" gama="+model.param.gamma);
			
		}else
		{
			kernel_type = ("S�ͺ˺���[tanh(gamma*u'v + coef0)]��");
		}	//str.append(" gama="+model.param.gamma+" coef0="+model.param.coef0);

		
		String str = "ģ�Ͳ���||\r\n" +
		 		"-s(SVM����)��"+svm_type+"-t(�˺�������)��"+kernel_type
		 		+"-g(�˺���ϵ����gamma):"+model.param.gamma+"�� -c(����e-SVR �� nu-SVR�Ĳ���(�ͷ�ϵ��))��"+model.param.C+"\r\n-n(nu-SVR�����еĲ���nu):"
		 		+model.param.nu+"��-p(epsilon-SVR �е���ʧ����ֵ):"+model.param.p+
		 		"��-r(S�ͺ��е�ϵ����cofe0)��"+model.param.coef0+"��-e(��ֹ�ж�����)��"
				 		+model.param.eps+"��";
		
		return str;
	}
}
