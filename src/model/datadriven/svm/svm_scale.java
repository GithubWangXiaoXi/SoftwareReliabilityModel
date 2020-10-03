package model.datadriven.svm;

class svm_scale
{ 
	private double y_lower = -1;  //��񻯵�����
	private  double y_upper = 1;	 //��񻯵�����
	
	private double y_max = -Double.MAX_VALUE;   
	private double y_min = Double.MAX_VALUE;    
	private double[] scaled;  //��񻯺������
	
	//������ݵ������Сֵ
	private void calcuMaxMin(double[] y)
	{		
		y_min = 1.0;
		y_max = y.length * 1.0;		
	}
 
	public double[] scale(final double[] y)
	{    
		 //@1 ��ȡ���ݵ���ֵ
  		 calcuMaxMin(y);
  		 
  		 //@2 �淶��
		 int len = y.length;
		 scaled = new double[len];
		 for(int i = 0; i < len; i++)
		 {  
			 scaled[i] = y_lower + (y_upper-y_lower) * ((i+1)-y_min) / (y_max-y_min);
		 }
		
		return scaled.clone();
	} 
	
	
}
