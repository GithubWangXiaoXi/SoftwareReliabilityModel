package model.datadriven.bpn;
public class Reconstruction
{
	private double input[][];	//重构后的数据
	private double res[];		//样本结果	
	private int m;	//重构维数
	private int t;	//延迟步数
	private int delaytime()//确定延迟时间
	{
		return 1;
	}
	private int dimension(int x)//确定重构维数
	{
		return x;
	}
	public Reconstruction(double x[],int y)//构造方法，相空间重构过程
	{
		t=delaytime();
		m=dimension(y);
		input=new double[x.length-m][];
		for(int i=0;i<x.length-m;i++)
		{
			input[i]=new double[m];
		}
		res=new double[x.length-m];
		for(int i=0;i<x.length-m;i++)
		{
			for(int j=0,k=0;j<m;j++,k++)
			{
				input[i][j]=x[i+k*t];
			}
			res[i]=x[i+m];
		}
	}
	public double[][] getInput()
	{
		return input;
	}
	public double[] getRes()
	{
		return res;
	}
	public int getm()
	{
		return m;
	}
	public int getn()
	{
		return res.length;
	}
}