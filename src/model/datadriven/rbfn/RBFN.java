package model.datadriven.rbfn;

import modelinterface.BasicModel;

public class RBFN implements BasicModel
{
	private double[][] data;
	private double[] result;
	private int hidden;
	private int m;
	private double beita;
	private String process;
	private double weight[];
	private double center[][];
	private double width;
	private double data_min; 		//数据中最小的数
	private double data_width;			//数据宽度
	public void inputdata(double data[], double[] parameter)
	{
		process = "";
		beita = parameter[1];
		Reconstruction reconstruction=new Reconstruction(data,(int)parameter[0]);	//相空间重构，传入序列以及重构维数
		m=reconstruction.getm();		//返回m值
		data_min=min(data);				//保存数据最小值
		data_width=max(data)-data_min;			//保存数据域宽
		if(width==0) width=1;
		int n=reconstruction.getn();		//返回n值
		this.data = new double[n][m];
		this.data = reconstruction.getInput();
		result = reconstruction.getRes();
		for(int i=0;i<this.data.length;i++)
		{
			for(int j=0;j<m;j++)
			{
				this.data[i][j]=changedataForward(this.data[i][j]);
			}
			result[i]=changedataForward(result[i]);
		}
		Init_center();
		Init_weight();
		Init_width();
		train();
	}

	public double[] getoutdata(int step)//输出接口
	{
		double[] outdata = new double[step];//初始化数据
		double x[] = new double[m];
		for(int i=0;i<m;i++)
		{
			x[i]=result[data.length-m+i];
		}
		for(int i=0;i<step;i++)//向后预测，把结果存入outdata数组中
		{
			double a = calculate(x);
			outdata[i] = changedataBackward(a);
			for(int j=0;j<m-1;j++)
			{
				x[j]=x[j+1];
			}
			x[m-1] = a;
		}
		return outdata;
	}

	public double[] getfitness()
	{
		double[] x;
		double[] outdata=new double[data.length+m];
		for(int i=0;i<m;i++)
		{
			outdata[i] = 0.001;
		}
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//定义数字格式
		for(int i=0;i<data.length;i++)
		{
			x = data[i].clone();
			double a = changedataBackward(calculate(x));
			outdata[i+m] = Double.parseDouble(df.format(a));
		}
		return outdata.clone();
	}
	
	public String getparameterinfo()
	{
		String info="";
		info=info+"中心相关系数："+String.valueOf(beita)
				+"； 重构维数："+String.valueOf(m);
		return info;
	}
	
	public String getprocess()
	{
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.0000");	//定义数字格式
		double x;
		x=Double.parseDouble(df.format(width)); //将预测数据保留两位小数
		process+="域宽： "+x+"\n";
		process+="\n中心：\n";
		for(int i=0;i<center.length;i++)
		{
			process+=(i+1)+"： ";
			for(int j=0;j<center[0].length;j++)
			{
				x=Double.parseDouble(df.format(center[i][j]));
				process+=x+" ";
			}
			process+="\n";
		}
		process+="\n权值：\n";
		for(int i=0;i<weight.length;i++)
		{
			x=Double.parseDouble(df.format(weight[i]));
			process += (i+1)+"： "+x+"\n";
		}
		return process;
	}
	private double max(double a[])//求数组最大值
	{
		double maxt=a[0];
		for(int i=1;i<a.length;i++)
		{
			if(a[i]>maxt) maxt=a[i];
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
	
	private double changedataForward(double x)//把数据变成0到1之间
	{
		return (x-data_min)/data_width;
	}
	private double changedataBackward(double x)//把数据从0到1恢复
	{
		double y = x*data_width+data_min;
		if(Double.isNaN(y)) y=0;
		return y;
	}
	private double wbc(double[] x1 ,double[] x2)
	{
		double num1=0,num2=0,num3=0,num4;
		int i;
		for(i=0;i<x1.length;i++)
		{
			num1+=(x1[i]*x2[i]);
			num2+=x1[i]*x1[i];
			num3+=x2[i]*x2[i];
		}
		num4=num1/Math.sqrt(num2*num3);
		return Math.sqrt(1-num4);
	}
	private void Init_weight()
	{
		weight = new double[hidden];
		for(int i=0;i<weight.length;i++)
		{
			weight[i] = Math.random();
		}
	}
	private void Init_center()
	{
		int temp;
		hidden=1;
		double[][] center_x = new double[data.length][data[0].length];
		for(int i=0;i<data[0].length;i++)
		{
			center_x[0][i]=data[0][i];
		}
		for(int i=0;i<data.length;i++)
		{
			temp=0;
			double[] x1 = new double[data[0].length];
			double[] x2 = new double[data[0].length];
			for(int j=0;j<hidden;j++)
			{
				x1 = data[i].clone();
				x2 = center_x[j].clone();
				if(wbc(x1,x2)<beita)
				{
					temp=1;
					break;
				}
			}
			if(temp==0)
			{
				center_x[hidden] = data[i].clone();
				hidden++;
			}
		}
		center = new double[hidden][data[0].length];
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.000");	//定义数字格式
		for(int i=0;i<hidden;i++)
		{
			for(int j=0;j<center[i].length;j++)
			{
				center[i][j] = Double.parseDouble(df.format(center_x[i][j]));
			}
		}
	}
	private void Init_width()
	{
		double num=0;
		double[] x1 = new double[data[0].length];
		double[] x2 = new double[data[0].length];
		for(int i=0;i<hidden;i++)
		{	
			int near=nearest(i);
			for(int j=0;j<x1.length;j++)
			{
				x1[j]=center[i][j];
				x2[j]=center[near][j];
			}
			num+=wbc(x1,x2);
		}
		width=num/hidden;
	}
	private int nearest(int i)
	{
		int min=1;
		double[] x1 = new double[data[0].length];
		double[] x2 = new double[data[0].length];
		double min_dis=hidden;
		x1 = center[i].clone();
		for(int j=0;j<hidden;j++)
		{
			x2 = center[j].clone();
			if(i!=j&&distance_center(x1,x2)<min_dis)
			{
				min_dis=distance_center(x1,x2);
				min=j;
			}
		}
		return min;
	}
	double distance_center(double x1[],double x2[])
	{
		int i;
		double num=0;
		for(i=0;i<x1.length;i++)
		{
			num+=(x1[i]-x2[i])*(x1[i]-x2[i]);
		}
		return num;
	}
	private double zhhs(int i,int j)
	{
		double[] x1 = data[i].clone();
		double[] x2 = center[j].clone();
		double num;
		num=wbc(x1,x2);
		num*=num;
		return Math.pow(Math.E,-num/(2*width*width));
	}
	private double zhhs_2(int i, double[] x1)
	{
		double[] x2 = center[i].clone();
		double num;
		num=wbc(x1,x2);
		num*=num;
		return Math.pow(Math.E,-num/(2*width*width));
	}
	private void train()
	{
		double num;
		double[] r_r = new double[data.length];
		double[][] A = new double[data.length][data.length];
			for(int i=0;i<data.length;i++)
			{
				num=0;
				for(int j=0;j<hidden;j++)
				{
					A[i][j]=zhhs(i,j);
					num+=(weight[j]*A[i][j]);
				}
				r_r[i]=num;
			}
			Matrix matrix = new Matrix();
			double[][] ATA_1AT = matrix.calculate(A,hidden);
			for(int i=0;i<hidden;i++)
			{
				num=0;
				for(int j=0;j<data.length;j++)
				{
					num+=ATA_1AT[i][j]*result[j];
				}
				weight[i]=num;
			}
	}
	private double calculate(double x[])
	{
		double num=0;
		for(int i=0;i<hidden;i++)
		{
			num+=(weight[i]*zhhs_2(i,x));
		}
		return num;
	}
}
