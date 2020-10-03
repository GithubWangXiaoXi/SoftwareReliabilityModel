package calculate;

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
import modelinterface.BasicModel;

public class CalculateMix_LN
{
	private double[][] resolvedata = new double[2][1];
	private int step;
	private double[] outdata;
	private double[] data_prediction;
	private BasicModel Factory(String model)	//对象创建工厂
	{
		if(model.equals("DUANE")) return new DUANE();
		if(model.equals("GO")) return new GO();
		if(model.equals("JM")) return new JM();
		if(model.equals("MO")) return new MO();
		if(model.equals("ExponentialSRM")) return new ExponentialSRM();
		if(model.equals("GammaSRM")) return new GammaSRM();
		if(model.equals("LogNormalSRM")) return new LogNormalSRM();
		if(model.equals("SCHNEIDEWIND")) return new Schneidewind();
		if(model.equals("WEIBULL")) return new Weibull();
		if(model.equals("ARIMA")) return new ARIMA();
		if(model.equals("BPN")) return new BPN();
		if(model.equals("GEP")) return new GEP();
		if(model.equals("GM")) return new GM();
		if(model.equals("RBFN")) return new RBFN();
		if(model.equals("SVM")) return new SVM();
		return new BPN();
	}
	public double[][] inputdata(double[] data, int step, String model, double[] parameter)
	{
		this.step = step;
		outdata = new double[step];
		BasicModel basicModel = Factory(model);
		basicModel.inputdata(data, parameter);			//输出计算结果
		resolvedata[0] = basicModel.getfitness();
		data_prediction = basicModel.getoutdata(step);
		resolvedata[1] = new double[resolvedata[0].length];
		for(int i=0; i<data.length; i++)
		{
			resolvedata[1][i] = data[i] - resolvedata[0][i];
		}
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//定义数字格式
		for(int i=0;i<resolvedata.length;i++)
		{
			for(int j=0;j<resolvedata[0].length;j++)
			{
				resolvedata[i][j] = Double.parseDouble(df.format(resolvedata[i][j])); 
					//将预测数据保留两位小数
			}
		}
		return resolvedata.clone();
	}
	public void calculate(String model, double[] parameter)
	{
		double[] dd = new double[1];
		if(model.equals("DUANE"))
		{
			DUANE duane = new DUANE();
			duane.inputdata(resolvedata[1], parameter);			//输出计算结果
			dd = duane.getoutdata(step);
		}
		else if(model.equals("GO"))
		{
			GO go = new GO();
			go.inputdata(resolvedata[1], parameter);
			dd = go.getoutdata(step);
		}
		else if(model.equals("JM"))
		{
			JM jm = new JM();
			jm.inputdata(resolvedata[1], parameter);
			dd = jm.getoutdata(step);
		}
		else if(model.equals("MO"))
		{
			MO mo = new MO();
			mo.inputdata(resolvedata[1], parameter);
			dd = mo.getoutdata(step);
		}
		else if(model.equals("ExponentialSRM"))
		{
			ExponentialSRM expo = new ExponentialSRM();
			expo.inputdata(resolvedata[1], parameter);
			dd = expo.getoutdata(step);
		}
		else if(model.equals("LogNormalSRM"))
		{
			LogNormalSRM log = new LogNormalSRM();
			log.inputdata(resolvedata[1], parameter);
			dd = log.getoutdata(step);
		}
		else if(model.equals("GammaSRM"))
		{
			GammaSRM gam = new GammaSRM();
			gam.inputdata(resolvedata[1], parameter);
			dd = gam.getoutdata(step);
		}
		else if(model.equals("WEIBULL"))
		{
			Weibull weibull = new Weibull();
			weibull.inputdata(resolvedata[1], parameter);
			dd = weibull.getoutdata(step);
		}
		else if(model.equals("SCHNEIDEWIND"))
		{
			Schneidewind schneidewind = new Schneidewind();
			schneidewind.inputdata(resolvedata[1], parameter);
			dd = schneidewind.getoutdata(step);
		}
		else if(model.equals("BPN"))
		{
			BPN bpn = new BPN();
			bpn.inputdata(resolvedata[1], parameter);
			dd = bpn.getoutdata(step);
		}
		else if(model.equals("RBFN"))
		{
			RBFN rbfn = new RBFN();
			rbfn.inputdata(resolvedata[1], parameter);
			dd = rbfn.getoutdata(step);
		}
		else if(model.equals("GEP"))
		{
			GEP gep = new GEP();
			gep.inputdata(resolvedata[1], parameter);
			dd = gep.getoutdata(step);
		}
		else if(model.equals("SVM"))
		{
			SVM svm = new SVM();
			svm.inputdata(resolvedata[1], parameter);
			dd = svm.getoutdata(step);
		}
		else if(model.equals("GM"))
		{
			GM gm = new GM();
			gm.inputdata(resolvedata[1], parameter);
			dd = gm.getoutdata(step);
		}
		else if(model.equals("ARIMA"))
		{
			ARIMA arima = new ARIMA();
			arima.inputdata(resolvedata[1], parameter);
			dd = arima.getoutdata(step);
		}
		for(int i=0; i<step; i++)
		{
			outdata[i] = data_prediction[i] + dd[i];
		}
	}
	public double[] getoutdata()
	{
 		double[] outdata_out = new double[outdata.length];
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//定义数字格式
		for(int i=0;i<outdata.length;i++)
		{
			outdata_out[i]=Double.parseDouble(df.format(outdata[i])); //将预测数据保留两位小数
		}
		return outdata_out;
	}
	public String getparameterinfo(String model1, String model2)
	{
		String info="";
		info = "1："+model1+"；2："+model2;
		return info;
	}
	public String getdate()
	{
		java.text.SimpleDateFormat formatter=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		java.util.Date currentTime=new java.util.Date();//得到当前系统时间 
		String date=formatter.format(currentTime); //将日期时间格式化
		return date;
	}
	public int getstep()
	{
		return step;
	}
}
