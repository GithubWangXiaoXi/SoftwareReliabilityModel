package model.classic.go;

import com.sun.swing.internal.plaf.basic.resources.basic;

import modelinterface.ClassicModel;

public class GO implements ClassicModel
{
	private double[] data; // ʧЧ������ݼ�
	private double[] outdata; // Ԥ������
	private String process;
	private double p,q;
	private double[] ttf;
	private double ex,ey;
	private double[] ugraph;
	private double[] fitness;
	
	/**
	 * ��ʧЧ������ݼ�ת��Ϊtimetofailure���ݼ�
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
	 * �������b
	 * @param a
	 * @return
	 */
	private double calculateb(double a[]) {
		double b = 0;
		double d = 0;
		for(int i = 0 ; i < a.length ; i ++) {
			d += a[i];
		}
		d /= (a.length) * a[a.length - 1];
		if(d > 0.5) {
			System.out.println(d);
			System.out.println("�޷��������");
			return 0;
		}
		double xl = (1 - 2 * d) / 2;
		double xr = 1 / d;
		double xm = (xl + xr) / 2;
		while(Math.abs(xl - xr) > ex) {
			double f = (1 - d * xm) * Math.exp(xm) + (d - 1) * xm - 1;
			if(f > ey) {
				xl = xm;
			} else if ( f < -ey) {
				xr = xm;
			} else {
				break;
			} 
			xm = (xl + xr) / 2;
		}
		b = xm / a[a.length - 1];
		return b;
	}
	
	/**
	 * �������a
	 * @param a
	 * @return
	 */
	private double calculatea(double a[]) {
		double c = 0;
		c = (a.length - 1) / (1 - Math.exp(-calculateb(a) * a[a.length - 1]));
		return c;
	}
	
	/**
	 * �ֲ�������df(i)=1-R(i)
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
	 * �����ܶȺ���f[i]=p*q*e^(-q*a[i+1])*(e^(-p*(e^(-q*a[i])-e^(-q*a[i+1]))))
	 */
	private double[] F(double a[]) {
		double f[] = new double[a.length];
		for(int i = 0 ; i < a.length - 1 ; i ++) {
			f[i] = p * q * Math.exp(- q * a[i + 1]) * 
			(
				Math.exp(- p * 
					(
							Math.exp(- q * a[i]) - Math.exp(- q * a[i + 1])
					)	
				)	
			);
		}
		return f;
	}
	
	/**
	 * ˲ʱʧЧ��fault=p*q*e^(-q*a[i])
	 */
	private double[] Fault(double a[]) {
		double fault[] = new double[a.length];
		for (int i = 0; i < a.length; i++) {
			fault[i] = p * q *
					Math.exp(-q * a[i]);
		}
		return fault.clone();
	}
	
	/**
	 * ����ɿ���b[i]=e^(-p*(e^(-q*a[i-1])-e^(-q*a[i])))
	 */
	private double[] R(double a[]) {
		double b[] = new double[a.length];
		b[0] = Math.exp(-p * (Math.exp(-q * a[0]) - Math.exp(-q * a[1])));
		for (int i = 1; i < a.length; i++) {
			b[i] = Math.exp(-p * (Math.exp(-q * a[i - 1]) - Math.exp(-q * a[i])));
		}
		return b;
	}
	
	/**
	 * ��i��ʧЧ��ƽ��ʧЧ���ʱ��
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
		outdata = new double[step]; // ��ʼ������
		for (int i = 0 ; i < step; i ++) // ���Ԥ�⣬�ѽ������outdata������
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
		String info ="��������ex��" + ex + "�������¹���ֵ��"
				+ ey +"��";
		return info;
	}
	
	/**
	 * �������������Ϣ
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
			java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//�������ָ�ʽ
			prediction[i]=Double.parseDouble(df.format(prediction[i])); //��Ԥ�����ݱ�����λС��
		}
		return prediction;
	}


	public String getprocess() {
		return process;
	}


	public void inputdata(double[] data, double[] parameter) {
		process = "";
		this.data = data.clone();
		ex = parameter[0];
		ey = parameter[1];
		ttf = changeData(data);
		q = calculateb(ttf);
		p = calculatea(ttf);
		process = "ģ�Ͳ���a��" + p + '\n' + "ģ�Ͳ���b��" + q ;
		fitness = getfitness();
		ugraph = get_ugraph();
	}
	
	/**
	 * ���Uͼ��������
	 */

	public double[] get_ugraph() {
		double u[] = new double[ttf.length];
		for (int i = 0; i < ttf.length; i++) {
			u[i] = DF(changeData(fitness))[i];
			if(i == ttf.length - 1) {
				u[i] = 0.999;
			}
		}
		for (int m = ttf.length - 1; m > 1; --m) { // ʹ��ð�����򽫵õ�����������
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
	 * ���Yͼ��������
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
			y[i] = Math.abs(sumxi[i] / sumx);
		}
		return y;
	}

	@Override
	public double[] get_PLR() {
		return F(data);
	}
}