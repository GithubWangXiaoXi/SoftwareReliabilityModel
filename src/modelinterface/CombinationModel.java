package modelinterface;

public interface CombinationModel
{
	public void inputdata(double data[],int step,String[] modelselect,double[][] parameter);//ÊäÈë½Ó¿Ú
	public double[] getoutdata();
	public double[][] getpredictdata();
	public double[][] getfitnessdata();
	public double[] getfitnessdata_combination();
	public String getprocess();
	public String getparameterinfo();
}