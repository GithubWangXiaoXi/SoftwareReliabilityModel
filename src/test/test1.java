package test;

import modelinterface.ClassicModel;

public class test1 implements ClassicModel{
	public void inputdata(double data[],double[] parameter){
		
	}
	public double[] getoutdata(int step){
		
		double y[] =  new double[1];
		return y;
	}
	public double[] getfitness(){
		double y[] =  new double[1];
		return y;
		
	}
	public String getprocess(){
		String y =null;
		return y;
		
	}
	public String getparameterinfo(){
		String y =null;
		return y;
	}
	
	/**
	 * 获得U图纵轴数组
	 */

	public double[] get_ugraph() {
		// TODO Auto-generated method stub
 	double u[] =  new double[1];
		return u;
	}

	/**
	 * 获得Y图纵轴数组
	 */

	public double[] get_ygraph() {
		// TODO Auto-generated method stub
		double y[] =  new double[1];
		return y;
	}

	@Override
	public double[] get_PLR() {
		double y[] =  new double[1];
		return y;
	}
}
