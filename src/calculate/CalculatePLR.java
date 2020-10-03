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

public class CalculatePLR {
	private double[] modelA;	//模型A密度函数数组
	private double[] modelB;	//模型B密度函数数组
	
	private ClassicModel Factory(String model)
{
		if (model.equals("DUANE"))
			return new DUANE();
		if (model.equals("GO"))
			return new GO();
		if (model.equals("JM"))
			return new JM();
		if (model.equals("MO"))
			return new MO();
		if (model.equals("SCHNEIDEWIND"))
			return new Schneidewind();
		if (model.equals("ExponentialSRM"))
			return new ExponentialSRM();
		if (model.equals("GammaSRM"))
			return new GammaSRM();
		if (model.equals("LogNormalSRM"))
			return new LogNormalSRM();
		if (model.equals("WEIBULL"))
			return new Weibull();
		return new Weibull();
	}

	public void inputdata(double[] data_train,String model1,String model2,String[] parameter1_str,String[] parameter2_str) {
		double[] parameter1 = new double[parameter1_str.length];
		double[] parameter2 = new double[parameter2_str.length];
		for(int i = 0 ; i < parameter1.length ; i ++)
		{
			parameter1[i] = Double.parseDouble(parameter1_str[i]);
		}
		for(int i = 0 ; i < parameter2.length ; i ++)
		{
			parameter2[i] = Double.parseDouble(parameter2_str[i]);
		}
		
		ClassicModel basicModel = Factory(model1);
		basicModel.inputdata(data_train, parameter1);
		modelA = basicModel.get_PLR();

		basicModel = Factory(model2);
		basicModel.inputdata(data_train, parameter2);
		modelB = basicModel.get_PLR();
	}

	public double[] getoutdata() {
		double[] PLR = new double[modelA.length];
		java.text.DecimalFormat df = new java.text.DecimalFormat("#.00"); // 定义数字格式
		for (int i = 0; i < PLR.length; i++) {
			double sum = 1;
			sum = sum * modelA[i] / modelB[i];
			PLR[i] = sum;
			PLR[i] = Double.parseDouble(df.format(PLR[i])); // 将预测数据保留两位小数
		}
		return PLR;
	}
}
