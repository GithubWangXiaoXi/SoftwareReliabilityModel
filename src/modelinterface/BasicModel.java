package modelinterface;

public interface BasicModel
{
	public void inputdata(double data[],double[] parameter);
	public double[] getoutdata(int step);
	public double[] getfitness();
	public String getprocess();
	public String getparameterinfo();
}
