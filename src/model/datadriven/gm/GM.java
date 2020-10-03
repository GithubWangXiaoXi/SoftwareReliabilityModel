package model.datadriven.gm;

import modelinterface.BasicModel;
import util.MatrixOperator;

public class GM implements BasicModel {

   private double[] series;   //ԭʼ����	  
   private int steps = -1;    //Ԥ�ⲽ�� 
   private double[] forecasts;  //Ԥ������
   private double[] fitnesses;    //���ֵ
      
   private double a;	//�������� a
   private double b;	//�������� b
   
   private int order;	//����
 
  
	//Ĭ�Ϲ��캯��
    public GM(){
    	
    }
    
    
	//�����н����ۼ����
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
	
	
	//���ɽ��ھ�ֵ���У� �ۼӺ����������ֵ�� ƽ��ֵ
	private double[] averageNear(final double[] acc){
		
		int len =  acc.length;
		
		//���ɺ������ ���� ��ԭʼ����Ҫ�� 1
		double[] ave = new double[len-1];
		
		for(int i = 0; i < len-1; i++)
		{
			ave[i] = (acc[i] + acc[i+1]) / 2;
		}		
		
	return ave;	
	}
	
	
	//ѵ��ģ��
	private void RunGM(){
		
		//@1 ��ԭʼ���н����ۼ����		
		double[] acc = accumulate();
		//System.out.println("ԭʼ���У�\n"+Arrays.toString(series));
		// System.out.println("�ۼ���� ��\n"+ Arrays.toString(acc));
		
		//@2 ������ھ�ֵ
		double[] z = averageNear(acc);
		//System.out.println("���ھ�ֵ ��\n"+ Arrays.toString(ave));
	
		//@3  �������Y[(n-1)x1]��B[(n-1)x2)		  
		int len = series.length;
		double[][] Y = new double[len-1][1];
		double[][] B = new double[len-1][2];

		for(int i = 0; i < len-1; i++)
		{
			Y[i][0] = series[i+1];
			B[i][0] = -z[i]; 
			B[i][1] = 1; 
		}
		
		//@4 ����������� [a b]T = ((BT)*B)'(BT)Y��  BTΪB��ת��
		double[][] BT = MatrixOperator.transposeMatrix(B);
		double[][] temp1 = MatrixOperator.multiplyMatrix(BT, B);
		double[][] temp2 = MatrixOperator.reverseMatrix(temp1);
		double[][] temp3 = MatrixOperator.multiplyMatrix(temp2, BT);		
		double[][] coeffi = MatrixOperator.multiplyMatrix(temp3,Y);		
		
		this.a = coeffi[0][0];
		this.b = coeffi[1][0];
		
		return;
	}
	
	
	// ��ɫģ�͵�Ԥ��Ԥ�⹫ʽ
	private double modelGM(int k){
		
		double mult1 = 1 - Math.exp(a);
		double mult2 = (series[0] - b/a) * Math.exp(-a*k);
		
		return mult1 * mult2;
	}
	
	
	//lastNum Ϊԭʼ�������е���� ���ݵ���������ģ�ã� ��һ����Ԥ��
	public double[] getLastForecast(int lastNum, int steps)
	{
		int len = series.length;
		if(lastNum > len)
		{
			return null;	//����ģ���������� ����ԭʼ���ݵ��ܳ���
		}
		double[] last = new double[lastNum];
		int index = 0;
		for(int i = len-lastNum; i < len; i++)
		{
			last[index++] = series[i];
		}
				
		//Ԥ�ⲽ��
		double[] param = {1.0, 1.0};
		inputdata(last, param); 
		double[] out = getoutdata(steps);
		return out;
	}
	 
	//�ֲ�Ԥ�⣬����ǰ��Ԥ��ֵ������ѵ�����н�ģ��������һ��Ԥ�⡣
	public double[] loopForcast(int lastNum, int steps)
	{
		int len = series.length;
		if(lastNum > len)
		{
			return null;	//����ģ���������� ����ԭʼ���ݵ��ܳ���
		}
		double[] last = new double[lastNum];
		int index = 0;
		for(int i = len-lastNum; i < len; i++)
		{
			last[index++] = series[i];
		}
				
		//Ԥ�ⲽ��
		double[] param = {1.0, 1.0};
		double[] retResults = new double[steps];
		for(int i = 0; i < steps; i++)
		{
			//һ��Ԥ��
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
	  //ģ��ѵ��
		private void RunGM21()
		{
			int series_len = this.series.length;
			
			double[] X0 = new double[series_len];  //�ۼ�����
			
			double[] Z1 = new double[series_len-1];   //���ھ�ֵ����
			
			X0[0] = this.series[0];
			
			for(int i = 1; i < series_len; i++)
			{
				X0[i] = this.series[i] - this.series[i-1];
				Z1[i-1] = (this.series[i] + this.series[i-1])/2;
			}
			
			
			//����a,b ����
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
		
		
		//ѵ�����ģ�͹�ʽ
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
			java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//�������ָ�ʽ
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
 	//�������� �� �㷨������Ĳ���
	public void inputdata(double data[], double[] parameter)
	{
		  
	  // this.steps = step;
	   this.order = (int)(parameter[0] + 0.1);
	 
	   
	   if(data.length < 3)
	   {
		   throw new IllegalArgumentException("ԭʼ���ݸ�������С�� 3 ��...!");
	   }
	   
	   this.series = data.clone();
	   
		//ѵ��ģ��
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
		//ģ��Ԥ��
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
			return "GM(1,1)||  (1-exp(a))(x0(1)+(b/a))exp(-(a*k))"+"\r\n���У�a = "+a+"��b="+b;
		}else	//GM(2,1)
		{
			return "GM(2,1)||  X(k+1) = "+a+"*X(1) / "+"["+b+"*X(1) + " + "("+a+" - ("+b+")*X(1)"+")"+"]" +
					"" +
					"exp("+a+"*k)\r\n����: a = "+a+"��b="+b;			
		}		
	}
	
	@Override
	public String getparameterinfo(){
		 
		return "ָ��������"+this.order+"��";
	}

 
}