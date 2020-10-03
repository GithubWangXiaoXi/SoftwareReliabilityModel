package model.mix.ln;

import modelinterface.MixModel;

public class LN implements MixModel
{
	private double[][] outdata;
	private int resolvenumber;
	public void inputdata(double data[], double[] parameter)
	{
		resolvenumber=(int)parameter[0];
		outdata=new double[resolvenumber][data.length];
		for(int i=0;i<resolvenumber;i++)
		{
			for(int j=0;j<data.length;j++)
			{
				outdata[i][j]=Math.random()*1000;
			}
		}
	}
	public double[][] getoutdata()
	{
		return outdata;
	}
	public int getresolvenumber()
	{
		return resolvenumber;
	}
}
