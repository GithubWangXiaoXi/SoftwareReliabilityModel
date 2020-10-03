package model.combination.ew;

import modelinterface.BasicModel;
import modelinterface.CombinationModel;
import model.classic.duane.DUANE;
import model.classic.exponential.ExponentialSRM;
import model.classic.gamma.GammaSRM;
import model.classic.go.GO;
import model.classic.jm.JM;
import model.classic.lognormal.LogNormalSRM;
import model.classic.mo.MO;
import model.classic.schneidewind.Schneidewind;
import model.classic.weibull.Weibull;
import model.datadriven.arima.ARIMA;
import model.datadriven.bpn.BPN;
import model.datadriven.gep.GEP;
import model.datadriven.gm.GM;
import model.datadriven.rbfn.RBFN;
import model.datadriven.svm.SVM;

public class EW implements CombinationModel
{
	private double[] outdata;		//预测数据
	private String[] modelselect;
	private double[][] fitnessdata;
	private double[] fitnessdata_combination;
	private double[][] predictdata;
	private double percentage;
	private BasicModel Factory(String model)
	{
		if(model.equals("ARIMA")) return new ARIMA();
		if(model.equals("BPN")) return new BPN();
		if(model.equals("GEP")) return new GEP();
		if(model.equals("GM")) return new GM();
		if(model.equals("RBFN")) return new RBFN();
		if(model.equals("SVM")) return new SVM();
		if(model.equals("DUANE")) return new DUANE();
		if(model.equals("GO")) return new GO();
		if(model.equals("JM")) return new JM();
		if(model.equals("MO")) return new MO();
		if(model.equals("SCHNEIDEWIND")) return new Schneidewind();
		if(model.equals("GammaSRM")) return new GammaSRM();
		if(model.equals("ExponentialSRM")) return new ExponentialSRM();
		if(model.equals("LogNormalSRM")) return new LogNormalSRM();
		if(model.equals("WEIBULL")) return new Weibull();
		return new BPN();
	}
	public void inputdata(double data[],int step,String[] modelselect,double[][] parameter)
	{
		outdata = new double[step];
		fitnessdata = new double[data.length][modelselect.length];
		fitnessdata_combination = new double[data.length];
		double[][] fitness = new double[modelselect.length][data.length];
		predictdata=new double[modelselect.length][step];
		this.modelselect=modelselect.clone();
		double number = (double)modelselect.length;
		percentage = 1/number;
		
		for(int i=0;i<modelselect.length;i++)
		{
			BasicModel basicModel = Factory(modelselect[i]);
			basicModel.inputdata(data, parameter[i]);			//输出计算结果
			predictdata[i] = basicModel.getoutdata(step).clone();		//输出模型过程
			fitness[i] = basicModel.getfitness().clone();
		}
		for(int i=0; i<step;i++)
		{
			double num = 0;
			for(int j=0;j<modelselect.length;j++)
			{
				num += predictdata[j][i]*percentage;
			}
			outdata[i] = num;
		}
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//定义数字格式
		for(int i=0; i<fitnessdata.length; i++)
		{
			int flag = 0;
			for(int j=0; j<fitnessdata[i].length; j++)
			{
				fitnessdata[i][j] = fitness[j][i];
				if(fitnessdata[i][j] == 0.001) flag=1;
			}
			if(flag==1)
			{
				fitnessdata_combination[i] = 0.001;
			}
			else
			{
				double num=0;
				for(int k=0; k<fitnessdata[0].length;k++)
				{
					num += fitnessdata[i][k];
				}
				fitnessdata_combination[i] = Double.parseDouble(df.format(num * percentage));
			}
		}
	}
	public double[] getoutdata()
	{
		return outdata.clone();
	}
	public double[][] getpredictdata()
	{
		return predictdata.clone();
	}
	public double[][] getfitnessdata()
	{
		return fitnessdata.clone();
	}
	public double[] getfitnessdata_combination()
	{
		return fitnessdata_combination.clone();
	}
	public String getparameterinfo()
	{
		String info="";
		for(int i=1;i<=modelselect.length;i++)
		{
			info = info+i+"："+modelselect[i-1]+"； ";
		}
		return info;
	}
	public String getprocess()
	{
		double p = percentage*100;
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//定义数字格式
		p = Double.parseDouble(df.format(p));
		String process = "";
		for(int i=1;i<=modelselect.length;i++)
		{
			process = process + "模型" + i + "：" + modelselect[i-1] 
					+ "   " + p + "%" + "\n\n";
		}
		return process;
	}
}