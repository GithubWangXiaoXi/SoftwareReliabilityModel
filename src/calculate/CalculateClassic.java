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
import modelinterface.ClassicModel;

public class CalculateClassic
{
	private double[] outdata;		//预测数据
	private String process;			//过程参数
	private String parameterinfo;	//参数信息
	private double[] fitness;		//拟合数据
	private double[] u;				//u结构图数组
	private double[] y;				//u结构图数组
	private ClassicModel Factory(String model)	//对象创建工厂
	{
		if(model.equals("DUANE")) return new DUANE();
		if(model.equals("GO")) return new GO();
		if(model.equals("JM")) return new JM();
		if(model.equals("MO")) return new MO();
		if(model.equals("GammaSRM")) return new GammaSRM();
		if(model.equals("ExponentialSRM")) return new ExponentialSRM();
		if(model.equals("LogNormalSRM")) return new LogNormalSRM();
		if(model.equals("SCHNEIDEWIND")) return new Schneidewind();
		if(model.equals("WEIBULL")) return new Weibull();
		return new Weibull();
	}
	public void inputdata(double[] data_train,String model, int step, double[] parameter)
	{
		
		ClassicModel basicModel = Factory(model);
		basicModel.inputdata(data_train, parameter);
		outdata = basicModel.getoutdata(step);					//输出计算结果
		fitness = basicModel.getfitness();				//输出拟合数据
		process = basicModel.getprocess();					//输出模型过程
		parameterinfo = basicModel.getparameterinfo();	//输出参数信息
		u = basicModel.get_ugraph();
		y = basicModel.get_ygraph();
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
	public double[] getfitness()
	{
		return fitness.clone();
	}
	public String getprocess()
	{
		return process;
	}
	public String getparameterinfo()
	{
		return parameterinfo;
	}
	public String getdate()
	{
		java.text.SimpleDateFormat formatter=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		java.util.Date currentTime=new java.util.Date();//得到当前系统时间 
		String date=formatter.format(currentTime); //将日期时间格式化
		return date;
	}
	public double[] get_ugraph()
	{
		return u.clone();
	}
	public double[] get_ygraph()
	{
		return y.clone();
	}
}