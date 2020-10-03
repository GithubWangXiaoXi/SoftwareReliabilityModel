package model.classic.mo;

import modelinterface.ClassicModel;

public class MO implements ClassicModel
{
	private double[] data; // 失效间隔数据集
	private double[] outdata; // 预测数据
	private String process;
	private double p,q;
	private double[] ttf;
	private double ex,ey;
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
	 * 功能函数1
	 * @param x
	 * @return
	 */
	private double f1(double x) {
		double f1x = 0.0;
		double sum1 = 0.0;
		double sum2 = 0.0;
		for(int i = 1 ; i < ttf.length - 1 ; i ++) {
			sum1 += 1.0 / (1 + x * ttf[i]);
			sum2 += ttf[i] / ((1 + x * ttf[i]) * (1 + x * ttf[i]));
		}
		f1x -= sum1 / (x * x);
		f1x -= sum2 / x;
		sum1 = 1.0 / Math.log(1.0 + x * ttf[ttf.length - 1]);
		sum2 = (ttf.length - 2) * ttf[ttf.length - 1] * ttf[ttf.length - 1] / ((1 + x * ttf[ttf.length - 1]) * (1 + x * ttf[ttf.length - 1]));
		f1x += sum1 * sum2 * (1.0 + sum1);
		return f1x;
	}
	
	/**
	 * 功能函数2
	 * @param x
	 * @return
	 */
	double f11(double x) {
		double sum = 0.0;
		for(int i = 1 ; i < ttf.length - 1 ; i ++)
			sum += 1.0 / (1.0 + x * ttf[i]);
		sum /= x;
		sum -= (ttf.length - 2) * ttf[ttf.length - 1] / ((1 + x * ttf[ttf.length - 1]) * Math.log(1.0 + x * ttf[ttf.length - 1]));
		return sum;
	}
	
	/**
	 * 估算参数b
	 * @param a
	 * @return
	 */
	private double calculateb(double a[]) {
		double b = 0;
		double x0 = 2;
		double x1 = 0.0001;
		while( Math.abs(x1 - x0) > ex)
		{
			x0 = x1;
			x1 = x0 - f11(x0) / f1(x0);
			if(Math.abs(f11(x1)) <= ey) {
				return 0;
			}
		}
		b = x1;
		return b;
	}
	
	/**
	 * 估算参数a
	 * @param a
	 * @return
	 */
	private double calculatea(double a[]) {
		double c = 0;
		c = (a.length - 2) / Math.log(1.0 + calculateb(a) * a[a.length - 1]);
		return c;
	}
	
	/**
	 * 分布函数：df(i)=1-R(i)
	 * @param a
	 * @return
	 */
	private double[] DF(double a[])			
	{
		double df[]=new double[a.length];
		for(int i = 0 ; i < a.length ; i ++)
		{
			df[i] = 1 - R(a)[i];
		}
		return df;				
	}
	
	/**
	 * 概率密度函数
	 */
	private double[] F(double a[]) {
		double f[] = new double[a.length];
		for(int i = 0 ; i < a.length - 1 ; i ++) {
			f[i] = p * q / (q * a[i + 1] + 1.0) *
			Math.pow(q * a[i] + 1.0 / (q * a[i + 1] + 1.0), p);
		}
		return f;
	}
	
	/**
	 * 失效率函数
	 *λ(Δt|t[i-1])= p * q / (q * (t[i - 1] + Δt) + 1)
	  *@param a
	 *@return 返回当前失效率
	 */
	private double[] Fault(double a[]) {
		double fault[] = new double[a.length];
		fault[0] = p * q / (q * a[0] + 1);
		for (int i = 1 ; i < a.length; i++) {
			fault[i] = p * q / (q * a[i - 1] + 1);
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
			b[i] = Math.pow(((q * a[i - 1] + 1) / (q * a[i] + 1)) , p);
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
		process = "";
		this.data = data.clone();
		ex = parameter[0];
		ey = parameter[1];
		ttf = changeData(data);
		q = calculateb(ttf);
		p = calculatea(ttf);
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
		String info ="参数精度ex：" + ex + "；参数β估计值："
				+ ey +"；";
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
			java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//定义数字格式
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
		double u[] = new double[ttf.length];
		for (int i = 0; i < ttf.length; i++) {
			u[i] = DF(changeData(fitness))[i];
			if(i == ttf.length - 1) {
				u[i] = 0.999;
			}
		}
		for (int m = ttf.length - 1; m > 1; --m) { // 使用冒泡排序将得到的数组排序
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

		double sumx = 0;
		double sum = 0;
		double sumxi[] = new double[ttf.length];
		double x[] = new double[ttf.length];
		double y[] = new double[ttf.length];
		for(int i = 0 ; i < ttf.length ; i ++)
		{
			x[i] = Math.log(1 - ugraph[i]);	
		}
		for(int m = 1 ; m < ttf.length ; m++)
		{
			sumx += x[m];
		}
		for(int j = 1 ; j < ttf.length ; j++)
		{
			sum+=x[j];
			sumxi[j]=sum;
		}
		for(int i = 0 ; i< ttf.length ; i ++)
		{
			y[i] = sumxi[i] / sumx;
		}
		return y;
	}
	@Override
	public double[] get_PLR() {
		return F(data);
	}
}
