package system;

import java.sql.SQLException;
import java.util.ArrayList;

public class InputData
{
	private double[][] data_train;
	private double[][] data_test;
	private int dimension;
	private String dataname;
	private String[] colname;
	private String datainfo;
	private int testpercentage;
	public void setdata(double[][] data,String dataname,String[] colname,int testpercentage,String datainfo)
	{
		this.testpercentage = testpercentage;
		this.dataname = dataname;
		this.colname = colname.clone();
		this.datainfo = datainfo;
		dimension=data.length;
		//System.out.println("dimension="+dimension);
		int length_test = (data[0].length*testpercentage/100);
		int length_train = data[0].length-length_test;
		data_train = new double[dimension][length_train];
		data_test = new double[dimension][length_test];

		for(int i=0; i<dimension; i++)
		{
			for(int j=0; j<length_train; j++)
			{
				data_train[i][j]=data[i][j];
			}
			for(int j=0,k=length_train;j<length_test;j++,k++)
			{
				data_test[i][j]=data[i][k];
			}
		}
	}
	public void init() throws SQLException {
		ReadTable rt=new ReadTable();
		ArrayList<DataSet> list=rt.getDataSet(1);
		DataSet curds=list.get(list.size()-1);
		this.setdata(curds.getData(),		//鐢ㄥ閫夋暟鎹泦涓殑鎸囧畾鏁版嵁鏇挎崲鎺夊綋鍓嶆暟鎹�
		 			curds.getSetname(),
		 			curds.getColname(),
		  			curds.getPercent(),
					curds.getSetinfo());
	}
	
	public double[] getdata_train(int i)
	{
		return data_train[i-1];
	}
	public double[] getdata_test(int i)
	{
		return data_test[i-1];
	}
	public int getlength_train()
	{
		return data_train[0].length;
	}
	public int getlength_test()
	{
		return data_test[0].length;
	}
	public int getdimension()
	{
		return dimension;
	}
	public int gettestpercentage()
	{
		return testpercentage;
	}
	public String getdataname()
	{
		return dataname;
	}
	public String getcolname(int i)
	{
		return colname[i-1];
	}
	public String getdatainfo()
	{
		return datainfo;
	}
}
