package system;

public class KS
{
	private double[] Fn1;
	private double[] Fn2;
	private double D;
	private double p;
	private int n;
	private double lambda()
	{
		double Ne = Math.sqrt((double)n/2);
		return D*(Ne+0.12+0.11/Ne);
	}
	
	private double calculate_p()
	{
		if(D==0) return 1;
		int j = 1;
		double num = 0;
		double lambda = lambda();
		while(j<1000000)
		{
			double x1 = -2*j*j*Math.pow(lambda, 2);
			double x2 = Math.pow(Math.E, x1);
			if (x2 < 0.000001) break;
			if (j % 2 == 1) num += x2;
			else num -= x2;
			j++;
		}
		return 2*num;
	}
	
	private double calculate_D(int[] F_data1, int[] F_data2)
	{
		double D_max=0;
		Fn1 = new double[F_data1.length];
		Fn2 = new double[F_data2.length];
		for (int i = 0; i < F_data1.length; i++)
		{
			Fn1[i] = (double)F_data1[i]/n;
			Fn2[i] = (double)F_data2[i]/n;
			D_max = Math.max(Math.abs(Fn1[i]-Fn2[i]), D_max);
		}
		return D_max;
	}
	
	private int[] divid(double[] data)
	{
		double min = data[0], max = data[data.length-1];
		double interval = (max-min)/20;
		int[] divid = new int[20];
		int j = 0;
		while(data[j] == min)
		{
			divid[0]++;
			j++;
			if(j==data.length) break;
		}
		if(j!=data.length)
		{
			for(int i=0;i<20;i++)
			{
				while ((data[j] > (min + interval * i)) && (data[j] <= (min + interval * (i + 1))))
				{
					divid[i]++;
					if(j == data.length-1) break;
					j++;
				}
			}
		}
		int num=0;
		for(int i=0;i<20;i++)
		{
			num += divid[i];
			divid[i] = num;
		}
		return divid.clone();
	}
	
	private double[] Sort(double[] data)
	{
		double temp;
		for(int i=0; i<data.length; i++)
		{
			for(int j=i+1; j<=data.length-1; j++)
			{
				if(data[i] > data[j])
				{
					temp = data[i];                       
					data[i] = data[j];                         
					data[j] = temp; 
				}
			}
		}
		return data.clone();
	}
	
	public void inputdata(double[] data_real, double[] data_pre)
	{
		int m=0;
		while(m < data_pre.length)
		{
			if(data_pre[m] == 0.001) m++;
			else break;
		}
		double[] data1 = new double[data_real.length-m];
		double[] data2 = new double[data_pre.length-m];
		for(int i=0; i<data1.length;i++)
		{
			data1[i] = data_real[m+i];
			data2[i] = data_pre[m+i];
		}
		n = data1.length;
		data1 = Sort(data1);
		data2 = Sort(data2);
		int[] F_data1 = divid(data1);
		int[] F_data2 = divid(data2);
		D = calculate_D(F_data1, F_data2);
		p = 1 - calculate_p();
	}
	public double getD()
	{
		java.text.DecimalFormat df = new java.text.DecimalFormat("#.0000"); // 定义数字格式
		D = Double.parseDouble(df.format(D)); // 将预测数据保留两位小数
		return D;
	}
	public double getp()
	{
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.0000");	//定义数字格式
		p=Double.parseDouble(df.format(p)); //将预测数据保留两位小数
		return p;
	}
	public double[] getFn1()
	{
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.0000");	//定义数字格式
		for(int i=0;i<Fn1.length;i++)
		{
			Fn1[i]=Double.parseDouble(df.format(Fn1[i])); //将预测数据保留两位小数
		}
		return Fn1.clone();
	}
	public double[] getFn2()
	{
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.0000");	//定义数字格式
		for(int i=0;i<Fn2.length;i++)
		{
			Fn2[i]=Double.parseDouble(df.format(Fn2[i])); //将预测数据保留两位小数
		}
		return Fn2.clone();
	}
}