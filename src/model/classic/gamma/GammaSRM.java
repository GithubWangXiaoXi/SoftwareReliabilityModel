package model.classic.gamma;

import phsrm.common.*;
import modelinterface.ClassicModel;

 public class GammaSRM implements ClassicModel  {
	
	 private double[] data; // 失效间隔数据集
		private double[] outdata; // 预测数据
		private String process;
		private double p,q;//rate,shape
		private double[] ttf;
	//	private double ex,ey;
		private double[] ugraph;
		private double[] fitness;
		
		/**
		 * 将失效间隔数据集转换为timetofailure数据集
		 * 
		 * @param a
		 * @return
		 */
		private double[] changeData(double a[]) {
			double x[] = new double[a.length];
			x[0] = a[0];
			double sum = a[0];
			for (int i = 1; i < a.length; i++) {
				sum += a[i];
				x[i] = sum;
			}
			return x;
		}

		/**
		 * β的极大似然估计值
		 * 
		 * @param a
		 * @return
		 */
		private double calculateb(double a[]) {
			ttf = changeData(a);
			double likelihoodb;									//b的极大似然估计值
			double sum = 0;
			for (int i = 0; i < ttf.length; i++) {
				sum += Math.log(ttf[ttf.length - 1] / ttf[i]);
			}

			likelihoodb = ttf.length / sum;
			return likelihoodb;
		}

		/**
		 * α的极大似然估计值
		 * 
		 * @param a
		 * @return
		 */
		private double calculatea(double a[]) {
			ttf = changeData(a);
			double likelihooda;									//a的极大似然估计值
			likelihooda = ttf[ttf.length - 1]
					/ Math.pow(ttf.length, (1 / calculateb(a)));
			return likelihooda;
		}
		
		/**
		 * 概率密度函数：
		 * @param a
		 * @return
		 */
	public double[] getPDF(double t[]) {
		double[] PDF = new double[t.length];
		for (int i = 0; i < t.length; i++) {
		  double y = p * t[i];
		  PDF[i]=p * Math.pow(y, q-1) * Math.exp(-y) / Numlib.gamma(q);
		  }
		return PDF;
	}
	
	/**
	 * 分布函数：
	 * @param a
	 * @return
	 */
	public double[] getCDF(double t[]) {
		double y;
		double[] CDF = new double[t.length];
		for (int i = 0; i < t.length; i++) {
		y = p * t[i];
		CDF[i]= Numlib.p_gamma(q, y, Numlib.loggamma(q));
		}
		 return CDF;
	}
	
	/**
	 * 失效率函数
	 *λ(Δt|t[i-1])= p * q / (q * (t[i - 1] + Δt) + 1)
	  *@param a
	 *@return 返回当前失效率
	 */
	private double[] Fault(double a[]) {
		double fault[] = new double[a.length];
		//fault[0] = p * q / (q * a[0] + 1);
		for (int i = 0 ; i < a.length; i++) {
			//fault[i] = p * q / (q * a[i - 1] + 1);
			//fault[i] = getPDF(a)[i]/R(a)[i];
			fault[i] = (q / p)
					* Math.pow(a[i] / p , q - 1.0);
			
		}
		return fault.clone();
	}
	
	/**
	 * 软件可靠度
	 */
	private double[] R(double a[]) {
		double b[] = new double[a.length];
		b[0] = Math.pow(((q * a[0] + 1) / (q * a[1] + 1)) , p);
		for (int i = 1 ; i < a.length ; i ++) {
			//b[i] = Math.pow(((q * a[i - 1] + 1) / (q * a[i] + 1)) , p);
		b[i]=1-getCDF(a)[i];
		}
		return b;
	}
	
	/**
	 * 第i次失效的平均失效间隔时间
	 * @param a
	 * @return
	 */
	private double[] MTBF(double a[])
	{
		double MTBF[] = new double[a.length];
		MTBF[0] = a[0];
		for(int i = 1 ; i < a.length ; i ++)
		{
			if(i < a.length - 1) {
				MTBF[i] = 1 / Fault(a)[i];
			}
			MTBF[i] = Math.abs(1 / ( 2 * Fault(a)[i] - Fault(a)[i - 1]));
		}
		return MTBF;
	}
	

	public void inputdata(double[] data, double[] parameter) {
		//process = "";
		this.data = data.clone();
		//ex = parameter[0];
		//ey = parameter[1];
		//ttf = changeData(data);
		q = calculateb(data);
		p = calculatea(data);
		process = "模型参数a：" + p + '\n' + "模型参数b：" + q ;
		fitness = getfitness();
		ugraph = get_ugraph();
	}
	
	private double predict(double a[]) {
		double x;
		x = MTBF(a)[a.length - 1];
		return x;
	}


	public double[] getoutdata(int step) {
		double[] pred = new double[data.length];
		for (int i = 0 ; i < data.length ; i ++) {
				pred[i] = data[i];
		}
		outdata = new double[step]; // 初始化数据
		for (int i = 0 ; i < step; i ++) // 向后预测，把结果存入outdata数组中
		{
			double a = predict(pred);
			double b = MTBF(pred)[data.length - 2];
			for (int j = 0 ; j < pred.length - 1 ; j ++) {
				pred[j] = pred[j + 1];				
			}
			pred[pred.length - 1] = data[data.length - i % (data.length - 1) - 2];
			outdata[i] = Math.abs(a * (i + 1) - b * i);
		}
		return outdata;
	}


	public String getparameterinfo() {
		String info ="无参数";
		return info;
	}
	
	/**
	 * 所有数据拟合信息
	 * 
	 * @return
	 */
	public double[] getfitness() {
		double prediction[] = new double[data.length];
		prediction[0] = 0.001;
		prediction[1] = data[1];
		for (int i = 2 ; i < data.length ; i ++) {
			double[] pred = new double[i];
			for(int j = 0 ; j < i ; j ++) {
				pred[j] = data[j];
			}
			double a = MTBF(pred)[i - 1];
			prediction[i] = Math.abs(a * (i + 1) - MTBF(pred)[i - 2] * i);
			java.text.DecimalFormat df=new java.text.DecimalFormat("#.000000");	//定义数字格式
			prediction[i]=Double.parseDouble(df.format(prediction[i])); //将预测数据保留两位小数
		}
		return prediction;
	}

	public String getprocess() {
		return process;
	}
	
	/**
	 * 获得U图纵轴数组
	 */

	public double[] get_ugraph() {
		// TODO Auto-generated method stub
		double u[] = new double[data.length];
		for (int i = 0; i < data.length; i++) {
			u[i] = getCDF(fitness)[i];
		}
		for (int m = data.length - 1; m > 1; --m) { // 使用冒泡排序将得到的数组排序
			double temp;
			for (int n = 0 ; n < m ; n ++) {
				if (u[n] > u[n + 1]) {
					temp = u[n];
					u[n] = u[n + 1];
					u[n + 1] = temp;
				}
			}
		}
		return u;
	}

	/**
	 * 获得Y图纵轴数组
	 */

	public double[] get_ygraph() {
		// TODO Auto-generated method stub
		double sumx = 0;
		double sum = 0;
		double sumxi[] = new double[data.length];
		double x[] = new double[data.length];
		double y[] = new double[data.length];
		for(int i = 0 ; i < data.length ; i ++)
		{
			x[i] = Math.log(1 - ugraph[i]);	
		}
		for(int m = 1 ; m < data.length ; m++)
		{
			sumx += x[m];
		}
		for(int j = 1 ; j < data.length ; j++)
		{
			sum+=x[j];
			sumxi[j]=sum;
		}
		for(int i = 0 ; i<data.length ; i ++)
		{
			y[i] = sumxi[i] / sumx;
		}
		return y;
	}

	@Override
	public double[] get_PLR() {
		return getPDF(data);
	}
}
