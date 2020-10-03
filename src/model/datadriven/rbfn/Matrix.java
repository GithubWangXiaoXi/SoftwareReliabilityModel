package model.datadriven.rbfn;

public class Matrix
{
	private int hidden;
	private int datalength;
	double[][] A;
	double[][] ATA;
	double[][] ATA_1;
	double[][] ATA_1AT;
	private void calculate_ATA()
	{
		double num;
		for(int i=0;i<hidden;i++)
			for(int j=0;j<hidden;j++)
			{
				num=0;
				for(int k=0;k<datalength;k++)
				{
					num+=A[k][i]*A[k][j];
				}
				ATA[i][j]=num;
			}
	}


	private void calculate_ATA_1()
	{
		int i,j,k;
		for(i=0;i<hidden;i++)			//在原始矩阵右侧加上特征矩阵 
		{

			for(j=hidden;j<hidden*2;j++)
				ATA[i][j]=(j-i==hidden)?1:0;
		}
		for(i=0;i<hidden;i++)			//进行初等变换
		{
			if(ATA[i][i]!=1)
			{
				double tmp=ATA[i][i];
				ATA[i][i]=1;
				for(j=i+1;j<hidden*2;j++)
					ATA[i][j]/=tmp;
			}
			for(k=0;k<hidden;k++)
			{
				if(i!=k)
				{
					double tmp=ATA[k][i];
					for(j=0;j<hidden*2;j++)
						ATA[k][j]-=(tmp*ATA[i][j]);
				}
				else continue;
			}
		}
		for(i=0;i<hidden;i++)
			for(j=0;j<hidden;j++)
			{
				ATA_1[i][j]=ATA[i][hidden+j];
			}
	}

	private void calculate_ATA_1AT()
	{
		int i,j,k;
		double num;
		for(i=0;i<hidden;i++)
			for(j=0;j<datalength;j++)
			{
				num=0;
				for(k=0;k<hidden;k++)
				{
					num+=ATA_1[i][k]*A[j][k];
				}
				ATA_1AT[i][j]=num;
			}
	}
	public double[][] calculate(double[][] A, int hidden)
	{
		this.hidden = hidden;
		this.datalength = A.length;
		this.A = A.clone();
		ATA = new double[2*datalength][2*datalength];
		ATA_1 = new double[datalength][datalength];
		ATA_1AT = new double[datalength][datalength];
		calculate_ATA();
		calculate_ATA_1();
		calculate_ATA_1AT();
		return ATA_1AT.clone();
	}
}