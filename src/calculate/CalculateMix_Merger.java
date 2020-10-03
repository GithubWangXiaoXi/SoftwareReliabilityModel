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

public class CalculateMix_Merger
{
	private double[] outdata;
	private String[] modelselect;
	private BasicModel Factory(String model)	//对象创建工厂
	{
		if(model.equals("DUANE")) return new DUANE();
		if(model.equals("GO")) return new GO();
		if(model.equals("ExponentialSRM")) return new ExponentialSRM();
		if(model.equals("GammaSRM")) return new GammaSRM();
		if(model.equals("LogNormalSRM")) return new LogNormalSRM();
		if(model.equals("JM")) return new JM();
		if(model.equals("MO")) return new MO();
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
	public void inputdata(double[][] resolvedata, int step, 
							String[] modelselect, double[][] parameter)
	{
		outdata = new double[step];
		this.modelselect = modelselect.clone();
		double[][] mergerdata = new double[resolvedata.length][step];
		for(int i=0; i<resolvedata.length; i++)
		{
			BasicModel basicModel = Factory(modelselect[i]);
			basicModel.inputdata(resolvedata[i], parameter[i]);	//输出计算结果
			mergerdata[i] = basicModel.getoutdata(step).clone();	//输出模型过程
		}
		for(int i=0; i<step; i++)
		{
			double num = 0;
			for(int j=0;j<modelselect.length;j++)
			{
				num += mergerdata[j][i];
			}
			outdata[i] = num;
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
	public String getparameterinfo()
	{
		String info="";
		for(int i=1;i<=modelselect.length;i++)
		{
			info = info+String.valueOf(i)+"："+modelselect[i-1]+"； ";
		}
		return info;
	}
	public String getdate()
	{
		java.text.SimpleDateFormat formatter=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		java.util.Date currentTime=new java.util.Date();//得到当前系统时间 
		String date=formatter.format(currentTime); //将日期时间格式化
		return date;
	}
}