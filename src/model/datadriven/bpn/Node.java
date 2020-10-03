package model.datadriven.bpn;
class HiddenNode
{
	private double[] w;		//中间层权值
	private double sita;	//激活阈值
	private double outdata;	//中间层输出值
	public HiddenNode(int number)	//构造方法，随机初始权值
	{
		w=new double[number];
		for(int i=0;i<number;i++)
		{
			w[i]=Math.random();
		}
		sita=Math.random();
	}
	public double calculate(double x[])	//计算输出值过程
	{
		if(x.length!=w.length) 	return 0;
		else
		{
			double num=0;
			for(int i=0;i<w.length;i++)
			{
				num+=w[i]*x[i];
			}
			num=1/(1+Math.pow(2.718281828459045,-(sita+num)));
			outdata=num;
			return num;
		}
	}
	public double getoutdata()
	{
		return outdata;
	}
	public void setoutdata(double x)
	{
		outdata=x;
	}
	public void adjustw(double x,double y[])
	{
		sita+=x;
		for(int i=0;i<w.length;i++)
		{
			w[i]+=x*y[i];
		}
	}
	public double[] getw()
	{
		double[] w_x = new double[w.length];
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//定义数字格式
		for(int i=0;i<w_x.length;i++)
		{
			w_x[i] = Double.parseDouble(df.format(w[i]));
		}
		return w_x.clone();
	}
}

class ExportNode
{
	private double[] w;		//输出层权值
	private double sita;	//激活阈值
	private double outdata;	//输出层输出值
	
	public ExportNode(int number)	//构造方法，随机初始权值
	{
		w=new double[number];
		for(int i=0;i<number;i++)
		{
			w[i]=Math.random();
		}
		sita=Math.random();
	}
	public double calculate(double x[])	//计算输出值过程
	{
		if(x.length!=w.length) return 0;
		else
		{
			double num=0;
			for(int i=0;i<w.length;i++)
			{
				num+=w[i]*x[i];
			}
			num=1/(1+Math.pow(2.718281828459045,-(sita+num)));
			return num;
		}
	}
	public double getoutdata()
	{
		return outdata;
	}
	public void setoutdata(double x)
	{
		outdata=x;
	}
	public double getw(int i)
	{
		return w[i];
	}
	public double[] getw()
	{
		double[] w_x = new double[w.length];
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//定义数字格式
		for(int i=0;i<w_x.length;i++)
		{
			w_x[i] = Double.parseDouble(df.format(w[i]));
		}
		return w_x.clone();
	}
	public void adjustw(double x,HiddenNode y[])
	{
		sita+=x;
		for(int i=0;i<w.length;i++)
		{
			w[i]+=x*y[i].getoutdata();
		}
	}
}