package model.combination.lw;

import modelinterface.BasicModel;
import modelinterface.FunctionMiningModel;
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

public class LW implements CombinationModel
{
	private double[] outdata;		//预测数据
	private String[] modelselect;
	private double[][] fitnessdata;
	private double[] fitnessdata_combination;
	private double[][] predictdata;
	private String process;
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
	
	private FunctionMiningModel FactoryCombination(String model)
	{
		if(model.equals("BPN")) return new BPN();
		if(model.equals("GEP")) return new GEP();
		return new BPN();
	}
	
	public void inputdata(double data[],int step,String[] modelselect,double[][] parameter)
	{
		outdata = new double[step];
		fitnessdata = new double[data.length][modelselect.length-1];
		fitnessdata_combination = new double[data.length];
		double[][] fitness = new double[modelselect.length-1][data.length];
		predictdata=new double[modelselect.length-1][step];
		double[][] predictdata_x=new double[step][modelselect.length-1];
		this.modelselect=modelselect.clone();
		for(int i=0;i<modelselect.length-1;i++)
		{
			BasicModel basicModel = Factory(modelselect[i]);
			basicModel.inputdata(data, parameter[i]);			//输出计算结果
			predictdata[i] = basicModel.getoutdata(step).clone();		//输出模型过程
			fitness[i] = basicModel.getfitness().clone();
		}
		for(int i=0;i<fitnessdata.length;i++)
		{
			for(int j=0;j<fitnessdata[i].length;j++)
			{
				fitnessdata[i][j] = fitness[j][i];
			}
		}
		for(int i=0;i<predictdata_x.length;i++)
		{
			for(int j=0;j<predictdata_x[i].length;j++)
			{
				predictdata_x[i][j] = predictdata[j][i];
			}
		}
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//定义数字格式
		int count = 0;
		for(int i=0;i<fitnessdata.length;i++)
		{
			int flag = 0;
			for(int j=0; j<fitnessdata[i].length; j++)
			{
				if(fitnessdata[i][j] == 0.001) flag=1;
			}
			if(flag==1)
			{
				fitnessdata_combination[i] = 0.001;
				count++;
			}
			else break;
		}
		double[][] data_x = new double[fitnessdata.length-count][];
		double[] result = new double[fitnessdata.length-count];
		for(int i=0;i<data_x.length;i++)
		{
			data_x[i] = fitnessdata[count+i].clone();
			result[i] = data[count+i];
		}
		FunctionMiningModel basicModel_FunctionMining = 
				FactoryCombination(modelselect[modelselect.length-1]);
		basicModel_FunctionMining.inputdata2(data_x, result, parameter[parameter.length-1]);
		double[] fitness_x = basicModel_FunctionMining.getfitness2();
		for(int i=0;i<fitness_x.length;i++)
		{
			fitnessdata_combination[count+i] =
					Double.parseDouble(df.format(fitness_x[i]));
		}
		outdata = basicModel_FunctionMining.getoutdata2(step, predictdata_x);
		process = basicModel_FunctionMining.getprocess();
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
		for(int i=1;i<=modelselect.length-1;i++)
		{
			info = info+i+"："+modelselect[i-1]+"； ";
		}
			info = info+"组合："+modelselect[modelselect.length-1]+"； ";
		return info;
	}
	public String getprocess()
	{
		return process;
	}
}