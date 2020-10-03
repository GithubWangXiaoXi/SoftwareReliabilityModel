package model.datadriven.bpn;
class HiddenNode
{
	private double[] w;		//�м��Ȩֵ
	private double sita;	//������ֵ
	private double outdata;	//�м�����ֵ
	public HiddenNode(int number)	//���췽���������ʼȨֵ
	{
		w=new double[number];
		for(int i=0;i<number;i++)
		{
			w[i]=Math.random();
		}
		sita=Math.random();
	}
	public double calculate(double x[])	//�������ֵ����
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
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//�������ָ�ʽ
		for(int i=0;i<w_x.length;i++)
		{
			w_x[i] = Double.parseDouble(df.format(w[i]));
		}
		return w_x.clone();
	}
}

class ExportNode
{
	private double[] w;		//�����Ȩֵ
	private double sita;	//������ֵ
	private double outdata;	//��������ֵ
	
	public ExportNode(int number)	//���췽���������ʼȨֵ
	{
		w=new double[number];
		for(int i=0;i<number;i++)
		{
			w[i]=Math.random();
		}
		sita=Math.random();
	}
	public double calculate(double x[])	//�������ֵ����
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
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//�������ָ�ʽ
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