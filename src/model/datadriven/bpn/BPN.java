package model.datadriven.bpn;

import modelinterface.FunctionMiningModel;;

public class BPN implements FunctionMiningModel
{
	private double[][] data;	//重构后的数据
	private double[] result;		//重构后对应数据的结果
	private double[] outdata;		//预测数据
	private int m;					//重构维数
	private int n;					//数据组数
	private double learningCoefficient;//学习系数
	private int trips;				//训练代数
	private double threshold;		//Mspe阈值
	private double data_min; 		//数据中最小的数
	private double width;			//数据域宽
	private String process;
	private HiddenNode[] hiddenNode;//定义中间层（隐藏层）节点
	private ExportNode exportNode;	//定义输出层节点
	private double max(double a[])//求数组最大值
	{
		double maxt=a[0];
		for(int i=1;i<a.length;i++)
		{
			if(a[i]>maxt) maxt=a[i];
		}
		return maxt;
	}
	private double max(double a[][], double[] b)//求数组最小值
	{
		double maxt=b[0];
		for(int i=1;i<b.length;i++)
		{
			if(b[i]>maxt) maxt=b[i];
		}
		for(int i=0;i<a.length;i++)
		{
			for(int j=0;j<a[0].length;j++)
			{
				if(a[i][j]>maxt) maxt=a[i][j];
			}
		}
		return maxt;
	}
	
	private double min(double a[])//求数组最小值
	{
		double mint=a[0];
		for(int i=1;i<a.length;i++)
		{
			if(a[i]<mint) mint=a[i];
		}
		return mint;
	}
	private double min(double a[][], double[] b)//求数组最小值
	{
		double mint=b[0];
		for(int i=1;i<b.length;i++)
		{
			if(b[i]<mint) mint=b[i];
		}
		for(int i=0;i<a.length;i++)
		{
			for(int j=0;j<a[0].length;j++)
			{
				if(a[i][j]<mint) mint=a[i][j];
			}
		}
		return mint;
	}
	
	private double changedataForward(double x)//把数据变成0到1之间
	{
		return (x-data_min)/width;
	}
	private double changedataBackward(double x)//把数据从0到1恢复
	{
		double y = x*width+data_min;
		if(Double.isNaN(y)) y=0;
		return y;
	}
	private double MSE(double x[])//求Mspe值
	{
		double num=0,s;
		for(int i=0;i<n;i++)
		{
			s=(result[i]-x[i]);
			num+=s*s;
		}
		return Math.sqrt(num)/n;
	}
	private double calculateNet(double x[])//传入输入神经元，经过神经网络，计算出输出值
	{
		double y[]=new double[2*m+1];
		for(int i=0;i<2*m+1;i++)
		{
			y[i]=hiddenNode[i].calculate(x);
		}
		return exportNode.calculate(y);
	}
	private void train()	
	{
		hiddenNode=new HiddenNode[2*m+1];  //初始化隐藏层节点
		for(int i=0;i<hiddenNode.length;i++)
		{
			hiddenNode[i]=new HiddenNode(m);
		}
		exportNode=new ExportNode(2*m+1);  //初始化输出层节点
		for(int i=0;i<n;i++)
		{
			for(int j=0;j<m;j++)
			{
				this.data[i][j]=changedataForward(this.data[i][j]);
			}
			result[i]=changedataForward(result[i]);
		}
		int count=0;
		double res_prediction[]=new double[n];
		while(count<trips)  //训练循环
		{
			count++;
			for(int i=0;i<n;i++)
			{
				res_prediction[i]=calculateNet(data[i]); //输出每组样本在神经网络的计算结果，并存入res_prediction数组
			}
			if(MSE(res_prediction)<=threshold) break; //如果预测值与实际值得Mspe值小于规定的阈值，则停止训练
			double hiddenvalue[]=new double[2*m+1];	//用于暂存中间层输出值
			double pc_yc[]=new double[2*m+1];	//用于存储中间层的误差值
			double pc_sc;						//用于存储输出层的误差值
			for(int i=0;i<n;i++)		//修改权值过程
			{
				for(int j=0;j<2*m+1;j++)	//计算一个样本
				{
					hiddenvalue[j]=hiddenNode[j].calculate(data[i]);
					hiddenNode[j].setoutdata(hiddenvalue[j]);
				}
				exportNode.setoutdata(exportNode.calculate(hiddenvalue));
				pc_sc=exportNode.getoutdata()*(1-exportNode.getoutdata())*(result[i]-exportNode.getoutdata());//计算输出层误差 
				for(int j=0;j<m*2+1;j++)					//调整权值
				{
					pc_yc[j]=hiddenNode[j].getoutdata()*(1-hiddenNode[j].getoutdata())*pc_sc*exportNode.getw(j);
					hiddenNode[j].adjustw(learningCoefficient*pc_yc[j],data[i]);	//调整中间层的权值
				}
				exportNode.adjustw(learningCoefficient*pc_sc,hiddenNode);	//调整输出层的权值
			}
		}
		double[] w;
		process = "训练代数：" + count + "\n\n误差值："+MSE(res_prediction)+"\n\n隐藏层权值：";
		for(int i=0;i<hiddenNode.length;i++)
		{
			w=hiddenNode[i].getw();
			process += "隐藏层"+(i+1)+"：";
			for(int j=0;j<w.length;j++)
			{
				process += w[j] + " ";
			}
			process += "\n";
		}
		process += "\n输出层权值：";
		w=exportNode.getw();
		for(int i=0;i<w.length;i++)
		{
			process += w[i] + " ";
		}
	}
	public void inputdata(double data[],double[] parameter)//输入接口
	{
		learningCoefficient=parameter[0];
		trips=(int)parameter[2];
		threshold=parameter[3];
		data_min=min(data);				//保存数据最小值
		width=max(data)-data_min;			//保存数据域宽
		if(width==0) width=1;
		Reconstruction reconstruction=new Reconstruction(data,(int)parameter[1]);	//相空间重构，传入序列以及重构维数
		m=reconstruction.getm();		//返回m值
		n=reconstruction.getn();		//返回n值
		this.data=new double[n][m];
		result=new double[n];
		this.data=reconstruction.getInput();//返回重构后的数据矩阵
		result=reconstruction.getRes();		//返回样本结果值
		train();//开始训练
	}
	public void inputdata2(double data[][], double[] result, double[] parameter)
	{
		learningCoefficient=parameter[0];
		trips=(int)parameter[2];
		threshold=parameter[3];
		data_min=min(data, result);				//保存数据最小值
		width=max(data,result)-data_min;			//保存数据域宽
		if(width==0) width=1;
		m = data[0].length;
		n = data.length;
		this.data = data.clone();
		this.result = result.clone();
		train();//开始训练
	}
	
	public double[] getoutdata(int step)//输出接口
	{
		outdata=new double[step];//初始化数据
		double x[]=new double[m];
		for(int i=0;i<m;i++)
		{
			x[i]=result[n-m+i];
		}
		for(int i=0;i<step;i++)//向后预测，把结果存入outdata数组中
		{
			double a=calculateNet(x);
			outdata[i]=changedataBackward(a);
			for(int j=0;j<m-1;j++)
			{
				x[j]=x[j+1];
			}
			x[m-1]=a;
		}
		return outdata.clone();
	}
	
	public double[] getoutdata2(int step, double[][] data)
	{
		for(int i=0;i<data.length;i++)
		{
			for(int j=0;j<data[i].length;j++)
			{
				data[i][j] = changedataForward(data[i][j]);
			}
		}
		outdata=new double[step];//初始化数据
		for(int i=0;i<step;i++)
		{
			outdata[i] = changedataBackward(calculateNet(data[i]));
		}
		return outdata.clone();
	}
	public String getprocess()
	{
		return process;
	}
	public String getparameterinfo()
	{
		String info="";
		info=info+"学习系数："+String.valueOf(learningCoefficient)
				+"； 重构维数："+String.valueOf(m)
				+"； 训练代数："+String.valueOf(trips)
				+"； 阈值："+String.valueOf(threshold)+"；";
		return info;
	}
	public double[] getfitness()
	{
		double[] x;
		double[] outdata=new double[0];
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//定义数字格式
		outdata=new double[data.length+m];
		for(int i=0;i<m;i++)
		{
			outdata[i] = 0.001;
		}
		for(int i=0;i<data.length;i++)
		{
			x = data[i].clone();
			double a = calculateNet(x);
			outdata[i+m] = Double.parseDouble(df.format(changedataBackward(a)));
		}
		return outdata.clone();
	}
	public double[] getfitness2()
	{
		double[] x;
		double[] outdata=new double[0];
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//定义数字格式
		outdata=new double[data.length];
		for(int i=0;i<data.length;i++)
		{
			x = data[i].clone();
			double a = calculateNet(x);
			outdata[i] = Double.parseDouble(df.format(changedataBackward(a)));
		}
		return outdata.clone();
	}
}