package model.mix.ssa;


import util.MatrixOperator;
import modelinterface.MixModel;
 
import Jama.*;

public class SSA implements MixModel
{
	private int l;	//���ڳ���  >=2
	private int series_len;		//ԭʼ���г���
	private double[] series; 	//ԭʼ����
	
	private double[] param;   	//�㷨�����б�  { param[0]--���ڳ���, }
	private double[][] output;  //������
	
	private double userPercent;   //�û�ָ�����ڽ�ģ���ݵİٷֱ�
	private double[] singlePercent;		//ÿ���� ���з���װٷֱ�
	private double[] accPercents;		//�ۼӹ��װٷֱ�
	
	//��ô��ڳ���	
	public int getL() {
		return l;
	}


	//���ô��ڳ���
	public void setL(int l) {
		this.l = l;
	}
	

	// ���ԭʼ���г���
	public int getSeries_len() {
		return series_len;
	}


	// ����ԭʼ���г���
	public void setSeries_len(int series_len) {
		this.series_len = series_len;
	}


	// ���ԭʼ����
	public double[] getSeries() {
		return series.clone();
	}


	//����ԭʼ����
	public void setSeries(double[] series) {
		this.series = series.clone();
	}


	//����㷨�����б�
	public double[] getParam() {
		return param.clone();
	}


	//�����㷨�����б�
	public void setParam(double[] param) {
		this.param = param;
	}


	//����㷨������
	public double[][] getOutput() {

		int len = output.length;
		double[][] retMatrix = new double[len][];		
		for(int i = 0; i < len; i++)
		{
			retMatrix[i] = output[i].clone();
		}
		
		return retMatrix;
	}
	
	//�����㷨������
	public void setOutput(double[][] output) {
		
		int row = output.length;
		this.output = new double[row][];
		for(int i = 0; i < row; i++)
		{
			this.output[i] = output[i].clone();
		} 
	}
 
	
	//���������еķ���װٷֱ�
	public double[] getSinglePercent()
	{
		double[] sp = singlePercent.clone();
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.0000");	//�������ָ�ʽ
		for(int i=0;i<sp.length;i++)
		{
			sp[i] = Double.parseDouble(df.format(sp[i]));
		}
		return sp.clone();
	}

	
	//���������е� �ۼӷ���װٷֱ�
	public double[] getAccPercents() 
	{
		return accPercents.clone();
	}
	
	//---��д��������
	@Override
	public void inputdata(double[] data, double[] parameter) {
		
		setSeries(data);
		setParam(parameter);	
		series_len = series.length;
		//��ò���--���ڳ���
		userPercent = param[0];
        l = (int)(param[1]+0.1);
        
		runSSA();
	}

	@Override
	public double[][] getoutdata()
	{
		return getOutput();
	}


	
	//����Hankel ����
	double[][] Hankel()
	{
		int k = series_len - l +1;
		double[][] retHankle = new double[l][k];
		
		for(int i = 0; i < k; i++)
		{
			for(int j = 0; j < l; j++)
			{
				retHankle[j][i] = series[i+j];
			}			
		}	
		
		return retHankle;
	}
	
	//�Ծ������  Hankelization��
	public double[] Hankelization(final double[][] y)
	{		
		double[] retHankel = new double[series_len];
		int L1 = y.length;
		int K1 = y[0].length;
		
		int N = L1 + K1 - 1;
		int L = Math.min(L1, K1);
		int K = Math.max(L1, K1);
		boolean flag = (L1 > K1);
		
		for(int k = 1; k <= N; k++)
		{
			if(k < L)
			{
				double sum = 0.0;
				for(int m = 1; m <= k; m++)
				{
					int t = k -m +1;
					if(flag)
					{					
						sum = sum + y[m-1][m-1];
					}else
					{
						sum = sum + y[m-1][t-1];
					}
				}
				 
				retHankel[k-1] = sum / k; 
			}else if(k >=L && k <=K)
			{
				double sum1 = 0;
				for(int m = 1; m <= L; m++)
				{
					int t = k - m + 1 ;
					if(flag)
					{
						int temp = t;
						t = m;
						m = temp;
						
						sum1 = sum1 + y[m-1][t-1];
					}else
					{
						sum1 = sum1 + y[m-1][t-1];
					}					
				}
				retHankel[k-1] = sum1 / L;				
			}else if(k >= K && k <= N)
			{
				int num = N - k + 1;
				int len1 = k - K + 1;
				int len2 = N - K + 1;
				double sum2 = 0.0;
				
				for(int m = len1; m <= len2; m++)
				{
					int t = k - m + 1;
					if(flag)
					{
						 int temp = m;
						 m = t;
						 t = temp;
						 sum2 = sum2 + y[m-1][t-1];
					}else
					{
						sum2 = sum2 + y[m-1][t-1];
					}
				}
				 retHankel[k-1] = sum2 / num;
			}
		}
		 
		return retHankel;
	}
	
	//����SSA�㷨
	public void runSSA()
	{		
		//@1��� Hankel ����
		double[][] hankel = Hankel();
		//MatrixOperator.show(hankle);
		
		//@2 ���Э������� S
		double[][] hankleT = MatrixOperator.transposeMatrix(hankel);
		double[][] s = MatrixOperator.multiplyMatrix(hankel, hankleT);
	 	 
		//@3 ��S������ֵ����������	 
		Matrix ms = new Matrix(s); 
	    SingularValueDecomposition svd = new SingularValueDecomposition(ms);
		  
	    //����ֵ���Ӵ�С��˳������
	    double[] singularValues = svd.getSingularValues();
	    
	    //����ÿ������ֵռ����İٷֱȣ���ÿ�������еķ���װٷֱ�
	    singlePercent = new double[singularValues.length];
	    accPercents = new double[singularValues.length];
	    
	    double sum = 0.0;
	    for(int i = 0; i < singularValues.length; i++)
	    {
	    	sum += singularValues[i];
	    }
	    
	    for(int j = 0; j < singularValues.length; j++)
	    {
	    	singlePercent[j] = singularValues[j] / sum;
	    }
	    
	    accPercents[0] = singlePercent[0];
	    for(int k = 1; k < singularValues.length; k++)
	    {
	    	accPercents[k] = singlePercent[k] + accPercents[k-1];
	    }
	    
	    
	    //��������
	    double[][] U = svd.getU().getArray();
		 
	    //ͳ������ֵ��С�� 0  �ĸ���
	    int nonZeroNum = 0;
	    for(int i = 0; i < singularValues.length; i++)
	    {
	    	if(Double.compare(singularValues[i], 0.0) < 0)
	    	{
	    		nonZeroNum++;
	    	}
	    }
		
	    //@4����Vi�����ɷ֣�ֵ
	    
	    double[][] retMatrix = new double[l - nonZeroNum][];
	    
 	    for(int i = 0; i < l - nonZeroNum; i++)
	    {
	    	//��ÿ���ɵ�һ�� ת��Ϊһ����ά����(���� X1 ��)
	    	double[][] ui = new double[l][1];
	    	for(int j = 0; j < l ; j++)
	    	{ 
	    		//��� ����0 ������������Ӧ�� U ���� 
	    		ui[j][0] = U[j][i];
	    	}	    	
	 	 
	    	double[][] temp1 = MatrixOperator.multiplyMatrix(ui, MatrixOperator.transposeMatrix(ui));
	    	 
	    	double[][] ei = MatrixOperator.multiplyMatrix(temp1, hankel);
 
	    	/* X = E1 + E2 + E3 + ..Ei+...
	    	   �Ի�õ�ÿ��Ei ����Hankelization ��
	    	*/
	    	 retMatrix[i] = Hankelization(ei).clone();	    	 
	    }	     
 	    
 	    int index = 0;
 	    for(; index < accPercents.length; index++)
 	    {
 	    	if( Double.compare(accPercents[index], userPercent) == 1)
 	    	{
 	    		break;
 	    	}
 	    }
 	    
 	    int col = retMatrix[0].length;
 	    double[][] retM = new double[index+2][col];
 	    
 	    for(int i = 0; i <= index; i++)
 	    {
 	    	retM[i] = retMatrix[i].clone();
 	    }
 	    
 	    for(int j = index+1; j < retMatrix.length; j++)
 	    {
 	    	for(int k = 0; k < col; k++)
 	    	{
 	    		retM[index+1][k] += retMatrix[j][k];
 	    	}
 	    }
 	     
 	    //setOutput(retMatrix);	   
 	     setOutput(retM);	   
		
 	    return;
	}
}
