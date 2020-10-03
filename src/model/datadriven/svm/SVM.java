package model.datadriven.svm;

import modelinterface.BasicModel;

/***
 * 支持向量机类
 */


public class SVM implements BasicModel
{
	//类内部变量
	private double[] series;	//输入序列（一维）
	private double[] predications;	//模型预测结果
	private double[] fitness;   //拟合值
	
	private svm_predict predictSVM = new svm_predict();	
	private svm_train trainSVM = new svm_train();
	private svm_model model;
	private String[] str  = null;
 
	
	//训练SVM, 包括 规范化数据， 模型训练，模型预测
	public void runSvm(double[] data)  //throws IOException
	{
					  
			//String[] str ={"-s","4","-t","2","-c","1024","-g","2.0","-p","1"}; 
	 //String[] str ={"-s","3","-t","2","-c","1024","-g","2.0","-p","1","-n","0.5","-e","0.001"};
			
			//@1规格化-------------------------------------------[暂时不开放]
//			if(isScaleFlag)
//			{
//				svm_scale scaleSVM = new svm_scale();
//				svm_parameter.failureTimeth = scaleSVM.scale(y);
//			}	  	
			 
		 	//@2 训练模型-------------------------------------------			
	  		model = trainSVM.getModel(str, data);	
				
		return;
	}

	@Override
	public void inputdata(double[] data, double[] parameter)
	{
		this.series = data.clone();
		
		// 对(lable index:value) value 进行赋值
		int len = this.series.length;
		svm_parameter.failureTimeth = new double[len];
		for(int i = 0; i < len; i++)
		{
			svm_parameter.failureTimeth[i] = i+1;
		}
		
		//将传进来的数组，转化为字符串 
		
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
		
	
		
		//训练模型
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
		//重新更新 failureTimeth
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
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//定义数字格式
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
			sb.append("线性核函数：u'v,");
			//str.append("")
		}
		else if(model.param.kernel_type == svm_parameter.RBF)
		{
			sb.append("RBF函数：exp(-gamma|u-v|^2),");
			//str.append(" gama="+model.param.gamma);
			
		}else if(model.param.kernel_type == svm_parameter.SIGMOID)
		{
			sb.append("sigmoid：tanh(gamma*u'v + coef0),");
			//str.append(" gama="+model.param.gamma+" coef0="+model.param.coef0);
		}
		
		
			
		String str = null; 
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.0000");	//定义数字格式
		str = "#iter(迭代次数) = "+svm_parameter.iter+"；obj(二次规划求解得到的最小值) = "
				+Double.parseDouble(df.format(svm_parameter.obj))+"；" +
				"rho(判决函数的常数项b) = "+Double.parseDouble(df.format(svm_parameter.rh0))
				+"；\r\n"+"nSV(支持向量个数) = "+(int)svm_parameter.nSV+
				"；nBSV(边界上的支持向量个数) = "+(int)svm_parameter.nBSV+"。";
		
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
			svm_type = "EPSILON_SVR；";
		}else
		{
			svm_type = "NU_SVR；";
		}
		
		if(model.param.kernel_type == svm_parameter.LINEAR)
		{
			kernel_type = ("线性核函数[u'v]；");
			//str.append("")
		}
		else if(model.param.kernel_type == svm_parameter.RBF)
		{
			kernel_type = ("RBF核函数[exp(-gama|u-v|^2)]；");
			//str.append(" gama="+model.param.gamma);
			
		}else
		{
			kernel_type = ("S型核函数[tanh(gamma*u'v + coef0)]；");
		}	//str.append(" gama="+model.param.gamma+" coef0="+model.param.coef0);

		
		String str = "模型参数||\r\n" +
		 		"-s(SVM类型)："+svm_type+"-t(核函数类型)："+kernel_type
		 		+"-g(核函数系数，gamma):"+model.param.gamma+"； -c(设置e-SVR 和 nu-SVR的参数(惩罚系数))："+model.param.C+"\r\n-n(nu-SVR类型中的参数nu):"
		 		+model.param.nu+"；-p(epsilon-SVR 中的损失函数值):"+model.param.p+
		 		"；-r(S型核中的系数，cofe0)："+model.param.coef0+"；-e(终止判定条件)："
				 		+model.param.eps+"。";
		
		return str;
	}
}
