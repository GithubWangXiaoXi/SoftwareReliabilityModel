package modelinterface;

public interface FunctionMiningModel extends BasicModel
{
	public void inputdata2(double data[][], double[] result, double[] parameter);
	public double[] getoutdata2(int step, double[][] data);
	public double[] getfitness2();
}
