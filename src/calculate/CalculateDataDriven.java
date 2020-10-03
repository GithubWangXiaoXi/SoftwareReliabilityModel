package calculate;

import model.datadriven.arima.ARIMA;
import model.datadriven.bpn.BPN;
import model.datadriven.gep.GEP;
import model.datadriven.gm.GM;
import model.datadriven.rbfn.RBFN;
import model.datadriven.svm.SVM;
import modelinterface.BasicModel;
import phsrm.cphsrm.CPHSRM;

public class CalculateDataDriven
{
	private double[] outdata;		//预测数据
	private String process;
	private String parameterinfo;
	private double[] fitness;
	private BasicModel Factory(String model)
	{
		if(model.equals("ARIMA")) return new ARIMA();
		if(model.equals("BPN")) return new BPN();
		if(model.equals("GEP")) return new GEP();
		if(model.equals("GM")) return new GM();
		if(model.equals("RBFN")) return new RBFN();
		if(model.equals("SVM")) return new SVM();
		if(model.equals("HERSRM")) return new SVM();
		return new BPN();
	}
	public void inputdata(double[] data_train,String model, int step, double[] parameter)
	{
		BasicModel basicModel = Factory(model);
		basicModel.inputdata(data_train, parameter);
		outdata = basicModel.getoutdata(step);					//输出计算结果
		fitness = basicModel.getfitness();
		process = basicModel.getprocess();					//输出模型过程
		parameterinfo = basicModel.getparameterinfo();	//输出参数信息
	}
	public double[] getoutdata()
	{
		double[] outdata_out = new double[outdata.length];
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//定义数字格式
		for(int i=0;i<outdata.length;i++)
		{
			outdata_out[i]=Double.parseDouble(df.format(outdata[i])); //将预测数据保留两位小数
		}
		return outdata_out.clone();
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
}
