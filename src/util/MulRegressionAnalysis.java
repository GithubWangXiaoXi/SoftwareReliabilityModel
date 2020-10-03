package util;



import java.util.Arrays;


 
/**
 * ��Ԫ���Իع����
 * 
 * @author Marshal
 **/ 
public class MulRegressionAnalysis
{	  	
    /**
     * ��Ԫ�������Իع麯���ľ�����ʽ��
     * yi = beta*xi + ui
     */
 	private double beta[][];   //�ع�ϵ���������� ����ͨOLS���
 	private double wBeta[][];   //�ع�ϵ���������� ����ȨOLS���
    
 	//ѵ������
 	private	double y[][];     //�����ͱ���
 	private double x[][];     //���ͱ��� 	
 	
 	//Ԥ������
 	private double[][] sampleX;		//�������ͱ���
 	private double[][] sampleY; 	//���������ͱ���
 	
 	private double[][] predictions; //Ԥ����
  
	private double[][] residuals;		//�в����
 	 
	//��Ԫ���Իع�ģ�͵ļ���
 	private double rSquare = Double.MAX_VALUE;  //�ɾ�ϵ��
 	private double rSquareAdjusted = Double.MAX_VALUE ;  //�����ɾ�ϵ��
 	
 	//���ֽ�ʽ
 	private double tss = 0.0;		//�����ƽ����
 	private double rss = 0.0;	//�в�ƽ����
 	private double ess = 0.0;		//�ع�ƽ���� 	  
  
 	private int row = Integer.MAX_VALUE;			//���ͱ������������
 	private int col = Integer.MAX_VALUE;			//���ͱ������������
 	
 	//����
 	private double[] t_statistic;					//t����ֵ
 	private	double f_statistic;  					//f����ֵ 	
 	private double dw;								//DWͳ��
 	 

	//����ͳ����ֵ
 	private double l = Double.MAX_VALUE;				//������Ȼ����ֵ 
 	private double seoRegression = Double.MAX_VALUE;    //�ع��׼��

 	private double aic = Double.MAX_VALUE;				//�����Ϣ��׼��
 	private double sc = Double.MAX_VALUE; 				//Schwarz׼��
 	
 	
 	private double[][] w;								//Ȩ���� 	
 	
 	
 	//�ع鷽�̵ĺ�����ʽö�ٱ���
 	public enum FunctionType
 	{
 		DOUBLE_LOG,				//˫��������ģ��	
 		Half_LOGX, 				//���ͱ��������������ģ��
 		Half_LOGY, 				//�����ͱ��������������ģ��
 		HYPERBOLIC,				//˫������ģ��
 		BOX_COX, 				//BOX_COXת��ģ��
 		DEFAULT; 				//���Իع麯����ʽ(Ĭ��)
 	}
 	
 	private FunctionType functionType = FunctionType.DEFAULT;			//�ع鷽�̵ĺ�����ʽ 		

	/**
 	 * ���캯�������ڷ�������С 
 	 * @param x ���ͱ���
 	 * @param y �����ͱ���
 	 * @param sampleX �����������ͱ���
 	 **/
 	public MulRegressionAnalysis(double[][] x, double[][] y)
 	{ 	 		
 		this.row = x.length;
 		this.col = x[0].length;		
        if(row < col)
        {  	
  	    	throw new IllegalArgumentException("�����������Ӧ��������(δ֪������)���Ա�֤���̿ɽ�...");
        }  
 		
 		beta = new double[col][1]; 		 
 		this.y =  new double[row][1]; 		
 		this.x =  new double[row][col];	 
 		
 		//w = new double[row][row]; 	
 		setX(x);
 		setY(y); 	
 		
 	}
 	
 	/**
 	 * ���Ԥ����
 	 */
 	public double[][] getPredictions() 
 	{
 		int row = predictions.length;
 		double[][] backMatrix = new double[row][1];   
 		
 		for(int i = 0; i<row; i++)
 		{
 			backMatrix[i] = predictions[i].clone();
 		}
		return backMatrix;
	}

 	/**
 	 * ����Ԥ����
 	 * @param predictions
 	 */
	public void setPredictions(double[][] predictions)
	{
		for(int i = 0; i<predictions.length; i++)
		{
			this.predictions[i] = predictions[i].clone();
		}
		
	}

	/**
	 * ��ü�Ȩ�ع�ϵ����������
	 */
	public double[][] getwBeta()
	{
		double[][] backBeta = new double[wBeta.length][wBeta[0].length];
		for(int i = 0; i<wBeta.length; i++)
		{
			backBeta[i] = wBeta[i].clone();
		}
		
		
		return backBeta;
	}

	
	/**
	 * ���ü�Ȩ�ع�ϵ����������
	 */
	public void setwBeta(double[][] wBeta) 
	{
		for(int i = 0; i<wBeta.length; i++)
		{
			this.wBeta[i] = wBeta[i].clone();
		}		 
	}
 	
	
 	/**
 	 * ���DWͳ����
 	 */
 	public double getDw() 
 	{
		return dw;
	}

 	/**
 	 * ����DWͳ����
 	 */
	public void setDw(double dw) 
	{
		this.dw = dw;
	}

 	
 	/**
 	 * ��ûع鷽�̺�����ʽ
 	 */
 	public FunctionType getFunctionType() 
 	{
		return functionType;
	}

 	/**
 	 * ���ػع鷽�̺�����ʽ
 	 */
	public void setFunctionType(FunctionType functionType) 
	{
		this.functionType = functionType;
	}

 	
 	/**
 	 * ���t����ֵ
 	 */
 	public double[] getT_statistic()
 	{
		return t_statistic.clone();
	}

 	/**
 	 * ����t����ֵ
 	 */
	public void setT_statistic(double[] t_statistic) 
	{
		this.t_statistic = t_statistic.clone();
	}

 	/**
 	 * ���f����ֵ
 	 */
	public double getF_statistic() 
	{
		return f_statistic;
	}

 	/**
 	 * ����f����ֵ
 	 */
	public void setF_statistic(double f_statistic)
	{
		this.f_statistic = f_statistic;
	}

	//��ӡ
 	public String toString()
 	{ 	 		
 		return "[R-Squared(�ɾ�ϵ��)��  "+rSquare+"]"+"\r\n[Adjusted R-squared(�����ɾ�ϵ��)��  "+rSquareAdjusted+"]"+ 
 				"\r\n[S.E.of regression(�ع��׼��): "+seoRegression+"]"+
 				"\r\n[Sum Squared resid(�в�ƽ����)��"+rss+"]"+
 				"\r\n[Log likelihood(������Ȼ����ֵ)��  "+l+"]"+
 				"\r\n[Akaike info criterion(������Ϣ׼��  "+aic+"]"+"\r\n[Schwarz criterion(SC׼��)��  "+sc+"]"+"\r\n[t-statistic:  "+
 				Arrays.toString(t_statistic)+"]"+
 				"\r\n[f-statistic:  "+f_statistic+"]" +
 				"\r\n[DW-statistic(DWͳ����): "+dw+"]";
 	}
 	
 	 
 	/**
 	 * ������Է����������
 	 */
	public int getRow()
	{
		return row;
	}

	/**
	 * �������Է����������
	 */
	public void setRow(int row)
	{
		this.row = row;
	}

	/**
	 * ������Է����������
	 */	
	public int getCol() 
	{
		return col;
	}

	/**
	 * �������Է����������
	 */
	public void setCol(int col)
	{
		this.col = col;
	}

	/**
 	 * ��ȡȨ����
 	 */
 	public double[][] getW()
 	{ 
 		double[][] backMatrix = new double[row][row];
 		for(int i = 0; i<row; i++)
 		{
 			backMatrix[i] = w[i].clone();
 		}
 		 
		return backMatrix;
	}

 	/**
 	 * ����Ȩ����
 	 */
	public void setW(double[][] w)
	{
		for(int i = 0; i<row; i++)
		{
			this.w = w.clone();
		}				
	}

	/**
 	 * ���Ԥ������,��������
 	 */
 	public double[][] getSampleX() 
 	{
 		int row = sampleX.length;
 		int col = sampleX[0].length;
 		 
 		double[][] backMatrix = new double[row][col];
 		for(int size = 0; size < row; size++)
 		{
 			backMatrix[size] = sampleX[size].clone();
 		}
 		 
		return backMatrix;
	}
   
 	
 	/**
 	 * ����Ԥ�����������ͱ���
 	 */
	public void setSampleX(double[][] sampleX) 
	{
 		int row = sampleX.length;
 		this.sampleX = new double[row][sampleX[0].length];
 		
 		for(int size = 0; size < row; size++)
 		{
 			this.sampleX[size] = sampleX[size].clone();
 		}		 
	}

	
 	/**
 	 * ���Ԥ�������������ͱ���
 	 */
	public double[][] getSampleY()
	{ 
		int row = sampleY.length;		
		double[][] backMartrix = new double[row][ sampleY[0].length];
		for(int size = 0; size < row; size++)
		{
			backMartrix[size] = sampleY[size].clone();			
		}
		 
		return backMartrix;
	}
	
	/**
 	 * ����Ԥ�������������ͱ���
 	 */
	public void setSampleY(double[][] sampleY) 
	{
		int row = sampleY.length;
		this.sampleY = new double[row][sampleY[0].length];
		
		for(int size = 0; size < row; size++)
		{
			this.sampleY [size] = sampleY[size].clone();			
		}	 
	}
 	 
	
	/**
	 * ��òв�	 
	 */
 	public double[][] getResidual()
 	{
 		double[][] backMartrix = new double[residuals.length][1];
 		for(int i = 0; i < residuals.length; i++)
 		{
 			backMartrix[i] = residuals[i].clone(); 			 
 		}
 		 
		return backMartrix;
	}

 	/**
 	 * ���òв� 	 
 	 */
	public void setResidual(double[][] residual) 
	{
		int len = residual.length;
		this.residuals = new double[len][residual[0].length];
		
		for(int i = 0; i< len; i++)
		{			
			this.residuals[i] = residual[i].clone();
		}		
	}


	/**
 	 * ��������ɾ�ϵ��
 	 */
 	public double getrSquareAdjusted()
 	{
		return rSquareAdjusted;
	}
 	
 	
 	/**
 	 *���������ɾ�ϵ��
 	 */
	public void setrSquareAdjusted(double rSquareAdjusted) 
	{
		this.rSquareAdjusted = rSquareAdjusted;
	}
	

 	/**
 	 *��ÿɾ�ϵ�� 
 	 */
 	public double getrSquare() 
 	{
		return rSquare;
	}

 	
 	/**
 	 *���ÿɾ�ϵ��
 	 */
	public void setrSquare(double rSquare)
	{
		this.rSquare = rSquare;
	}

	
	/**
 	 * ��ûع�ϵ����������
  	 */
	public double[][] getBeta() 
	{
		double[][] backBeta = new double[beta.length][beta[0].length];
		
		for(int i = 0; i < beta.length; i++)
		{
			 backBeta[i] = beta[i].clone();
		}	
		
		return backBeta;
	}
	

 	/**
 	 * ���ûع�ϵ����������
 	 */
	public void setBeta(double[][] beta) 
	{
		for(int i = 0; i < beta.length; i++)
		{
			this.beta[i] = beta[i].clone();
		}		
	}	
	
	
	/**
	 *��ñ����ͱ��� 
	 */
	public double[][] getY() 
	{	
		int row = y.length;
		double[][] backYi = new double[row][1]; 
		
		for(int i =0; i< row; i++)
		{
			backYi[i] = y[i].clone();	
		}
		
		return backYi;
	}	

	
	/**
	 * ���ñ����ͱ��� 
	 */
	public void setY(double[][] y)
	{
		int row = y.length;			
		for(int i = 0; i < row; i++)
		{
			this.y[i] = y[i].clone();	
		}		 
	}

	
	/**
	 * ��ý��ͱ��� 
	 */
	public double[][] getX()
	{
		int row = x.length;
		int col = x[0].length;
		double[][] backX = new double[row][col];
		for(int i = 0; i < row; i++)
		{
			backX[i] = x[i].clone();
		}
				
		return backX;
	}

	
	/**
	 * ���ý��ͱ���
	 */
	public void setX(double[][] x)
	{
		int row = x.length;	 
	 
		for(int i = 0; i < row; i++)
		{
			this.x[i] = x[i].clone();
		}		 
	}
	
    
	/**
	 * ����ع�ϵ���������� Beta
	 */
	public void calculateBeta()
	{
	 	//���ת�þ���		
		double[][] xTransposition = MatrixOperator.transposeMatrix(this.x);
  
		//���ת�þ����ԭʼ����˻� 
		double[][] xMultiply = MatrixOperator.multiplyMatrix(xTransposition, this.x); 
	  
		//��������		
		double[][] reduseMarix = MatrixOperator.reverseMatrix(xMultiply); 
		 
		double[][] xMultiply2 = MatrixOperator.multiplyMatrix(reduseMarix, xTransposition);
		double[][] beta = MatrixOperator.multiplyMatrix(xMultiply2, this.y);
		  
		//�õ���beta����Ϊ������	 
		for(int len = 0; len < beta.length; len++)
		{
			this.beta[len] = beta[len].clone();
		}
		 
		return;
	} 	 
	
	
	/**
	 * ����calculateBeta()  
	 */
	public double[][] calculateBeta(double[][] x, double[][] y)
	{		
		//���ת�þ���		
		double[][] xTransposition = MatrixOperator.transposeMatrix(x);
  
		//���ת�þ����ԭʼ����˻� 
		double[][] xMultiply = MatrixOperator.multiplyMatrix(xTransposition, x);
		
		//�������������������У�������±��1��ʼ, ����֮ǰ��Ҫ�Ծ�������		
		int row = xMultiply.length;
		int col = xMultiply[0].length;
		double[][] extendsMarix = new double[row+1][col+1];
		
		for(int i = 1; i < row + 1; i++)
		{
			for(int j = 1; j < col + 1; j++)
			{
				extendsMarix[i][j] = xMultiply[i-1][j-1];
			}			
		}
	  
		//��������
		double[][] xReverse = MatrixOperator.reverseMatrix(extendsMarix);
 
		//����õ����������±껹ԭ����������С�±�ֵ��0��ʼ
		double[][] reduseMarix = new double[row][col];
		for(int i = 0; i < row; i++)
		{
			for(int j = 0; j < col; j++)
			{
				reduseMarix[i][j] = xReverse[i+1][j+1];
			}			
		}
		 
		double[][] xMultiply2 = MatrixOperator.multiplyMatrix(reduseMarix, xTransposition);
		double[][] beta = MatrixOperator.multiplyMatrix(xMultiply2, y);
		 
		//�õ����ƵĲ���	
		double[][]  backMatrix = new double[beta.length][beta[0].length];
		for(int len = 0; len < beta.length; len++)
		{
			backMatrix[len] = beta[len].clone();
		}
		 
		return backMatrix;		 
	}
	
	
	/**
	 * ʹ�ü�Ȩ��С���˷�������ع�ϵ���������� Beta��
	 * ע���������췽��ʱ�����ô˺�����
	 */
	public void calculateWBeta()
	{
		//�����Ƿ�����췽������
		 if(!isHeteroscedasticity())
		 	return;		
		
		//��ü�Ȩ����
		//calculateW();
		 
		//��ý��ͱ�������x��ת�þ���		
		double[][] xTransposition = MatrixOperator.transposeMatrix(x);
		
		//���Ȩ����w�������(w����Ϊ�Խ���)			 
		int len = w.length;
		double[][] reverseWMatrix = new double[len][len];
		for(int i = 0; i<len; i++)
		{
			reverseWMatrix[i][i] = 1.0 / this.w[i][i];
		}		
		
		//���xת�þ����w������ԭʼ����˻�����
		double[][] multiply1 = MatrixOperator.multiplyMatrix(xTransposition, reverseWMatrix);
		double[][] multiply2 = MatrixOperator.multiplyMatrix(multiply1,x);	  
		double[][] reduseMultiply2 = MatrixOperator.reverseMatrix(multiply2);
		 
		double[][] m1 = MatrixOperator.multiplyMatrix(reduseMultiply2, xTransposition);
		double[][] m2 = MatrixOperator.multiplyMatrix(m1,reverseWMatrix);
		
		double[][] beta = MatrixOperator.multiplyMatrix(m2, this.y);
		 
		//�õ���wBeta����Ϊ������	 
		this.wBeta = new double[beta.length][1];
		for(int i = 0; i < beta.length; i++)
		{
			this.wBeta[i] = beta[i].clone();
		} 
		
		return;
	}	
 
	
	/**
	 * ����Ȩ����
	 * �ڴ�֮ǰ�Ѿ����ù� calculateBeta() ��calculateResiduals()����
	 */
	public void calculateW()
	{
    	//���Ȩ����
		int len  = this.x.length;
    	w = new double[len][len];
    	for(int i = 0; i<len; i++)
    	{	
    		this.w[i][i] =  residuals[i][0] * residuals[i][0];  		
    	}	     	 
	}	 
	
	/**
	 * ����в�
	 * �˺�������ǰ�������calculateBeta()
	 */
	public void calculateStatistic()
	{
		//����ع�ϵ����������beta
		//calculateBeta();	
		
		//����в�  
		calculateResiduals(true);
		 
		//������Ȼ����ֵ
		double[][] transpose = MatrixOperator.transposeMatrix(residuals);
		 
		double[][] result = MatrixOperator.multiplyMatrix(transpose, residuals);		
		
		this.l = -(row/2.0)*(1.0+Math.log(2*Math.PI) + Math.log(result[0][0]/ row));
		 		
		
		//�ع��׼��
		this.seoRegression = Math.sqrt(result[0][0]/ (row - col));
		
		//�в�ƽ����
		//this.rss = result[0][0];
		
		//�����Ϣ��׼��
		this.aic = -2*l/row + 2.0*(col) / row;//2*col - 2*Math.log(this.l);
		
		//Schwarz
		this.sc = -2*l/row + (col*Math.log(row)) / row;		
		  
		return;
	}
	  
 
	/**
	 * ������ֽ�ʽ
	 * ע���˺�������ǰ�������calculateBeta();
	 */
	public void calculateDecomposeFormular()
	{
		/*
		 * 
			//���ݲ��������н��ͱ��������㱻���ͱ���
			double[][] y = MatrixOperator.multiplyMatrix(sampleX, beta);		
	 	 
			int len = sampleY.length;
	 
			//���㱻���ͱ����ľ�ֵ
			double yMean = 0.0;
			
			for(int i = 0; i < len; i++)
			{
			  yMean += sampleY[i][0];			
			}
			yMean /= len;
			
			//����TSS, RSS, ESSֵ
			for(int i = 0; i < len; i++)
			{
			  tss += Math.pow(sampleY[i][0]-yMean, 2.0);		
			  rss += Math.pow(sampleY[i][0]-y[i][0], 2.0);
			  ess += Math.pow(y[i][0]-yMean, 2.0);		  
			}			
		  **/ 
		
		//���ݻع�ϵ���� ����Ԥ��
		double[][] y = MatrixOperator.multiplyMatrix(this.x, beta);		
 	  
		//���㱻���ͱ����ľ�ֵ
		double yMean = 0.0;
		
		for(int i = 0; i < row; i++)
		{
		  yMean += this.y[i][0];			
		}
		yMean /= row;
		
		//����TSS, RSS, ESSֵ
		for(int i = 0; i < row; i++)
		{
		  tss += Math.pow(this.y[i][0]-yMean, 2.0);		
		  rss += Math.pow(this.y[i][0]-y[i][0], 2.0);
		  ess += Math.pow(y[i][0]-yMean, 2.0);		  
		}	
		
		return;
	}
  
	/**
	 * ����ɾ�ϵ��������Ŷȼ���
	 */
    public void calculateRSquare()
    {   
    	 
    	//������ֽ�ʽ
    	calculateDecomposeFormular();
    	//ess / tss;  
    	rSquare = 1 - rss / tss;
    	return;    
    }

    /**
     * ���������ɾ�ϵ��
     */
    public void calculateRSquareAdjusted()
    { 
    	//��ÿɾ�ϵ��
    	calculateRSquare();
    	
    	double rSA = 1.0 -  (1-rSquare)*(row-1)/(row - col) ;
    	//syso
    	
    	rSquareAdjusted = rSA < 0 ? 0 : rSA;
    	
    	return;
    }
     
    /**
     * �����Լ��飬F-���� 
     * @return true: ˵���ع鷽��������������ģ�͵ĸ������ͱ������������Ա����ͱ���������Ӱ��.
     *        false: ˵���ع鷽�̲�������������ģ�͵ĸ������ͱ������������Ա����ͱ���Ӱ�첻����.
     */
    public void isSatisfyFtest()
    {    
    	int degree1 =  col -1 ;
    	int degree2 =  row - col;
    	f_statistic = (ess / degree1) / (rss / degree2);    	  
  
    	return  ;
    }
    
    /**
     * �����Լ��飬t-���� 
     * 
     * @return boolean[]
     * 		   true: ���ͱ����Ա����ͱ�����Ӱ����������
     * 		  false: ���ͱ����౻���ͱ�����Ӱ�첻�������� 	
     */
    public void isSatisfyTtest()
    {     
    	//��� Ciiֵ
    	double[][] transposeX = MatrixOperator.transposeMatrix(this.x);
    	double[][] multiMatrix = MatrixOperator.multiplyMatrix(transposeX, this.x);
    	double[][] reserveMatrix = MatrixOperator.reverseMatrix(multiMatrix); 
    	 
    	//������������ķ��� 
    	double[][] transposeResiduals = MatrixOperator.transposeMatrix(residuals);
    	 
    	double[][] mulResidual = MatrixOperator.multiplyMatrix(transposeResiduals, residuals);
    	double var = mulResidual[0][0] / (row - col);
    	
    	t_statistic = new double[col];
    	for(int i = 0; i < col; i++)
    	{
    		double t = beta[i][0] / (Math.sqrt(var * reserveMatrix[i][i]));      		
    		t_statistic[i] = t;    	   		
    	}    	     	 
    }     
    
    
    /**
     * ����в�
     * @param isTrainSample [true:��ѵ������������в�]��[false�� �Բ���������в�]
     * 
     * ��isTrainSampleΪfalse�� �ڴ˺�������֮ǰ,�����
     * @2 setSampleX(); setSampleY();
     */	     	
	public void calculateResiduals(boolean isTrainSample)
	{
		//Ԥ��ֵ����ʵֵ
		double[][] yPredication;	  
		
		//��ѵ��������в�
		if(isTrainSample)
		{
			setSampleX(this.x);
			setSampleY(this.y);
		} 
		yPredication= MatrixOperator.multiplyMatrix(sampleX, beta);			
	
		//����в� 		 
		int len = sampleY.length;
		this.residuals = new double[len][sampleY[0].length];
		
		for(int i = 0; i < len; i++)
		{
			this.residuals[i][0] = sampleY[i][0] - yPredication[i][0];	
		}	
	}	
	
	
    /**
     * �����Լ��飬D-W ���� 
     * 
     * @return true: ���ͱ����Ա����ͱ�����Ӱ����������
     * 		  false: ���ͱ����Ա����ͱ�����Ӱ�첻�������� 	
     */
    public void isSatisfyD_Wtest()
    {  
    	double et1 = 0.0;
    	double et2 = 0.0;
    	int len = residuals.length;    	
    	
    	for(int i = 0; i < len; i++)
    	{
    		et2 += Math.pow(residuals[i][0], 2.0);
    		if(i > 0)
    		{
    			et1 += Math.pow(residuals[i][0] - residuals[i-1][0], 2.0);
    		}    		
    	}
    	
    	//����DW����  
    	 dw = (et1/et2);     	 
    }       
    
    /**
     * �췽�����Լ���
     * 
     * @return true: �����췽������
     * 		  false: �������췽������
     */
    public boolean isHeteroscedasticity()
    {    	
    	//���Ȩ����
    	calculateW(); 
    	double sum = 0.0;
    	for(int i = 0; i < row; i++)
    	{
    		sum += this.residuals[i][0]; 	    		
    	}    	
    	
    	double mean = sum / row;
    	double sigma = 0.0;
    	for(int i = 0; i < row; i++)
    	{
    		sigma += Math.pow(mean - this.residuals[i][0], 2.0);  	    		
    	}
    	
    	//������������
    	sigma /= (row -1);    	
    	 	 
    	double[][] matrixW = new double[row][row];
    	for(int i = 0; i < row; i++)
    	{
    		matrixW[i][i] = sigma * w[i][i];    		
    	}
    	
    	// ����в���������
    //	double[][] meanMatrix = new double[row][row];        	 
    	//todo... ������������     	  �� [uu'] ����������
    	/**
    	 * 
    	 * 
    	 *    ???????????????
    	 * 
    	 * 
    	 * 
    	 */
    	 
    	//�����췽�����������
    	/*return (  MatrixOperator.isEqualsMatrix(meanMatrix, matrixW)  &&     			
    			 (Double.compare(mean, 0.000001)<0  && 
    			  Double.compare(mean, -0.000001)>0) 
    			); */   	 
    	
    	return true;
    }
         
    
     /**
      * ���ݻع鷽�̵ĺ�����ʽ���Խ��ͱ����ͱ����ͱ�������ת��      
      * @param lamda ���ع鷽�̵ĺ�����ʽΪ   Box-Coxת��,�˲�����������
      * ע���˺�������֮ǰ�����setFunctionType()�Իع鷽�̺�����ʽ�������ã�Ĭ��Ϊ���Իع鷽�̡�      
      */
     public void determinedDatas(FunctionType functionType, double baseNumber ,double lambda)
     {     	 
    	 switch (functionType) 
    	 {
    	 	case DEFAULT:
    	 		break;  
    	 	
    	 	case DOUBLE_LOG:
    	 		this.x = MatrixOperator.lnX(this.x, baseNumber);
    	 		this.y = MatrixOperator.lnY(this.y, baseNumber); 
    	   
    	 		break;
    	 	    	 		
    	 	case Half_LOGX:
    	 		this.x = MatrixOperator.lnX(this.x, baseNumber);
    	 		break;
    	 		
    	 	case Half_LOGY:  
    	 		this.y = MatrixOperator.lnY(this.y, baseNumber); 
    	 		break;    	 		
    	 		
    	 	case HYPERBOLIC:
    	 		this.x = MatrixOperator.reciprocal(this.x);
    	 		break;
    	 		
    	 	case BOX_COX:
    	 		this.x = MatrixOperator.boxCox(this.x, lambda); 
    	 		break;
    	 	 
    	 	default:	    	 		
    	 		break; 
    	 }  
    	 return;
     }  
     
     /**
      * Ԥ��
      * @param x Ԥ���������ͱ���
      * @param beta �ع鷽��ϵ��
      */
     public double[][] predict(double[][] x, double[][] beta)
     {
    	 return MatrixOperator.multiplyMatrix(x, beta);    	 
     }
    		 
   /**
    * �㷨����
    * @param functionType  ����������ʽ
    * @param baseNumber  ����
    * @param lambda  ����
    * @param isWeighted  �Ƿ�ʹ�ü�Ȩ��С���˷�  
    */
     public void runMulRegressionAnalysis(FunctionType functionType, double baseNumber, double lambda, boolean isWeighted)
     {
    	//@1 ȷ���ع鷽�̺����ع���ʽ
    	determinedDatas(functionType, baseNumber, lambda);
    	 
    	//@2 ������С���˷�ȷ���ع����
    	calculateBeta();
    	calculateResiduals(true);
    	
    	//�Ƿ�ʹ�ü�Ȩ��С���˷�
    	if(isWeighted)
    	{
    		calculateWBeta();
    		setBeta(wBeta);
    	}
    	 
    	 
 		 System.out.println("��ӡbeta ֵ :");
    	 
 		MatrixOperator.show(getBeta());	
 		
    	//�������ָ��� ����
 		calculateStatistic();
		calculateRSquareAdjusted();
		 
		isSatisfyFtest();
		  
		isSatisfyTtest();			 
	  
		isSatisfyD_Wtest();		
		 
		//System.out.println("��ӡ���ͳ����\r\n"+toString());
		
		//@3 Ԥ��		    	 
    	 this.predictions = predict(sampleX, beta);
    	  
    	 return;
     }
     
     
     
     
     
}
