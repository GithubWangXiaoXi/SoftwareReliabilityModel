package model.classic.schneidewind;

import modelinterface.ClassicModel;

public class Schneidewind implements ClassicModel
{
	private double[] data;  //ʧЧ������ݼ�
	private double[] outdata; // Ԥ������
	private double p,q;
	private String process;
	private double[] ttf; 
	private double ex;
	private double ey;
	private double[] ugraph;
//	private double[] fitness;
	
	/**
	 * ��ʧЧ������ݼ�ת��Ϊtimetofailure���ݼ�
	 * @param a
	 * @return
	 */
	private double[] changeData(double a[]) {
		double x[] = new double[a.length];
		x[0] = a[0];
		double sum = a[0];
		for(int i = 1 ; i < a.length ; i ++) {
			sum += a[i];
			x[i] = sum;
		}
		return x;
	}
	
	/**
	 * ����ģ���㷨�������a
	 * @param a
	 * @return
	 */
	private double calculatea(double[] a) {
		double c = 0;
		for(int i = 1 ; i < a.length - 1 ; i ++) {
			c += Math.exp(-calculateb(a) * a[i]) * (a[i + 1] - a[i]);
		}
		c = a.length / c;
		return c;
	}

	/**
	 * ����ģ���㷨�������b
	 * @param a
	 * @return
	 */
	private double calculateb(double[] a) {
		double b = 0;
		double q = 0;
		double sum_tj = 0;
		for(int i = 0 ; i < a.length - 1 ; i ++) {
			sum_tj += a[i];
		}
		for(int i = 1 ; i < a.length - 1 ; i ++) {
			q += (sum_tj - (a.length) * a[i]) * (a[i + 1] - a[i]);
		}
		if (q > 0) {
			System.out.println("�����ʵ�������");
			return 0;
		}
		double xx = 0;
		if(q < 0) {
			double xl = 0.0;
			double xr = 1.0;
			double xm;
			double P = 0;
			boolean flag = false;
			do {
				P = 0;
				xm = (xl + xr) / 2;
				for (int i = 0 ; i < a.length - 1 ; i ++) {
					P += (sum_tj - a.length * a[i]) * (a[i + 1] - a[i])
							* Math.pow(xm , a[i] - a[0]);
				}
				if (P <= ey && P >= -ey) {
					xx = xm;
					flag = true;
					break;
				} else if (P > ey) {
					xl = xm;
				} else
					xr = xm;
			} while (Math.abs(xr - xl) > ex);
			if (flag == false) {
				xx = (xr + xl) / 2;
			}
		} else {
			xx = 1;
		}
		b = -Math.log(xx);
		return b;
	}

	/**
	 * �Ե�i�����ݵ�Ԥ��
	 * @param a
	 * @return
	 */
	private double predict(double a[]) {
		double x;
		x = MTBF(a)[a.length - 1];
		return x;
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
	 * �����ܶȺ���
	 */
	private double[] F(double a[]) {
		double f[] = new double[a.length];
		for(int i = 0 ; i < a.length - 1 ; i ++) {
			f[i] = p * Math.exp(- q * a[i]) * Math.exp(- p * (a[i + 1] - a[i]) * Math.exp(- q * a[i]));
		}
		return f;
	}
	
	/**
	 * �ɿ��Ⱥ���
	 */
	private double[] R(double a[]) 
	{
		double b[] = new double[a.length];
		b[0] = Math.exp(-p * (a[1] - a[0])) * Math.exp(-q * a[0]);
		for (int i = 1 ; i < a.length ; i ++) {
			b[i] = Math.exp(-p * (a[i] - a[i - 1])) * Math.exp(-q * a[i - 1]);
		}
		return b;
	}
	
	/**
	 * ˲ʱʧЧ��
	 */
	private double[] Fault(double a[]) {
		
		double fault[] = new double[a.length];
		for(int i = 0 ; i < a.length ; i ++) {
			fault[i] = p * Math.exp(-q * a[i]);
		}
		return fault;
	}
	
	/**
	 * ��i��ʧЧ��ƽ��ʧЧ���ʱ��
	 * @param a
	 * @return
	 */
	private double[] MTBF(double a[])
	{
		double[] MTBF = new double[a.length];
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
	
	/**
	 * ����ӿ�
	 */
	public void inputdata(double data[], double[] parameter) {
		this.data = data.clone();
		ex = parameter[0];
		ey = parameter[1];
		ttf = changeData(data);
		q = calculateb(ttf);
		p = calculatea(ttf);
		process = "ģ�Ͳ���a��" + p + '\n' + "ģ�Ͳ���b��" + q ;
//		fitness = getfitness();
		ugraph = get_ugraph();
	}

	/**
	 * ����ӿڣ�stepΪԤ�ⲽ��
	 * @param step
	 * @return
	 */
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
	
	/**
	 * ������Ϣ�ӿ�
	 */
	public String getprocess() {
		return process;
	}

	/**
	 * ������Ϣ�ӿ�
	 */
	public String getparameterinfo() {
		String info ="��������ex��" + ex + "�������¹���ֵ��"
				+ ey +"��";
		return info;
	}

	/**
	 * ��������Ԥ����Ϣ
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

	/**
	 * ���Uͼ��������
	 */

	public double[] get_ugraph() {
		double u[] = new double[ttf.length];
		for (int i = 0; i < ttf.length; i++) {
			u[i] = DF(ttf)[i];
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
			y[i] = sumxi[i] / sumx;
		}
		return y;
	}

	@Override
	public double[] get_PLR() {
		return F(data);
	}
}
