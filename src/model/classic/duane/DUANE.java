package model.classic.duane;

import modelinterface.ClassicModel;

public class DUANE implements ClassicModel	
{
	private double [] data;
	private double [] outdata;					//Ԥ������
	private String process;
	private double p,q;						//ģ�Ͳ���
	private double[] ttf ;
	private double[] ugraph;
	private double[] fitness;
	
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
	 * ������С���˹��������a
	 * @param a
	 * @return
	 */
	private double calculatea(double a[])			
	{
		ttf = changeData(a);
		double c = 0;
		c = 1.0 * (ttf.length - 1) / Math.pow(ttf[ttf.length - 1] , calculateb(a));
		return c;
	}
	
	/**
	 * ������С���˹��������b
	 * @param a
	 * @return
	 */
	private double calculateb(double a[])			
	{
		ttf = changeData(a);
		double b = 0;
		double t1 = 0;
		for(int i = 0 ; i < ttf.length-1 ; i ++) {
			t1 += Math.log(ttf[i]);
		}
		b = 1.0
				* ttf.length 
				/ ((ttf.length - 1) * Math.log(ttf[ttf.length - 1]) - t1);
		return b;
	}
	
	/**
	 * �Ե�i�����ݵ�Ԥ�⣬MTBFi
	 * @param a
	 * @return
	 */
	private double predict(double a[])			
	{
		double x;
		x = MTBF(a)[a.length - 1];
		return x;
	}
	
	/**
	 * �����ܶȺ���
	 */
	private double[] F(double a[]) {
		double f[] = new double[a.length];
		for(int i = 0 ; i < a.length ; i ++) {
			f[i] = Fault(a)[i] * R(a)[i];
		}
		return f;
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
	 * ˲ʱʧЧ��
	 * @param a
	 * @return
	 */
	private double[] Fault(double a[])			
	{
		double fault[]=new double[a.length];
		for(int i = 0 ; i < a.length ; i ++)
		{
			fault[i] = p * q * Math.pow(a[i] , q - 1);
		}
		return fault;
	}
	
	/**
	 * �ɿ��Ⱥ���
	 * @param a
	 * @return
	 */
	private double[] R(double a[])
	{
		double R[] = new double[a.length];
		for(int i = 0 ; i < a.length ; i ++)
		{
			R[i] = Math.exp(-p * Math.pow(a[i] , q));
		}
		return R;
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
	public void inputdata(double data[],double[] parameter)
	{
		this.data = data.clone();
		q = calculateb(data);
		p = calculatea(data);
		process = "ģ�Ͳ���a��" + p + '\n' + "ģ�Ͳ���b��" + q ;
		fitness = getfitness();
		ugraph = get_ugraph();
	}
	
	/**
	 * ����ӿڣ�stepΪԤ�ⲽ��
	 * @param step
	 * @return
	 */
	public double[] getoutdata(int step)
	{
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
	public String getprocess()
	{
		return process;
	}
	
	/**
	 * ������Ϣ�ӿ�
	 */
	public String getparameterinfo()
	{	
		String info="�޲���";			
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
		for(int i = 0 ; i < data.length ; i ++)
		{
			y[i] = sumxi[i] / sumx;
		}
		return y;
	}

	@Override
	public double[] get_PLR() {
		// TODO Auto-generated method stub
		return F(data);
	}

}
