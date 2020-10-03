package util;

import java.util.Arrays;

/**
 * ��װ���ھ�������ķ�����������ʾ������������   
 *
 * @author Marshal
 */
public class MatrixOperator   
{   
	/**
	 * Ĭ�Ϲ��캯��
	 */
    private MatrixOperator()
    {
    	
    }   
    
    
    /**
     * ������Ϊn��һά������ת��Ϊ��n��1�Ķ�ά����
     * �������ļ���
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
     * ��n��1�Ķ�ά����(������)��ת��Ϊ����Ϊn��һά������
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
     * ��ȡ�����--��
     * ע���ڴ������� �����Ԫ�ش�1��ʼ�� ����СԪ��С��Ϊa[1][1].
     * �˺���ֻ�ڱ����е�reverseMatrix(double[][]) �������ã� �ʽ�������Ϊ ˽�г�Ա
     */
    private static double[][] reverse(double[][] matrix)   
    {   
        double[][] temp;   
        double[][] back_temp = new double[matrix.length][matrix.length];   
        //�õ�����Ľ���   
        int m_length = matrix.length;   
        //����n*��2n-1������ʽ�������������ԭ����͵�λ����   
        temp = new double[m_length][2*m_length-1];   
        
        //�������صľ���,��ʼ�� .��ԭʼ���󿽱�          
        for(int i=0; i<matrix.length; i++)
        {
        	back_temp[i] = matrix[i].clone();        	
        }
        
        //back_temp = matrix;   
        //��ԭ�����ֵ���� temp���󣬲���ӵ�λ�����ֵ   
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
        //System.out.println("��Ͼ���:");   
        //showMatrix(temp);   
        //��˹��Ԫ�������   
        for(int x=1;x<m_length;x++)   
        {   
            double var=temp[x][x];   
            //�ж϶Խ�����Ԫ���Ƿ�Ϊ0���ǵĻ��������н��н����У���û������������   
            //�����Ϊԭ����û�������Ȼ��ȡֵҪ��Ϊ0���е�ֵ   
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
                    //��������޷���temp�������߻�Ϊ��λ���󣬷���ԭ����   
                    if(k>=temp.length) 
                    	return back_temp;   
                    var=temp[x][x];   
                   // System.out.print("�� " + x + "�α任ǰ�滻��Ԫ�ϵ� 0");   
                   //System.out.println("(��  " + x + " ����� " + k +" �н��н���)��");   
                   // showMatrix(temp);   
                }   
                temp[x][w] /=var;   
            }   
            //����x�е�Ԫ�س��Խ����ϵ�Ԫ���ⶼ��Ϊ0����������λ����   
            for(int z=1;z<m_length;z++)   
            {   double var_tmp=0.0;   
                for(int w=x;w<temp[0].length;w++)   
                {   //System.out.println("-"+x+"-"+z+"-"+w+"+++" + temp[z][w]);    
                    if(w==x) var_tmp=temp[z][x];   
                    if(x!=z) temp[z][w] -=(var_tmp*temp[x][w]);   
                           
                }   
            }   
           // System.out.println("�� " + x + "�α任:");   
           // showMatrix(temp);   
        }   
        //ȡ������ֵ   
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
     * ���������
     * @param matrix �������
     * @return �����
     */
    public static double[][] reverseMatrix(double[][] matrix) 
    {
    	//��multiply2��չ
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
		 
		//��extendsMultiply2����
		double[][] multiply2Reverse = MatrixOperator.reverse(extendsMultiply2);
		 
		//����õ����������±껹ԭ����������С�±�ֵ��0��ʼ
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
     * ����ת�þ���
     * @param matrix ��ת�þ���
     * @return ת�þ���
     */
    public static double[][] transposeMatrix(double[][] matrix)
    {
    	int row = matrix.length;  
    	int col = matrix[0].length;
    	double[][] backMatrix = new double[col][row];
    	
    	//ת��
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
     * ����������
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
    		throw new IllegalArgumentException("�������������Ҿ������������ȣ��������ʧ�ܣ�");    		
    	}
    	
        //�˻�����
    	double[][] backMatrix = new double[lRow][rCol];
    	for(int i = 0; i < lRow; i++)
    	{
    		for(int j = 0; j < rCol; j++)
    		{    			
    			//��˵õ��ľ��� a[i][j]; Ϊ�����ĵ�i�� ���� �Ҿ���ĵ� j��
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
     * ��ʾ����ӡ������
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
     * ���Է�������� Ax=b
     * @param a ������ϵ������
     * @param n δ֪������
     * @param b ֵ����
     * @return ������
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
            	throw new IllegalArgumentException("���Է�����ϵ��Ϊ �������");
				 
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
	 * ������� 
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
    	    	
    	//����ӵ���������ĺϷ��Լ���
    	if((lRow != rRow) || (lCol != rCol))
			throw new IllegalArgumentException("����Ӿ����л����������!");      
       	
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
	 * ���������������ȥ�Ҿ���
	 * 
	 * @param lMatrix
	 * @param rMatrix
	 */
    public static double[][] minus(double[][] lMatrix, double[][] rMatrix)
    {
    	//���Ҿ���*-1�� ���������
    	double[][] contraryMatrix = multiply(rMatrix, -1.0);    	
    	
    	return add(lMatrix, contraryMatrix);
    }
    
         
    /**
	 * ���󴦳�����matrix�����е�ÿ��Ԫ�س��� ���� i
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
   	 * ����˷���matrix�����е�ÿ��Ԫ�س��� ���� i
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
     * �Խ��ͱ��� �����е�Ԫ������� 
     * �����������ݾ���ĺ��壬 ֻ������  �в�Ϊ0��Ԫ�ؽ��д���
     */
    public static double[][] lnX(double[][] matrix, double baseNumber)
    {
   	 	if(Double.compare(baseNumber, 0)<=0
    		 || Double.compare(baseNumber, 1.0) == 0)
    	 {
    		 throw new IllegalArgumentException("�����ĵ�������  С�ڣ�����0; ���ߵ��� 1 ");
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
     * �Ա����ͱ���������Ԫ�� �����
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
     * �������е�Ԫ������
     * �����������ݾ���ĺ��壬 ֻ������  �в�Ϊ0��Ԫ�ؽ��д���!
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
     * BOX-COXת��
     * @param lamda ����ת������ʽ
     * �����������ݾ���ĺ��壬 ֻ������  �в�Ϊ0��Ԫ�ؽ��д���
     */
    public static double[][] boxCox(double[][] matrix, double lambda)
    {
    	//lamda����0
    	if(lambda == 0.0)
    	{    		 
    		return lnX(matrix, Math.E) ;
    	}
    	
    	//lamda ������0
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
     * �ж����������Ƿ����  
     */
    public static boolean isEqualsMatrix(double[][] lMatrix, double[][] rMatrix)
    {   
    	//�ȽϾ���Ĵ�С
    	if((lMatrix.length != rMatrix.length)
    		|| (lMatrix[0].length != rMatrix[0].length))
    	{
    		return false;
    	}
    	
    	//����ȽϾ����Ԫ��
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
     * matrix�����е�ÿ��Ԫ�صľ���ֵ�� �Ƿ� С��epsilon ֵ
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
