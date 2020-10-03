package model.datadriven.arima;

import java.util.Random;
import java.util.Vector;

import arima.AR;
import arima.ARMA;
import arima.ARMAMath;
import arima.MA;
import modelinterface.BasicModel;

public class ARIMA implements BasicModel
{
	private double[] data;
	private double[] outdata;		//预测数据
	private String process;
	private double cs1;
	private double cs2;
	private double cs3;
	private double cs4;
	
	
	
	
	public void inputdata(double[] data,double[] parameter)
	{
		this.data=data.clone();
		//process="weibull process";
		this.cs1=parameter[0];
		this.cs2=parameter[1];
		this.cs3=parameter[2];
		this.cs4=parameter[3];
		ARI_MA arima=new ARI_MA(data); 
		int []model=arima.getARIMAmodel();
		int p=model[0];
		int q=model[1];
	}
	public double[] getoutdata(int step)//输出接口
	{
		ARI_MA arima=new ARI_MA(data);
		int []model=arima.getARIMAmodel();
		outdata=new double[step];
		for(int i=0;i<step;i++)
		{
			outdata[i]=arima.aftDeal(arima.predictValue(model[0],model[1]));
		}
		return outdata;
	}
	public String getprocess()
	{
		return process;
	}
	public String getparameterinfo()
	{
		String info="";
		info=info+"参数之一："+String.valueOf(cs1)
				+"； 参数之二："+String.valueOf(cs2)
				+"； 参数之三："+String.valueOf(cs3)
				+"； 参数之四："+String.valueOf(cs4);
		return info;
	}
	public double[] getfitness()
	{
		ARI_MA arima=new ARI_MA(data);
		int []model=arima.getARIMAmodel();
		double[] fitness = new double[data.length];
		for(int i=0; i<data.length; i++)
		{
			fitness[i] =arima.aftDeal(arima.predictValue(model[0],model[1])); 
		}
		return fitness.clone();
	}
}
