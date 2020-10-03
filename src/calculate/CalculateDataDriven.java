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
	private double[] outdata;		//Ԥ������
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
		outdata = basicModel.getoutdata(step);					//���������
		fitness = basicModel.getfitness();
		process = basicModel.getprocess();					//���ģ�͹���
		parameterinfo = basicModel.getparameterinfo();	//���������Ϣ
	}
	public double[] getoutdata()
	{
		double[] outdata_out = new double[outdata.length];
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//�������ָ�ʽ
		for(int i=0;i<outdata.length;i++)
		{
			outdata_out[i]=Double.parseDouble(df.format(outdata[i])); //��Ԥ�����ݱ�����λС��
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
		java.util.Date currentTime=new java.util.Date();//�õ���ǰϵͳʱ�� 
		String date=formatter.format(currentTime); //������ʱ���ʽ��
		return date;
	}
}
