package model.datadriven.gm;

import modelinterface.BasicModel;
import util.MatrixOperator;

public class GM implements BasicModel {

   private double[] series;   //原始序列	  
   private int steps = -1;    //预测步骤 
   private double[] forecasts;  //预测数据
   private double[] fitnesses;    //拟合值
      
   private double a;	//待定参数 a
   private double b;	//待定参数 b
   
   private int order;	//阶数
 
  
	//默认构造函数
    public GM(){
    	
    }
    
    
	//对序列进行累加求和
    private double[] accumulate(){
		
		int len = series.length;
		double[] acc = new double[len];
		
		for(int i = 0; i < len; i++)
		{
			double sum = 0;
			for(int j = 0; j<=i; j++)
			{
				sum += series[j];
			} 
			acc[i] = sum;
		}
		
		return acc;
	}
	
	
	//生成紧邻均值序列， 累加后的序列相邻值的 平均值
	private double[] averageNear(final double[] acc){
		
		int len =  acc.length;
		
		//生成后的序列 长度 比原始序列要少 1
		double[] ave = new double[len-1];
		
		for(int i = 0; i < len-1; i++)
		{
			ave[i] = (acc[i] + acc[i+1]) / 2;
		}		
		
	return ave;	
	}
	
	
	//训练模型
	private void RunGM(){
		
		//@1 对原始序列进行累加求和		
		double[] acc = accumulate();
		//System.out.println("原始序列：\n"+Arrays.toString(series));
		// System.out.println("累加求和 ：\n"+ Arrays.toString(acc));
		
		//@2 计算紧邻均值
		double[] z = averageNear(acc);
		//System.out.println("紧邻均值 ：\n"+ Arrays.toString(ave));
	
		//@3  构造矩阵Y[(n-1)x1]、B[(n-1)x2)		  
		int len = series.length;
		double[][] Y = new double[len-1][1];
		double[][] B = new double[len-1][2];

		for(int i = 0; i < len-1; i++)
		{
			Y[i][0] = series[i+1];
			B[i][0] = -z[i]; 
			B[i][1] = 1; 
		}
		
		//@4 计算待定参数 [a b]T = ((BT)*B)'(BT)Y；  BT为B的转置
		double[][] BT = MatrixOperator.transposeMatrix(B);
		double[][] temp1 = MatrixOperator.multiplyMatrix(BT, B);
		double[][] temp2 = MatrixOperator.reverseMatrix(temp1);
		double[][] temp3 = MatrixOperator.multiplyMatrix(temp2, BT);		
		double[][] coeffi = MatrixOperator.multiplyMatrix(temp3,Y);		
		
		this.a = coeffi[0][0];
		this.b = coeffi[1][0];
		
		return;
	}
	
	
	// 灰色模型的预测预测公式
	private double modelGM(int k){
		
		double mult1 = 1 - Math.exp(a);
		double mult2 = (series[0] - b/a) * Math.exp(-a*k);
		
		return mult1 * mult2;
	}
	
	
	//lastNum 为原始数据序列的最后 数据的数量（建模用） ，一次性预测
	public double[] getLastForecast(int lastNum, int steps)
	{
		int len = series.length;
		if(lastNum > len)
		{
			return null;	//建立模型所需数据 大于原始数据的总长度
		}
		double[] last = new double[lastNum];
		int index = 0;
		for(int i = len-lastNum; i < len; i++)
		{
			last[index++] = series[i];
		}
				
		//预测步数
		double[] param = {1.0, 1.0};
		inputdata(last, param); 
		double[] out = getoutdata(steps);
		return out;
	}
	 
	//分布预测，将当前的预测值，放在训练集中建模，进行下一次预测。
	public double[] loopForcast(int lastNum, int steps)
	{
		int len = series.length;
		if(lastNum > len)
		{
			return null;	//建立模型所需数据 大于原始数据的总长度
		}
		double[] last = new double[lastNum];
		int index = 0;
		for(int i = len-lastNum; i < len; i++)
		{
			last[index++] = series[i];
		}
				
		//预测步数
		double[] param = {1.0, 1.0};
		double[] retResults = new double[steps];
		for(int i = 0; i < steps; i++)
		{
			//一步预测
			inputdata(last, param); 
			double[] out = getoutdata(steps);
			retResults[i] = out[0]; 
			for(int j = 0; j < lastNum-1; j++)
			{
				last[j] = last[j+1];
			}
			last[lastNum-1] = out[0];
		}
		return retResults;
	}
	
	
	//
	  //模型训练
		private void RunGM21()
		{
			int series_len = this.series.length;
			
			double[] X0 = new double[series_len];  //累减序列
			
			double[] Z1 = new double[series_len-1];   //紧邻均值序列
			
			X0[0] = this.series[0];
			
			for(int i = 1; i < series_len; i++)
			{
				X0[i] = this.series[i] - this.series[i-1];
				Z1[i-1] = (this.series[i] + this.series[i-1])/2;
			}
			
			
			//计算a,b 参数
			int XLen = series_len-1;
			double[][] X = new double[XLen][2];
			for(int row = 0; row < XLen; row++)
			{
				 X[row][0] = -Z1[row];
				 X[row][1] = Z1[row]*Z1[row];			 
			}
			
			double[][] Y = new double[XLen][1];
			for(int k = 0; k < XLen; k++)
			{
				Y[k][0] = X0[k+1];
			}
			
			double[][] Xt = MatrixOperator.transposeMatrix(X);
			double[][] multi = MatrixOperator.multiplyMatrix(Xt, X);
			double[][] Xt_X_reverse = MatrixOperator.reverseMatrix(multi);
			double[][] m1 = MatrixOperator.multiplyMatrix(Xt_X_reverse, Xt);		
			double[][] ab = MatrixOperator.multiplyMatrix(m1, Y);	
			
		
			this.a = ab[0][0];
			this.b = ab[1][0];		
		}
		
		
		//训练后的模型公式
		private double modelGM21(int k)
		{
			double numerator = a * series[0]; 
			double denominator1 = b * series[0]; 
			double denominator2 = (a - b*series[0])*Math.exp(a*k);	 
			
			return numerator / (denominator1 + denominator2);
		}
		
	
		public double[] getfitness() 
		{		 
			int series_len = this.series.length;
			fitnesses = new double[series_len];
			java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//定义数字格式
			if (order == 1) 
			{
				for (int i = 0; i < series_len; i++) 
				{
					fitnesses[i] = Double.parseDouble(df.format(modelGM(i+1)));
				}		
			}else
			{
				for(int step = 0; step < series_len; step++)
				{
					fitnesses[step] = Double.parseDouble(df.format(modelGM21(step)));
				}				
			}
		return fitnesses.clone();
	}
 
	
	@Override
 	//输入数据 及 算法所必需的参数
	public void inputdata(double data[], double[] parameter)
	{
		  
	  // this.steps = step;
	   this.order = (int)(parameter[0] + 0.1);
	 
	   
	   if(data.length < 3)
	   {
		   throw new IllegalArgumentException("原始数据个数不得小于 3 个...!");
	   }
	   
	   this.series = data.clone();
	   
		//训练模型
	   if(order == 1)
	   {
		   RunGM();
	   }else
	   {
		   RunGM21();
	   }		
		 
		return;
	} 
	
	 
	@Override
	public double[] getoutdata(int step) {
		//模型预测
		this.steps = step;
		forecasts = new double[steps];
		
		int seriesLen = series.length;
		for(int n = 0; n < steps; n++)
		{
			if(order == 1)
			{
				forecasts[n] = modelGM(n + seriesLen);
			}else
			{
				forecasts[n] = modelGM21(n + seriesLen);
			}			
		} 
		return forecasts.clone();
	}

	@Override
	public String getprocess() {
		 
		java.text.DecimalFormat df = new java.text.DecimalFormat("0.0000");
		String a = df.format(this.a);
		String b = df.format(this.b);
		
		if(this.order == 1)   //GM(1,1)
		{
			return "GM(1,1)||  (1-exp(a))(x0(1)+(b/a))exp(-(a*k))"+"\r\n其中：a = "+a+"，b="+b;
		}else	//GM(2,1)
		{
			return "GM(2,1)||  X(k+1) = "+a+"*X(1) / "+"["+b+"*X(1) + " + "("+a+" - ("+b+")*X(1)"+")"+"]" +
					"" +
					"exp("+a+"*k)\r\n其中: a = "+a+"，b="+b;			
		}		
	}
	
	@Override
	public String getparameterinfo(){
		 
		return "指数分量："+this.order+"；";
	}

 
}