package model.classic.weibull;

import modelinterface.ClassicModel;

public class Weibull implements ClassicModel
{
	private double[] data; 					// ʧЧ������ݼ�
	private double[] outdata; 				// Ԥ������
	private String process;					//������Ϣ
	private double p,q; 					//ģ�͵ĳ߶�/��״����
	private double[] ttf;					//ʧЧʱ�����ݼ�time-to failure
	private double[] ugraph;				//�����м����Uͼ����
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
		for (int i = 1; i < a.length; i++) {				//ʧЧ������ݵĺͼ�ΪʧЧʱ������
			sum += a[i];
			x[i] = sum;
		}
		return x;
	}

	/**
	 * �µļ�����Ȼ����ֵ
	 * 
	 * @param a
	 * @return
	 */
	private double calculateb(double a[]) {
		ttf = changeData(a);
		double likelihoodb;									//b�ļ�����Ȼ����ֵ
		double sum = 0;
		for (int i = 0; i < ttf.length; i++) {
			sum += Math.log(ttf[ttf.length - 1] / ttf[i]);
		}

		likelihoodb = ttf.length / sum;
		return likelihoodb;
	}

	/**
	 * ���ļ�����Ȼ����ֵ
	 * 
	 * @param a
	 * @return
	 */
	private double calculatea(double a[]) {
		ttf = changeData(a);
		double likelihooda;									//a�ļ�����Ȼ����ֵ
		likelihooda = ttf[ttf.length - 1]
				/ Math.pow(ttf.length, (1 / calculateb(a)));
		return likelihooda;
	}

	/**
	 * ʧЧԤ��
	 * 
	 * @param a
	 * @return
	 */
	private double predict(double a[]) {
		double x;
		x=  MTBF(a)[a.length - 1];
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
		for (int i = 0; i < a.length; i++) {
			double t = Math.pow((a[i] / p), q);
			f[i] = (calculateb(a) * t * Math.exp(- t)) / (a[i]);
		}
		return f;
	}

	/**
	 * ����ɿ���
	 */
	private double[] R(double a[]) {
		double b[] = new double[a.length];
		for (int i = 0; i < a.length; i++) {
			b[i] = Math.exp(-Math.pow(a[i] / p, q));
		}
		return b;
	}

	/**
	 * ˲ʱʧЧ��
	 */
	private double[] Fault(double a[]) {
		double fault[] = new double[a.length];
		for (int i = 0; i < a.length; i++) {
			fault[i] = (q / p)
					* Math.pow(a[i] / p , q - 1.0);
		}
		return fault.clone();
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

	/**
	 * ����ӿ�
	 */
	public void inputdata(double data[], double[] parameter) {
		this.data = data.clone();
		q = calculateb(data);
		p = calculatea(data);
		process = "ģ�Ͳ���a��" + p + '\n' + "ģ�Ͳ���b��" + q ;
		fitness = getfitness();
		ugraph = get_ugraph();
	}

	/**
	 * ����ӿڣ�stepΪԤ�ⲽ��
	 * 
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
		
		String info = "�޲���";
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

	/**
	 * ���Uͼ��������
	 */

	public double[] get_ugraph() {
		// TODO Auto-generated method stub
		double u[] = new double[data.length];
		for (int i = 0; i < data.length; i++) {
			u[i] = DF(fitness)[i];
		}
		for (int m = data.length - 1; m > 1; --m) { // ʹ��ð�����򽫵õ�����������
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
		return F(data);
	}
}