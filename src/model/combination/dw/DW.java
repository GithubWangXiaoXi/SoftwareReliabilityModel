package model.combination.dw;

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

public class DW implements CombinationModel
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
		if(model.equals("GammaSRM")) return new GammaSRM();
		if(model.equals("ExponentialSRM")) return new ExponentialSRM();
		if(model.equals("LogNormalSRM")) return new LogNormalSRM();
		if(model.equals("SCHNEIDEWIND")) return new Schneidewind();
		if(model.equals("WEIBULL")) return new Weibull();
		return new BPN();
	}
	public void inputdata(double data[],int step,String[] modelselect,double[][] parameter)
	{
		outdata = new double[step];
		double[] w = new double[modelselect.length];
		double [] PL = new double[modelselect.length];
		double x1 = 1E150;
		double x2 = 1E50;
		for(int i=0;i<PL.length;i++)
		{
			PL[i] = 1;
		}
		fitnessdata = new double[data.length][modelselect.length];
		fitnessdata_combination = new double[data.length];
		double[][] fitness = new double[modelselect.length][data.length];
		predictdata=new double[modelselect.length][step];
		this.modelselect=modelselect.clone();
		for(int i=0;i<modelselect.length;i++)
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
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//定义数字格式
		process = "拟合阶段：\n";
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
			}
			else
			{
				double num=0;
				int a = 0;
				for(int j=0; j<fitnessdata[i].length; j++)
				{
					PL[j] *= fitnessdata[i][j];
					if(PL[j]> x1 ) a = 1;
					num += PL[j];
				}
				if(a==1)
				{
					num = 0;
					for(int j=0; j<fitnessdata[i].length; j++)
					{
						PL[j] /= x2;
						num += PL[j];
					}
				}
				fitnessdata_combination[i] = 0;
				process = process + "第" + (i+1) + "步： ";
				for(int j=0; j<fitnessdata[i].length; j++)
				{
					w[j] = PL[j] / num;
					fitnessdata_combination[i] += fitnessdata[i][j] * w[j];
					double w_x = Double.parseDouble(df.format(w[j]*100));
					process = process + fitnessdata[i][j] + "（" + w_x + "%）    ";
				}
				fitnessdata_combination[i] = Double.parseDouble(df.format(fitnessdata_combination[i]));
				process = process + "---->   " + fitnessdata_combination[i] + "\n";
			}
		}
		process += "\n预测阶段：\n";
		for(int i=0; i<step;i++)
		{
			outdata[i] = 0;
			double num = 0;
			int a = 0;
			for(int j=0;j<modelselect.length;j++)
			{
				PL[j] *= predictdata[j][i];
				if(PL[j]> x1 ) a = 1;
				num += PL[j];
			}
			if(a==1)
			{
				num = 0;
				for(int j=0; j<modelselect.length; j++)
				{
					PL[j] /= x2;
					num += PL[j];
				}
			}
			process = process + "第" + (i+1) + "步： ";
			for(int j=0;j<modelselect.length;j++)
			{
				w[j] = PL[j] / num;
				outdata[i] += predictdata[j][i] * w[j];
				double w_x = Double.parseDouble(df.format(w[j]*100));
				predictdata[j][i] = Double.parseDouble(df.format(predictdata[j][i]));
				process = process + predictdata[j][i] + "（" + w_x + "%）    ";
			}
			outdata[i] = Double.parseDouble(df.format(outdata[i]));
			process = process + "---->   " + outdata[i] + "\n";
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
		return process;
	}
}