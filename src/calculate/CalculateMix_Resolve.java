package calculate;

import model.mix.emd.EMD;
import model.mix.ssa.SSA;
import model.mix.wave.Wave;

public class CalculateMix_Resolve
{
	private double[][] outdata;		//Ԥ������
	private double[] SSA_SinglePercent;
	public void inputdata(double[] data_train,String model, double[] parameter)
	{
		if(model.equals("EMD"))
		{
			EMD emd = new EMD();
			emd.inputdata(data_train, parameter);
			outdata = emd.getoutdata();					//���������
		}
		else if(model.equals("SSA"))
		{
			SSA ssa = new SSA();
			ssa.inputdata(data_train, parameter);
			outdata = ssa.getoutdata();					//���������
			SSA_SinglePercent = ssa.getSinglePercent();
		}
		else if(model.equals("WAVE"))
		{
			Wave wave = new Wave();
			wave.inputdata(data_train, parameter);
			outdata = wave.getoutdata();					//���������
		}
	}
	public double[][] getoutdata()
	{
		double[][] outdata_out = new double[outdata.length][outdata[0].length];
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//�������ָ�ʽ
		for(int i=0;i<outdata.length;i++)
		{
			for(int j=0;j<outdata[0].length;j++)
			{
				outdata_out[i][j]=Double.parseDouble(df.format(outdata[i][j])); 
				//��Ԥ�����ݱ�����λС��
			}
		}
		return outdata_out.clone();
	}
	public double[] getSSA_SinglePercent()
	{
		return SSA_SinglePercent.clone();
	}
	public String getresolvename(String model)
	{
		String resolvename = null;
		if(model.equals("EMD"))
		{
			resolvename="imf_";
		}
		else if(model.equals("SSA"))
		{
			resolvename="pc_";
		}
		else if(model.equals("WAVE"))
		{
			resolvename="wave_";
		}
		return resolvename;
	}
}
