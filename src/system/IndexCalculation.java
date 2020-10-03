package system;

public class IndexCalculation
{	
	private double[] data_real;
	private double[] data_pre;
	private double MSE;
	private double R_Square;
	private double AE;
	private double MSPE;
	private double[] RE;
	private void calculation_MSE()
	{
		double num=0;
		for(int i=0;i<data_real.length;i++)
		{
			num+=(data_real[i]-data_pre[i])*(data_real[i]-data_pre[i]);
		}
		
		MSE=num/data_real.length;
	}
	private void calculation_R_Square()
	{
		double num1=0,num2=0,average=0;
		for(int i=0;i<data_real.length;i++)
		{
			average+=data_real[i];
		}
			average=average/data_real.length;
		for(int i=0;i<data_real.length;i++)
		{
			num1+=(data_real[i]-data_pre[i])*(data_real[i]-data_pre[i]);
		}
		for(int i=0;i<data_real.length;i++)
		{
			num2+=(data_real[i]-average)*(data_real[i]-average);
		}
		if(num2==0) R_Square=-10;
		else R_Square=1-num1/num2;
	}
	private void calculation_AE()
	{
		double num=0;
		for(int i=0;i<data_real.length;i++)
		{
			if(data_real[i]==0) data_real[i] = 0.1;
			RE[i]=Math.abs(data_real[i]-data_pre[i])/data_real[i];
			num+=RE[i];
		}
		AE=100*num/data_real.length;
	}
	private void calculation_MSPE()
	{
		double num=0;
		for(int i=0;i<data_real.length;i++)
		{
			if(data_real[i]==0) data_real[i] = 0.1;
			num+=(data_real[i]-data_pre[i])*(data_real[i]-data_pre[i])/data_real[i]/data_real[i];
		}
		MSPE=Math.sqrt(num)/data_real.length;
	}
	public void calculation(double[] x_real,double[] x_pre)
	{
		data_real=new double[x_real.length];
		data_pre=new double[x_real.length];
		RE=new double[x_real.length];
		for(int i=0;i<x_real.length;i++)
		{
			data_real[i]=x_real[i];
			data_pre[i]=x_pre[i];
		}
		calculation_MSE();
		calculation_R_Square();
		calculation_AE();
		calculation_MSPE();
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.0000");
		MSE=Double.parseDouble(df.format(MSE));
		R_Square=Double.parseDouble(df.format(R_Square)); 
		AE=Double.parseDouble(df.format(AE)); 
		MSPE=Double.parseDouble(df.format(MSPE)); 
	}
	public int optimal(double x[],int type)
	{
		int flag=0;
		if(type==1)
		{
			for(int i=1;i<x.length;i++)
			{
					if(x[flag]>x[i]) flag=i;
			}
		}
		if(type==2)
		{
			for(int i=1;i<x.length;i++)
			{
					if(x[flag]<x[i]) flag=i;
			}
		}
		return flag;
	}
	
	
	
	public double getMSE()
	{
		return MSE;
	}
	public double getR_Square()
	{
		return R_Square;
	}
	public double getAE()
	{
		return AE;
	}
	public double getMSPE()
	{
		return MSPE;
	}
	public double[] getRE()
	{
		return RE;
	}
}