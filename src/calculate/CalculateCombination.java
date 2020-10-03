package calculate;

import model.combination.ew.EW;
import model.combination.lw.LW;
import model.combination.nlw.NLW;
import model.combination.dw.DW;
import model.combination.bcm.BCM;
import modelinterface.CombinationModel;

public class CalculateCombination
{
	private double[] outdata;		//预测数据
	private double[][] predictdata;
	private double[][] fitnessdata;
	private double[] fitnessdata_combination;
	private String process;
	private String parameterinfo;
	private CombinationModel Factory(String model)
	{
		if(model.equals("EW")) return new EW();
		if(model.equals("LW")) return new LW();
		if(model.equals("NLW")) return new NLW();
		if(model.equals("DW")) return new DW();
		if(model.equals("BCM")) return new BCM();
		return new EW();
	}
	public void inputdata(double[] data_train,String model, 
							int step, String[] modelselect, double[][] parameter)
	{
		CombinationModel combinationModel = Factory(model);
		combinationModel.inputdata(data_train, step, modelselect, parameter);
		outdata = combinationModel.getoutdata();					//输出计算结果
		predictdata = combinationModel.getpredictdata();					//输出模型过程
		fitnessdata = combinationModel.getfitnessdata();			//输出拟合数据	
		fitnessdata_combination = combinationModel.getfitnessdata_combination();
		process = combinationModel.getprocess();
		parameterinfo = combinationModel.getparameterinfo();	//输出参数信息
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
	public double[][] getpredictdata()
	{
		double[][] data = predictdata.clone();
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//定义数字格式
		for(int i=0;i<predictdata.length;i++)
		{
			for(int j=0;j<predictdata[0].length;j++)
			{
				data[i][j] = Double.parseDouble(df.format(data[i][j]));
			}
		}
		return data.clone();
	}
	public double[][] getfitnessdata()
	{
		return fitnessdata.clone();
	}
	public double[] getfitnessdata_combination()
	{
		return fitnessdata_combination.clone();
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
