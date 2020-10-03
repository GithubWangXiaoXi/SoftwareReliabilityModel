package util;

import java.util.Arrays;

/**
 * 封装对于矩阵操作的方法，包含显示矩阵，求逆矩阵等   
 *
 * @author Marshal
 */
public class MatrixOperator   
{   
	/**
	 * 默认构造函数
	 */
    private MatrixOperator()
    {
    	
    }   
    
    
    /**
     * 将长度为n的一维的数组转化为，n×1的二维矩阵
     * 方便矩阵的计算
     */
    public static double[][] arrayToMatrix(double[] array)
    {
    	double[][] backMatrix = new double[array.length][1];
    	for(int i = 0; i<array.length; i++)
    	{
    		backMatrix[i][0] = array[i]; 
    	}    	
    	
    	return backMatrix;
    }
    
    /**
     * 将n×1的二维矩阵(列向量)，转化为长度为n的一维的数组
     *  
     */
    public static double[] matrixToArray(double[][] matrix)
    {
    	int row = matrix.length;
    	double[] backMatrix = new double[row] ;

    	for(int i = 0; i<row; i++)
    	{
    		backMatrix[i] = matrix[i][0];
    	}
    	 
    	return backMatrix;
    }
    
    
    /**
     * 获取矩阵的--逆
     * 注：在此运算中 数组的元素从1开始， 即最小元素小标为a[1][1].
     * 此函数只在本类中的reverseMatrix(double[][]) 函数调用， 故将其设置为 私有成员
     */
    private static double[][] reverse(double[][] matrix)   
    {   
        double[][] temp;   
        double[][] back_temp = new double[matrix.length][matrix.length];   
        //得到矩阵的阶数   
        int m_length = matrix.length;   
        //创建n*（2n-1）行列式，用来求逆矩阵，原矩阵和单位矩阵   
        temp = new double[m_length][2*m_length-1];   
        
        //创建返回的矩阵,初始化 .对原始矩阵拷贝          
        for(int i=0; i<matrix.length; i++)
        {
        	back_temp[i] = matrix[i].clone();        	
        }
        
        //back_temp = matrix;   
        //将原矩阵的值赋给 temp矩阵，并添加单位矩阵的值   
        for(int x=1;x<m_length;x++)   
        {   
            for(int y=1;y<temp[0].length;y++)   
            {   
                if(y>m_length-1)   
                {   
                    if(x==(y-m_length+1))    
                        temp[x][y]=1;   
                    else
                        temp[x][y]=0;   
                }   
                else
                {   
                    temp[x][y]=matrix[x][y];   
                }   
            }   
        }   
        //System.out.println("组合矩阵:");   
        //showMatrix(temp);   
        //高斯消元求逆矩阵   
        for(int x=1;x<m_length;x++)   
        {   
            double var=temp[x][x];   
            //判断对角线上元素是否为0，是的话与后面的行进行交换行，如没有满足条件的   
            //则可认为原矩阵没有逆矩阵。然后取值要化为0的列的值   
            for(int w=x;w<temp[0].length;w++)   
            {   
                if(temp[x][x]==0)   
                {   int k;   
                    for(k=x+1;k<temp.length;k++)   
                    {      
                        if(temp[k][k]!=0)   
                        {   
                            for(int t=1;t<temp[0].length;t++)   
                            {   //System.out.println(">>>"+k+"<<<");   
                                double tmp=temp[x][t];   
                                temp[x][t]=temp[k][t];   
                                temp[k][t]=tmp;   
                            }   
                        break;   
                        }   
                    }   
                    //System.out.println(""+k);   
                    //如果出现无法将temp矩阵的左边化为单位矩阵，返回原矩阵   
                    if(k>=temp.length) 
                    	return back_temp;   
                    var=temp[x][x];   
                   // System.out.print("第 " + x + "次变换前替换主元上的 0");   
                   //System.out.println("(将  " + x + " 行与第 " + k +" 行进行交换)：");   
                   // showMatrix(temp);   
                }   
                temp[x][w] /=var;   
            }   
            //将第x列的元素出对角线上的元素外都化为0，即构建单位矩阵   
            for(int z=1;z<m_length;z++)   
            {   double var_tmp=0.0;   
                for(int w=x;w<temp[0].length;w++)   
                {   //System.out.println("-"+x+"-"+z+"-"+w+"+++" + temp[z][w]);    
                    if(w==x) var_tmp=temp[z][x];   
                    if(x!=z) temp[z][w] -=(var_tmp*temp[x][w]);   
                           
                }   
            }   
           // System.out.println("第 " + x + "次变换:");   
           // showMatrix(temp);   
        }   
        //取逆矩阵的值   
        for(int x=1;x<m_length;x++)   
        {   
            for(int y=1;y<m_length;y++)   
            {   
                back_temp[x][y]=temp[x][y+m_length-1];   
            }      
        }   
        return back_temp;   
    }   
    
    
    /**
     * 计算逆矩阵
     * @param matrix 输入矩阵
     * @return 逆矩阵
     */
    public static double[][] reverseMatrix(double[][] matrix) 
    {
    	//对multiply2扩展
    	int row = matrix.length;
    	int col = matrix[0].length;
    	
		double[][] extendsMultiply2 = new double[row+1][col+1];
		
		for(int i = 1; i < row + 1; i++)
		{
			for(int j = 1; j < col + 1; j++)
			{
				extendsMultiply2[i][j] = matrix[i-1][j-1];
			}			
		}	
		 
		//对extendsMultiply2求逆
		double[][] multiply2Reverse = MatrixOperator.reverse(extendsMultiply2);
		 
		//对求得的逆矩阵进行下标还原，即数组最小下标值从0开始
		double[][] reduseMultiply2 = new double[row][col];
		for(int i = 0; i < row; i++)
		{
			for(int j = 0; j < col; j++)
			{
				reduseMultiply2[i][j] = multiply2Reverse[i+1][j+1];
			}			
		}
    		 
    	
      return reduseMultiply2;	
    }
        
    /**
     * 计算转置矩阵
     * @param matrix 待转置矩阵
     * @return 转置矩阵
     */
    public static double[][] transposeMatrix(double[][] matrix)
    {
    	int row = matrix.length;  
    	int col = matrix[0].length;
    	double[][] backMatrix = new double[col][row];
    	
    	//转置
    	for(int i= 0; i < row; i++)
    	{
    		for(int j = 0; j < col; j++)
    		{    	 
    			backMatrix[j][i] = matrix[i][j];
    		}    		     		
    	}
    	 
    	return backMatrix;
    }
    
    /**
     * 计算矩阵相乘
     * 
     */    
    public static double[][] multiplyMatrix (double[][] lMatrix, double[][] rMatrix)
    {
    	int lRow = lMatrix.length;
    	int lCol = lMatrix[0].length;
    	int rRow = rMatrix.length;
    	int rCol = rMatrix[0].length;
    	
    	if(lCol != rRow)
    	{
    		throw new IllegalArgumentException("左矩阵的列数和右矩阵的行数不相等，矩阵相乘失败！");    		
    	}
    	
        //乘积矩阵
    	double[][] backMatrix = new double[lRow][rCol];
    	for(int i = 0; i < lRow; i++)
    	{
    		for(int j = 0; j < rCol; j++)
    		{    			
    			//相乘得到的矩阵 a[i][j]; 为左矩阵的第i行 乘以 右矩阵的第 j列
    			double sum = 0;
    			for(int k = 0, n = 0; (n < rRow && k < lCol); n++,k++)
    			{    
    				sum +=  lMatrix[i][k] * rMatrix[n][j];    					 				     				
    			}    			
    			backMatrix[i][j] = sum;
    		}    		
    	}    	
    	
    	return backMatrix;
    }
     
    /**
     * 显示（打印）矩阵
     * @param matrix
     */
    public static void show(double[][] matrix)
    {
    	int row = matrix.length;
    	    	
    	for(int i = 0; i < row; i++)
    	{
    		 System.out.println(i+"---] "+Arrays.toString(matrix[i]));    		
    	}   
    	
    	return;
    }
    
    
    /**
     * 线性方程组求解 Ax=b
     * @param a 方程组系数矩阵
     * @param n 未知数个数
     * @param b 值向量
     * @return 解向量
     */
	public static double[] equationsSolution(double a[], int n, double b[])
	{
        int i, j, k, l, ll, irow, icol;
        icol = 0;
        irow = 0;
        double big, pivinv, dum;
        int ipiv[] = new int[50];
        int indxr[] = new int[50];
        int indxc[] = new int[50];
        for (j = 0; j <= n - 1; j++)
        {            
            ipiv[j] = 0;
        }
        for (i = 0; i <= n - 1; i++)
		{
            big = 0.0;
            for (j = 0; j <= n - 1; j++)
			{
                if (ipiv[j] != 1)
				{
                    for (k = 0; k <= n - 1; k++)
					{
                        if (ipiv[k] == 0)
						{
                            if (Math.abs(a[j * n + k]) >= big)
							{
                                big = Math.abs(a[j * n + k]);
                                irow = j;
                                icol = k;
							}
                            else if (ipiv[k] > 1)
							{
								System.out.println("singular matrix");
							}
						}
                    }
                }
            }
            ipiv[icol] = ipiv[icol] + 1;
            if (irow != icol)
			{
                for (l = 0; l <= n - 1; l++)
				{
                    dum = (a[irow * n + l]);
                    a[irow * n + l] = a[icol * n + l];
                    a[icol * n + l] = dum;
                }
                dum = b[irow];
                b[irow] = b[icol];
                b[icol] = dum;
			}
            indxr[i] = irow;
            indxc[i] = icol;
            if (a[icol * n + icol] == 0.0)
			{
            	throw new IllegalArgumentException("线性方程组系数为 奇异矩阵！");
				 
			}
            pivinv = 1.0 / (a[icol * n + icol]);
            a[icol * n + icol] = 1.0;
            for (l = 0; l <= n - 1; l++)
            {
                a[icol * n + l] = a[icol * n + l] * pivinv;
            }
            b[icol]=b[icol] * pivinv;
            for (ll = 0; ll <= n - 1; ll++)
            {
                if (ll != icol)
                {
                    dum = a[ll * n + icol];
                    a[ll * n + icol] = 0.0;
                    for (l = 0; l <= n - 1; l++)
                    {
                        a[ll * n + l] = a[ll * n + l] - a[icol * n + l] * dum;
                    }
                    b[ll] = b[ll] - b[icol] * dum;
                }
            } 
            for (l = n - 1; l <= 0; l--)
            {
                if (indxr[l] != indxc[l])
                {
                    for (k = 0; k <= n - 1; k++)
                    {
                        dum = a[k * n + indxr[l]];
                        a[k * n + indxr[l]] = a[k * n + indxc[l]];
                        a[k * n + indxr[l]] = dum;
                    }
                }
            }
        }
        return b;
	}
    
	/**
	 * 矩阵相加 
	 * 
	 * @param lMatrix
	 * @param rMatrix
	 */
    public static double[][] add(double[][] lMatrix, double[][] rMatrix)
    {
    	int lRow = lMatrix.length;
    	int lCol = lMatrix[0].length;    	
    	int rRow = rMatrix.length;
    	int rCol = rMatrix[0].length;
    	    	
    	//待相加的两个矩阵的合法性检验
    	if((lRow != rRow) || (lCol != rCol))
			throw new IllegalArgumentException("待相加矩阵行或列数不相等!");      
       	
       	double[][] backMatrix = new double[lRow][lCol];
       	
    	for(int row = 0; row<lRow; row++)
    	{
    		for(int col = 0; col<lCol; col++ )
    		{
    			backMatrix[row][col] = lMatrix[row][col] + rMatrix[row][col];
    		}    		
    	}    	
    	 
    	return backMatrix;
    }
    
    
	/**
	 * 矩阵相减，左矩阵减去右矩阵
	 * 
	 * @param lMatrix
	 * @param rMatrix
	 */
    public static double[][] minus(double[][] lMatrix, double[][] rMatrix)
    {
    	//将右矩阵*-1， 加至左矩阵
    	double[][] contraryMatrix = multiply(rMatrix, -1.0);    	
    	
    	return add(lMatrix, contraryMatrix);
    }
    
         
    /**
	 * 矩阵处除法，matrix矩阵中的每个元素除以 常数 i
     */
    public static double[][] divide(double[][] matrix, double divided)
    {
    	int row = matrix.length;
    	int col = matrix[0].length;
    	
    	double[][] backMatrix = new double[row][col];
    	for(int i= 0; i<row; i++)
    	{
    		for(int j = 0; j<col; j++)
    		{
    			backMatrix[i][j] = matrix[i][j]/divided;
    		}    		
    	}
      	
    	return backMatrix;
    }
    
    
    /**
   	 * 矩阵乘法，matrix矩阵中的每个元素乘以 常数 i
     */
    public static double[][] multiply(double[][] matrix, double multi)
    {
       	int row = matrix.length;
       	int col = matrix[0].length;
       	
       	double[][] backMatrix = new double[row][col];
       	for(int i= 0; i<row; i++)
       	{
       		for(int j = 0; j<col; j++)
       		{
       			backMatrix[i][j] = matrix[i][j] * multi;
       		}    		
       	}
         	
       	return backMatrix;
    }
   
    /**
     * 对解释变量 数组中的元素求对数 
     * 根据输入数据矩阵的含义， 只对数组  列不为0的元素进行处理
     */
    public static double[][] lnX(double[][] matrix, double baseNumber)
    {
   	 	if(Double.compare(baseNumber, 0)<=0
    		 || Double.compare(baseNumber, 1.0) == 0)
    	 {
    		 throw new IllegalArgumentException("对数的底数不得  小于，等于0; 或者等于 1 ");
    	 }
    	int row = matrix.length;
    	int col = matrix[0].length;
    	double[][] backMatrix = new double[row][col];
    	
    	for(int i = 0; i<row; i++)
    	{
    		backMatrix[i][0] = matrix[i][0];   
    		for(int j = 1 ; j<col; j++)
    		{    			
    			backMatrix[i][j] = Math.log(matrix[i][j])/ Math.log(baseNumber);    			
    		}    		
    	}
    	
    	return backMatrix;    	
    }
     
    /**
     * 对被解释变量数组中元素 求对数
     */
    public static double[][] lnY(double[][] matrix, double baseNumber)
    {
    	int row = matrix.length;
    	 
    	double[][] backMatrix = new double[row][1];
    	
    	for(int i = 0; i<row; i++)
    	{
    		backMatrix[i][0] = Math.log(matrix[i][0]) / Math.log(baseNumber);     		   		
    	}
    	
    	return backMatrix;    	
    }
      
     
    
    /**
     * 对数组中的元素求倒数
     * 根据输入数据矩阵的含义， 只对数组  列不为0的元素进行处理!
     */
    public static double[][] reciprocal(double[][] matrix)
    {
    	int row = matrix.length;
    	int col = matrix[0].length;
    	double[][] backMatrix = new double[row][col];
    	
    	for(int i = 0; i<row; i++)
    	{
    		backMatrix[i][0] = matrix[i][0];
    		for(int j = 1; j<col; j++)
    		{
    			backMatrix[i][j] =  1.0 / matrix[i][j];    			
    		}    		
    	}
    	
    	return backMatrix;       	
    }
    
    
    /**
     * BOX-COX转化
     * @param lamda 决定转化的形式
     * 根据输入数据矩阵的含义， 只对数组  列不为0的元素进行处理
     */
    public static double[][] boxCox(double[][] matrix, double lambda)
    {
    	//lamda等于0
    	if(lambda == 0.0)
    	{    		 
    		return lnX(matrix, Math.E) ;
    	}
    	
    	//lamda 不等于0
    	int row = matrix.length;
    	int col = matrix[0].length;
    	double[][] backMatrix = new double[row][col];
    	
    	for(int i = 0; i<row; i++)
    	{
    		backMatrix[i][0] = matrix[i][0];
    		for(int j = 1; j<col; j++)
    		{
    			backMatrix[i][j] =  (Math.pow(matrix[i][j], lambda) -1) / lambda;	
    		}    		
    	}
    	
    	return backMatrix;      	
    }
     
    
    /**
     * 判断两个矩阵是否相等  
     */
    public static boolean isEqualsMatrix(double[][] lMatrix, double[][] rMatrix)
    {   
    	//比较矩阵的大小
    	if((lMatrix.length != rMatrix.length)
    		|| (lMatrix[0].length != rMatrix[0].length))
    	{
    		return false;
    	}
    	
    	//逐个比较矩阵的元素
    	for(int i = 0; i<lMatrix.length; i++)
    	{
    		for(int j = 0; j<lMatrix[0].length; j++)
    		{
    			if( Double.compare(lMatrix[i][j], rMatrix[i][j]) != 0 )
    			{
    				return false;
    			}
    		}    		
    	}
    	  
    	return true;
    } 
    
    /**
     * matrix矩阵中的每个元素的绝对值， 是否都 小于epsilon 值
     */
    public static boolean isAbsLower(double[][] matrix, double epsilon)
    { 
    	 for(int i = 0; i<matrix.length; i++)
    	 {
    		 for(int j = 0; j<matrix[0].length; j++)
    		 {
    			 if( Double.compare(Math.abs(matrix[i][j]), epsilon) > 0)
    			 {
    				 return false;
    			 }    			 
    		 }    		 
    	 }    	
    	
    	return true;
    }
    
       
}
