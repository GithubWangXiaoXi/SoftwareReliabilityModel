package util;



import java.util.Arrays;


 
/**
 * 多元线性回归分析
 * 
 * @author Marshal
 **/ 
public class MulRegressionAnalysis
{	  	
    /**
     * 多元总体线性回归函数的矩阵形式：
     * yi = beta*xi + ui
     */
 	private double beta[][];   //回归系数估计向量 ，普通OLS求得
 	private double wBeta[][];   //回归系数估计向量 ，加权OLS求得
    
 	//训练样本
 	private	double y[][];     //被解释变量
 	private double x[][];     //解释变量 	
 	
 	//预测样本
 	private double[][] sampleX;		//样本解释变量
 	private double[][] sampleY; 	//样本被解释变量
 	
 	private double[][] predictions; //预测结果
  
	private double[][] residuals;		//残差计算
 	 
	//多元线性回归模型的检验
 	private double rSquare = Double.MAX_VALUE;  //可决系数
 	private double rSquareAdjusted = Double.MAX_VALUE ;  //修正可决系数
 	
 	//变差分解式
 	private double tss = 0.0;		//总离差平方和
 	private double rss = 0.0;	//残差平方和
 	private double ess = 0.0;		//回归平方和 	  
  
 	private int row = Integer.MAX_VALUE;			//解释变量矩阵的行数
 	private int col = Integer.MAX_VALUE;			//解释变量矩阵的列数
 	
 	//检验
 	private double[] t_statistic;					//t检验值
 	private	double f_statistic;  					//f检验值 	
 	private double dw;								//DW统计
 	 

	//常见统计量值
 	private double l = Double.MAX_VALUE;				//对数似然函数值 
 	private double seoRegression = Double.MAX_VALUE;    //回归标准差

 	private double aic = Double.MAX_VALUE;				//赤池信息量准则
 	private double sc = Double.MAX_VALUE; 				//Schwarz准则
 	
 	
 	private double[][] w;								//权矩阵 	
 	
 	
 	//回归方程的函数形式枚举变量
 	public enum FunctionType
 	{
 		DOUBLE_LOG,				//双对数线性模型	
 		Half_LOGX, 				//解释变量，半对数线性模型
 		Half_LOGY, 				//被解释变量，半对数线性模型
 		HYPERBOLIC,				//双曲函数模型
 		BOX_COX, 				//BOX_COX转换模型
 		DEFAULT; 				//线性回归函数形式(默认)
 	}
 	
 	private FunctionType functionType = FunctionType.DEFAULT;			//回归方程的函数形式 		

	/**
 	 * 构造函数，用于分配矩阵大小 
 	 * @param x 解释变量
 	 * @param y 被解释变量
 	 * @param sampleX 测试样本解释变量
 	 **/
 	public MulRegressionAnalysis(double[][] x, double[][] y)
 	{ 	 		
 		this.row = x.length;
 		this.col = x[0].length;		
        if(row < col)
        {  	
  	    	throw new IllegalArgumentException("方程组的行数应大于列数(未知数个数)，以保证方程可解...");
        }  
 		
 		beta = new double[col][1]; 		 
 		this.y =  new double[row][1]; 		
 		this.x =  new double[row][col];	 
 		
 		//w = new double[row][row]; 	
 		setX(x);
 		setY(y); 	
 		
 	}
 	
 	/**
 	 * 获得预测结果
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
 	 * 设置预测结果
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
	 * 获得加权回归系数估计向量
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
	 * 设置加权回归系数估计向量
	 */
	public void setwBeta(double[][] wBeta) 
	{
		for(int i = 0; i<wBeta.length; i++)
		{
			this.wBeta[i] = wBeta[i].clone();
		}		 
	}
 	
	
 	/**
 	 * 获得DW统计量
 	 */
 	public double getDw() 
 	{
		return dw;
	}

 	/**
 	 * 设置DW统计量
 	 */
	public void setDw(double dw) 
	{
		this.dw = dw;
	}

 	
 	/**
 	 * 获得回归方程函数形式
 	 */
 	public FunctionType getFunctionType() 
 	{
		return functionType;
	}

 	/**
 	 * 返回回归方程函数形式
 	 */
	public void setFunctionType(FunctionType functionType) 
	{
		this.functionType = functionType;
	}

 	
 	/**
 	 * 获得t检验值
 	 */
 	public double[] getT_statistic()
 	{
		return t_statistic.clone();
	}

 	/**
 	 * 设置t检验值
 	 */
	public void setT_statistic(double[] t_statistic) 
	{
		this.t_statistic = t_statistic.clone();
	}

 	/**
 	 * 获得f检验值
 	 */
	public double getF_statistic() 
	{
		return f_statistic;
	}

 	/**
 	 * 设置f检验值
 	 */
	public void setF_statistic(double f_statistic)
	{
		this.f_statistic = f_statistic;
	}

	//打印
 	public String toString()
 	{ 	 		
 		return "[R-Squared(可决系数)：  "+rSquare+"]"+"\r\n[Adjusted R-squared(修正可决系数)：  "+rSquareAdjusted+"]"+ 
 				"\r\n[S.E.of regression(回归标准差): "+seoRegression+"]"+
 				"\r\n[Sum Squared resid(残差平方和)："+rss+"]"+
 				"\r\n[Log likelihood(对数似然函数值)：  "+l+"]"+
 				"\r\n[Akaike info criterion(赤量信息准则：  "+aic+"]"+"\r\n[Schwarz criterion(SC准则)：  "+sc+"]"+"\r\n[t-statistic:  "+
 				Arrays.toString(t_statistic)+"]"+
 				"\r\n[f-statistic:  "+f_statistic+"]" +
 				"\r\n[DW-statistic(DW统计量): "+dw+"]";
 	}
 	
 	 
 	/**
 	 * 获得线性方程组的行数
 	 */
	public int getRow()
	{
		return row;
	}

	/**
	 * 设置线性方程组的行数
	 */
	public void setRow(int row)
	{
		this.row = row;
	}

	/**
	 * 获得线性方程组的列数
	 */	
	public int getCol() 
	{
		return col;
	}

	/**
	 * 设置线性方程组的列数
	 */
	public void setCol(int col)
	{
		this.col = col;
	}

	/**
 	 * 获取权矩阵
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
 	 * 设置权矩阵
 	 */
	public void setW(double[][] w)
	{
		for(int i = 0; i<row; i++)
		{
			this.w = w.clone();
		}				
	}

	/**
 	 * 获得预测样本,解释向量
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
 	 * 设置预测样本，解释变量
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
 	 * 获得预测样本，被解释变量
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
 	 * 设置预测样本，被解释变量
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
	 * 获得残差	 
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
 	 * 设置残差 	 
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
 	 * 获得修正可决系数
 	 */
 	public double getrSquareAdjusted()
 	{
		return rSquareAdjusted;
	}
 	
 	
 	/**
 	 *设置修正可决系数
 	 */
	public void setrSquareAdjusted(double rSquareAdjusted) 
	{
		this.rSquareAdjusted = rSquareAdjusted;
	}
	

 	/**
 	 *获得可决系数 
 	 */
 	public double getrSquare() 
 	{
		return rSquare;
	}

 	
 	/**
 	 *设置可决系数
 	 */
	public void setrSquare(double rSquare)
	{
		this.rSquare = rSquare;
	}

	
	/**
 	 * 获得回归系数估计向量
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
 	 * 设置回归系数估计向量
 	 */
	public void setBeta(double[][] beta) 
	{
		for(int i = 0; i < beta.length; i++)
		{
			this.beta[i] = beta[i].clone();
		}		
	}	
	
	
	/**
	 *获得被解释变量 
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
	 * 设置被解释变量 
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
	 * 获得解释变量 
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
	 * 设置解释变量
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
	 * 计算回归系数估计向量 Beta
	 */
	public void calculateBeta()
	{
	 	//获得转置矩阵		
		double[][] xTransposition = MatrixOperator.transposeMatrix(this.x);
  
		//获得转置矩阵和原始矩阵乘积 
		double[][] xMultiply = MatrixOperator.multiplyMatrix(xTransposition, this.x); 
	  
		//求解逆矩阵		
		double[][] reduseMarix = MatrixOperator.reverseMatrix(xMultiply); 
		 
		double[][] xMultiply2 = MatrixOperator.multiplyMatrix(reduseMarix, xTransposition);
		double[][] beta = MatrixOperator.multiplyMatrix(xMultiply2, this.y);
		  
		//得到的beta矩阵为列向量	 
		for(int len = 0; len < beta.length; len++)
		{
			this.beta[len] = beta[len].clone();
		}
		 
		return;
	} 	 
	
	
	/**
	 * 重载calculateBeta()  
	 */
	public double[][] calculateBeta(double[][] x, double[][] y)
	{		
		//获得转置矩阵		
		double[][] xTransposition = MatrixOperator.transposeMatrix(x);
  
		//获得转置矩阵和原始矩阵乘积 
		double[][] xMultiply = MatrixOperator.multiplyMatrix(xTransposition, x);
		
		//由于在求矩阵逆的运算中，数组的下标从1开始, 求逆之前需要对矩阵扩容		
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
	  
		//求解逆矩阵
		double[][] xReverse = MatrixOperator.reverseMatrix(extendsMarix);
 
		//对求得的逆矩阵进行下标还原，即数组最小下标值从0开始
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
		 
		//得到估计的参数	
		double[][]  backMatrix = new double[beta.length][beta[0].length];
		for(int len = 0; len < beta.length; len++)
		{
			backMatrix[len] = beta[len].clone();
		}
		 
		return backMatrix;		 
	}
	
	
	/**
	 * 使用加权最小二乘法，计算回归系数估计向量 Beta。
	 * 注：当存在异方差时，调用此函数。
	 */
	public void calculateWBeta()
	{
		//检验是否具有异方差异性
		 if(!isHeteroscedasticity())
		 	return;		
		
		//获得加权矩阵
		//calculateW();
		 
		//获得解释变量矩阵x的转置矩阵		
		double[][] xTransposition = MatrixOperator.transposeMatrix(x);
		
		//获得权矩阵w的逆矩阵(w矩阵为对角阵)			 
		int len = w.length;
		double[][] reverseWMatrix = new double[len][len];
		for(int i = 0; i<len; i++)
		{
			reverseWMatrix[i][i] = 1.0 / this.w[i][i];
		}		
		
		//获得x转置矩阵和w逆矩阵和原始矩阵乘积矩阵
		double[][] multiply1 = MatrixOperator.multiplyMatrix(xTransposition, reverseWMatrix);
		double[][] multiply2 = MatrixOperator.multiplyMatrix(multiply1,x);	  
		double[][] reduseMultiply2 = MatrixOperator.reverseMatrix(multiply2);
		 
		double[][] m1 = MatrixOperator.multiplyMatrix(reduseMultiply2, xTransposition);
		double[][] m2 = MatrixOperator.multiplyMatrix(m1,reverseWMatrix);
		
		double[][] beta = MatrixOperator.multiplyMatrix(m2, this.y);
		 
		//得到的wBeta矩阵为列向量	 
		this.wBeta = new double[beta.length][1];
		for(int i = 0; i < beta.length; i++)
		{
			this.wBeta[i] = beta[i].clone();
		} 
		
		return;
	}	
 
	
	/**
	 * 计算权矩阵
	 * 在此之前已经调用过 calculateBeta() 和calculateResiduals()函数
	 */
	public void calculateW()
	{
    	//求得权矩阵
		int len  = this.x.length;
    	w = new double[len][len];
    	for(int i = 0; i<len; i++)
    	{	
    		this.w[i][i] =  residuals[i][0] * residuals[i][0];  		
    	}	     	 
	}	 
	
	/**
	 * 计算残差
	 * 此函数调用前，需调用calculateBeta()
	 */
	public void calculateStatistic()
	{
		//计算回归系数估计向量beta
		//calculateBeta();	
		
		//计算残差  
		calculateResiduals(true);
		 
		//对数似然函数值
		double[][] transpose = MatrixOperator.transposeMatrix(residuals);
		 
		double[][] result = MatrixOperator.multiplyMatrix(transpose, residuals);		
		
		this.l = -(row/2.0)*(1.0+Math.log(2*Math.PI) + Math.log(result[0][0]/ row));
		 		
		
		//回归标准差
		this.seoRegression = Math.sqrt(result[0][0]/ (row - col));
		
		//残差平方和
		//this.rss = result[0][0];
		
		//赤池信息量准则
		this.aic = -2*l/row + 2.0*(col) / row;//2*col - 2*Math.log(this.l);
		
		//Schwarz
		this.sc = -2*l/row + (col*Math.log(row)) / row;		
		  
		return;
	}
	  
 
	/**
	 * 计算变差分解式
	 * 注：此函数调用前，需调用calculateBeta();
	 */
	public void calculateDecomposeFormular()
	{
		/*
		 * 
			//根据测试样本中解释变量，计算被解释变量
			double[][] y = MatrixOperator.multiplyMatrix(sampleX, beta);		
	 	 
			int len = sampleY.length;
	 
			//计算被解释变量的均值
			double yMean = 0.0;
			
			for(int i = 0; i < len; i++)
			{
			  yMean += sampleY[i][0];			
			}
			yMean /= len;
			
			//计算TSS, RSS, ESS值
			for(int i = 0; i < len; i++)
			{
			  tss += Math.pow(sampleY[i][0]-yMean, 2.0);		
			  rss += Math.pow(sampleY[i][0]-y[i][0], 2.0);
			  ess += Math.pow(y[i][0]-yMean, 2.0);		  
			}			
		  **/ 
		
		//根据回归系数， 进行预测
		double[][] y = MatrixOperator.multiplyMatrix(this.x, beta);		
 	  
		//计算被解释变量的均值
		double yMean = 0.0;
		
		for(int i = 0; i < row; i++)
		{
		  yMean += this.y[i][0];			
		}
		yMean /= row;
		
		//计算TSS, RSS, ESS值
		for(int i = 0; i < row; i++)
		{
		  tss += Math.pow(this.y[i][0]-yMean, 2.0);		
		  rss += Math.pow(this.y[i][0]-y[i][0], 2.0);
		  ess += Math.pow(y[i][0]-yMean, 2.0);		  
		}	
		
		return;
	}
  
	/**
	 * 计算可决系数，拟合优度检验
	 */
    public void calculateRSquare()
    {   
    	 
    	//计算变差分解式
    	calculateDecomposeFormular();
    	//ess / tss;  
    	rSquare = 1 - rss / tss;
    	return;    
    }

    /**
     * 计算修正可决系数
     */
    public void calculateRSquareAdjusted()
    { 
    	//获得可决系数
    	calculateRSquare();
    	
    	double rSA = 1.0 -  (1-rSquare)*(row-1)/(row - col) ;
    	//syso
    	
    	rSquareAdjusted = rSA < 0 ? 0 : rSA;
    	
    	return;
    }
     
    /**
     * 显著性检验，F-检验 
     * @return true: 说明回归方程显著，即列入模型的各个解释变量联合起来对被解释变量有显著影响.
     *        false: 说明回归方程不显著，即列入模型的各个解释变量联合起来对被解释变量影响不显著.
     */
    public void isSatisfyFtest()
    {    
    	int degree1 =  col -1 ;
    	int degree2 =  row - col;
    	f_statistic = (ess / degree1) / (rss / degree2);    	  
  
    	return  ;
    }
    
    /**
     * 显著性检验，t-检验 
     * 
     * @return boolean[]
     * 		   true: 解释变量对被解释变量的影响是显著的
     * 		  false: 解释变量多被解释变量的影响不是显著的 	
     */
    public void isSatisfyTtest()
    {     
    	//获得 Cii值
    	double[][] transposeX = MatrixOperator.transposeMatrix(this.x);
    	double[][] multiMatrix = MatrixOperator.multiplyMatrix(transposeX, this.x);
    	double[][] reserveMatrix = MatrixOperator.reverseMatrix(multiMatrix); 
    	 
    	//获得随机干扰项的方差 
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
     * 计算残差
     * @param isTrainSample [true:对训练样本进行求残差]、[false： 对测试样本求残差]
     * 
     * 若isTrainSample为false， 在此函数调用之前,需调用
     * @2 setSampleX(); setSampleY();
     */	     	
	public void calculateResiduals(boolean isTrainSample)
	{
		//预测值、真实值
		double[][] yPredication;	  
		
		//对训练样本求残差
		if(isTrainSample)
		{
			setSampleX(this.x);
			setSampleY(this.y);
		} 
		yPredication= MatrixOperator.multiplyMatrix(sampleX, beta);			
	
		//计算残差 		 
		int len = sampleY.length;
		this.residuals = new double[len][sampleY[0].length];
		
		for(int i = 0; i < len; i++)
		{
			this.residuals[i][0] = sampleY[i][0] - yPredication[i][0];	
		}	
	}	
	
	
    /**
     * 显著性检验，D-W 检验 
     * 
     * @return true: 解释变量对被解释变量的影响是显著的
     * 		  false: 解释变量对被解释变量的影响不是显著的 	
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
    	
    	//计算DW变量  
    	 dw = (et1/et2);     	 
    }       
    
    /**
     * 异方差异性检验
     * 
     * @return true: 存在异方差异性
     * 		  false: 不存在异方差异性
     */
    public boolean isHeteroscedasticity()
    {    	
    	//获得权矩阵
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
    	
    	//计算样本方差
    	sigma /= (row -1);    	
    	 	 
    	double[][] matrixW = new double[row][row];
    	for(int i = 0; i < row; i++)
    	{
    		matrixW[i][i] = sigma * w[i][i];    		
    	}
    	
    	// 计算残差矩阵的期望
    //	double[][] meanMatrix = new double[row][row];        	 
    	//todo... 计算矩阵的期望     	  对 [uu'] 矩阵求期望
    	/**
    	 * 
    	 * 
    	 *    ???????????????
    	 * 
    	 * 
    	 * 
    	 */
    	 
    	//存在异方差的两个条件
    	/*return (  MatrixOperator.isEqualsMatrix(meanMatrix, matrixW)  &&     			
    			 (Double.compare(mean, 0.000001)<0  && 
    			  Double.compare(mean, -0.000001)>0) 
    			); */   	 
    	
    	return true;
    }
         
    
     /**
      * 根据回归方程的函数形式，对解释变量和被解释变量进行转化      
      * @param lamda 当回归方程的函数形式为   Box-Cox转换,此参数才起作用
      * 注：此函数调用之前需调用setFunctionType()对回归方程函数形式进行设置，默认为线性回归方程。      
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
      * 预测
      * @param x 预测样本解释变量
      * @param beta 回归方程系数
      */
     public double[][] predict(double[][] x, double[][] beta)
     {
    	 return MatrixOperator.multiplyMatrix(x, beta);    	 
     }
    		 
   /**
    * 算法流程
    * @param functionType  函数方程形式
    * @param baseNumber  底数
    * @param lambda  参数
    * @param isWeighted  是否使用加权最小二乘法  
    */
     public void runMulRegressionAnalysis(FunctionType functionType, double baseNumber, double lambda, boolean isWeighted)
     {
    	//@1 确定回归方程函数回归形式
    	determinedDatas(functionType, baseNumber, lambda);
    	 
    	//@2 利用最小二乘法确定回归参数
    	calculateBeta();
    	calculateResiduals(true);
    	
    	//是否使用加权最小二乘法
    	if(isWeighted)
    	{
    		calculateWBeta();
    		setBeta(wBeta);
    	}
    	 
    	 
 		 System.out.println("打印beta 值 :");
    	 
 		MatrixOperator.show(getBeta());	
 		
    	//计算相关指标和 检验
 		calculateStatistic();
		calculateRSquareAdjusted();
		 
		isSatisfyFtest();
		  
		isSatisfyTtest();			 
	  
		isSatisfyD_Wtest();		
		 
		//System.out.println("打印相关统计量\r\n"+toString());
		
		//@3 预测		    	 
    	 this.predictions = predict(sampleX, beta);
    	  
    	 return;
     }
     
     
     
     
     
}
