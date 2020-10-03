package model.mix.assemble;

public class Assemble
{
	private double[] outdata;
	private double[][] prc;
	private void assemble_add()
	{
		for(int i=0; i<outdata.length; i++)
		{
			double num = 0;
			for(int j=0; j<prc.length; j++)
			{
				num+=prc[j][i];
			}
			outdata[i] = num;
		}
	}
	public void inputdata(double[][] data,double[][] prc, double[] realdata, String model)
	{
		outdata=new double[prc[0].length];
		this.prc=prc.clone();
		if(model.equals("EMD")||model.equals("SSA")||model.equals("WAVE")||model.equals("LN"))
		{
			assemble_add();
		}
	}
	public double[] getoutdata()
	{
		return outdata;
	}
}
