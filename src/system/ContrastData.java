package system;

public class ContrastData
{
	public String[] modelname = new String[50];
	public double[][] data = new double[50][];
	public String[] date = new String[50];
	public String[] info = new String[50];
	public int[] sequence = new int[50];
	public double[] MSE = new double[50];
	public double[] R_Square = new double[50];
	public double[] AE = new double[50];
	public double[] MSPE = new double[50];
	private int number;
	private int repetitions(String name)
	{
		for(int i=0;i<number;i++)
		{
			if(name.equals(modelname[i])) return 1;
		}
		return 0;
	}
	public void entry(int sequence,String model,double[] predata,int n, String date,String info,double MSE,double R_Square,double AE,double MSPE)
	{
		int k=1;
		String name=model+"_"+String.valueOf(k);
		while(true)
		{
			if(repetitions(name)==1) name=model+"_"+String.valueOf(++k);
			else break;
		}
		if(number<50) 
		{
			modelname[number] = name;
			data[number] = predata.clone();
			this.date[number]=date;
			this.info[number] = info;
			this.sequence[number] = sequence;
			this.MSE[number] = MSE;
			this.R_Square[number] = R_Square;
			this.AE[number] = AE;
			this.MSPE[number] = MSPE;
			number++;
		}
		else number=50;
	}
	public String getmodelname(int i)
	{
		return modelname[i];
	}
	public double[] gettestdata(int i)
	{
		return data[i];
	}
	public String getdate(int i)
	{
		return date[i];
	}
	public double getMSE(int i)
	{
		return MSE[i];
	}
	public double getR_Square(int i)
	{
		return R_Square[i];
	}
	public double getAE(int i)
	{
		return AE[i];
	}
	public double getMSPE(int i)
	{
		return MSPE[i];
	}
	public int getnumber()
	{
		return number;
	}
	public String getinfo(int i)
	{
		return info[i];
	}
	public int getsequence(int i)
	{
		return sequence[i];
	}
	public void init()
	{
		number=0;
	}
}













