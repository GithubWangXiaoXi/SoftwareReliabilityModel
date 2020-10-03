package model.mix.ssa;


import util.MatrixOperator;
import modelinterface.MixModel;
 
import Jama.*;

public class SSA implements MixModel
{
	private int l;	//窗口长度  >=2
	private int series_len;		//原始序列长度
	private double[] series; 	//原始序列
	
	private double[] param;   	//算法参数列表  { param[0]--窗口长度, }
	private double[][] output;  //结果输出
	
	private double userPercent;   //用户指定用于建模数据的百分比
	private double[] singlePercent;		//每个子 序列方差贡献百分比
	private double[] accPercents;		//累加贡献百分比
	
	//获得窗口长度	
	public int getL() {
		return l;
	}


	//设置窗口长度
	public void setL(int l) {
		this.l = l;
	}
	

	// 获得原始序列长度
	public int getSeries_len() {
		return series_len;
	}


	// 设置原始序列长度
	public void setSeries_len(int series_len) {
		this.series_len = series_len;
	}


	// 获得原始序列
	public double[] getSeries() {
		return series.clone();
	}


	//设置原始序列
	public void setSeries(double[] series) {
		this.series = series.clone();
	}


	//获得算法参数列表
	public double[] getParam() {
		return param.clone();
	}


	//设置算法参数列表
	public void setParam(double[] param) {
		this.param = param;
	}


	//获得算法输出结果
	public double[][] getOutput() {

		int len = output.length;
		double[][] retMatrix = new double[len][];		
		for(int i = 0; i < len; i++)
		{
			retMatrix[i] = output[i].clone();
		}
		
		return retMatrix;
	}
	
	//设置算法输出结果
	public void setOutput(double[][] output) {
		
		int row = output.length;
		this.output = new double[row][];
		for(int i = 0; i < row; i++)
		{
			this.output[i] = output[i].clone();
		} 
	}
 
	
	//返回子序列的方差贡献百分比
	public double[] getSinglePercent()
	{
		double[] sp = singlePercent.clone();
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.0000");	//定义数字格式
		for(int i=0;i<sp.length;i++)
		{
			sp[i] = Double.parseDouble(df.format(sp[i]));
		}
		return sp.clone();
	}

	
	//返回子序列的 累加方差贡献百分比
	public double[] getAccPercents() 
	{
		return accPercents.clone();
	}
	
	//---重写函数部分
	@Override
	public void inputdata(double[] data, double[] parameter) {
		
		setSeries(data);
		setParam(parameter);	
		series_len = series.length;
		//获得参数--窗口长度
		userPercent = param[0];
        l = (int)(param[1]+0.1);
        
		runSSA();
	}

	@Override
	public double[][] getoutdata()
	{
		return getOutput();
	}


	
	//计算Hankel 矩阵
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
	
	//对矩阵进行  Hankelization话
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
	
	//运行SSA算法
	public void runSSA()
	{		
		//@1获得 Hankel 矩阵
		double[][] hankel = Hankel();
		//MatrixOperator.show(hankle);
		
		//@2 获得协方差矩阵 S
		double[][] hankleT = MatrixOperator.transposeMatrix(hankel);
		double[][] s = MatrixOperator.multiplyMatrix(hankel, hankleT);
	 	 
		//@3 求S的特征值和特征向量	 
		Matrix ms = new Matrix(s); 
	    SingularValueDecomposition svd = new SingularValueDecomposition(ms);
		  
	    //特征值，从大到小的顺序排列
	    double[] singularValues = svd.getSingularValues();
	    
	    //计算每个特征值占总体的百分比，即每个子序列的方差贡献百分比
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
	    
	    
	    //特征向量
	    double[][] U = svd.getU().getArray();
		 
	    //统计特征值中小于 0  的个数
	    int nonZeroNum = 0;
	    for(int i = 0; i < singularValues.length; i++)
	    {
	    	if(Double.compare(singularValues[i], 0.0) < 0)
	    	{
	    		nonZeroNum++;
	    	}
	    }
		
	    //@4计算Vi（主成分）值
	    
	    double[][] retMatrix = new double[l - nonZeroNum][];
	    
 	    for(int i = 0; i < l - nonZeroNum; i++)
	    {
	    	//将每生成的一列 转化为一个二维矩阵，(行数 X1 列)
	    	double[][] ui = new double[l][1];
	    	for(int j = 0; j < l ; j++)
	    	{ 
	    		//获得 大于0 的特征向量对应的 U 矩阵， 
	    		ui[j][0] = U[j][i];
	    	}	    	
	 	 
	    	double[][] temp1 = MatrixOperator.multiplyMatrix(ui, MatrixOperator.transposeMatrix(ui));
	    	 
	    	double[][] ei = MatrixOperator.multiplyMatrix(temp1, hankel);
 
	    	/* X = E1 + E2 + E3 + ..Ei+...
	    	   对获得的每个Ei 进行Hankelization 化
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
