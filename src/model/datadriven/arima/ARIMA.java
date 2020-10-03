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
	private double[] outdata;		//Ԥ������
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
	public double[] getoutdata(int step)//����ӿ�
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
		info=info+"����֮һ��"+String.valueOf(cs1)
				+"�� ����֮����"+String.valueOf(cs2)
				+"�� ����֮����"+String.valueOf(cs3)
				+"�� ����֮�ģ�"+String.valueOf(cs4);
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
