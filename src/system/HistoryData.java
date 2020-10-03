package system;

public class HistoryData
{
	private int size=10;
	private int current;
	private int next;
	private int number;
	private double[][][] data=new double[size][][];
	private String[] dataname=new String[size];
	private String[][] colname=new String[size][];
	private String[] datainfo=new String[size];
	private String[] date=new String[size];
	
	public void entry(double data[][],String dataname,String[] colname,String datainfo)
	{
		this.data[next] = data.clone();
		this.dataname[next] = dataname;
		this.colname[next] = colname.clone();
		this.datainfo[next] = datainfo;
		java.text.SimpleDateFormat formatter=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		java.util.Date currentTime=new java.util.Date();//得到当前系统时间 
		this.date[next]=formatter.format(currentTime); //将日期时间格式化
		this.current = next + 1;
		next = (next+1)%size;
		if(number < size) number++;
	}
	public void init()
	{
		next=0;
		number=0;
	}
	public double[][] getdata(int i)
	{
		return data[i];
	}
	public String getdataname(int i)
	{
		return dataname[i];
	}
	public String[] getcolname(int i)
	{
		return colname[i];
	}
	public String getdatainfo(int i)
	{
		return datainfo[i];
	}
	public String getdate(int i)
	{
		return date[i];
	}
	public int getnumber()
	{
		return number;
	}
	public void setcurrent(int i)
	{
		current = i;
	}
	public int getcurrent()
	{
		return current;
	}
}
