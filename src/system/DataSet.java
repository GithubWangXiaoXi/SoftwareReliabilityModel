package system;

public class DataSet {
	private String setname;
	private String setinfo;
	private int percent;	
	private int columncount;
	private double data[][];
	private String[] colname;
	public String[] getColname() {
		return colname;
	}
	public void setColname(String[] colname) {
		this.colname = colname;
	}
	public String getSetname() {
		return setname;
	}
	public void setSetname(String setname) {
		this.setname = setname;
	}
	public String getSetinfo() {
		return setinfo;
	}
	public void setSetinfo(String setinfo) {
		this.setinfo = setinfo;
	}
	public int getPercent() {
		return percent;
	}
	public void setPercent(int percent) {
		this.percent = percent;
	}
	public int getColumncount() {
		return columncount;
	}
	public void setColumncount(int columncount) {
		this.columncount = columncount;
	}
	public double[][] getData() {
		return data;
	}
	public void setData(double[][] data) {
		this.data = data;
	}
	
	
}
