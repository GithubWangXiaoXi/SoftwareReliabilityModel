package model.datadriven.bpn;
public class Reconstruction
{
	private double input[][];	//�ع��������
	private double res[];		//�������	
	private int m;	//�ع�ά��
	private int t;	//�ӳٲ���
	private int delaytime()//ȷ���ӳ�ʱ��
	{
		return 1;
	}
	private int dimension(int x)//ȷ���ع�ά��
	{
		return x;
	}
	public Reconstruction(double x[],int y)//���췽������ռ��ع�����
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