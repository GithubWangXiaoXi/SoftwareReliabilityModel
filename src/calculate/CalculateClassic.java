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
	private double[] outdata;		//Ԥ������
	private String process;			//���̲���
	private String parameterinfo;	//������Ϣ
	private double[] fitness;		//�������
	private double[] u;				//u�ṹͼ����
	private double[] y;				//u�ṹͼ����
	private ClassicModel Factory(String model)	//���󴴽�����
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
		outdata = basicModel.getoutdata(step);					//���������
		fitness = basicModel.getfitness();				//����������
		process = basicModel.getprocess();					//���ģ�͹���
		parameterinfo = basicModel.getparameterinfo();	//���������Ϣ
		u = basicModel.get_ugraph();
		y = basicModel.get_ygraph();
	}
	public double[] getoutdata()
	{
 		double[] outdata_out = new double[outdata.length];
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//�������ָ�ʽ
		for(int i=0;i<outdata.length;i++)
		{
			outdata_out[i]=Double.parseDouble(df.format(outdata[i])); //��Ԥ�����ݱ�����λС��
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
		java.util.Date currentTime=new java.util.Date();//�õ���ǰϵͳʱ�� 
		String date=formatter.format(currentTime); //������ʱ���ʽ��
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