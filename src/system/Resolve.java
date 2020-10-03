package system;

public class Resolve
{
	private double[][] data;
	private String[] select;
	private double[] SSA_SinglePercent;
	public void setdata(double[][] data)
	{
		this.data = new double[data.length][data[0].length];
		for(int i=0;i<data.length;i++)
		{
			for(int j=0;j<data[0].length;j++)
			{
				this.data[i][j]=data[i][j];
			}
		}
	}
	public void setselect(String[] select)
	{
		this.select = select.clone();
	}
	public double[][] getdata()
	{
		double[][] d = data.clone();
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//定义数字格式
		for(int i=0;i<d.length;i++)
		{
			for(int j=0;j<d[0].length;j++)
			d[i][j] = Double.parseDouble(df.format(data[i][j]));
		}
		return d.clone();
	}
	
	public void combination(String model)
	{
		int s=data.length-select.length+1;
		double[][] resolvedata = new double[s][];
		double[] resolve_SSA_SinglePercent = new double[s];
		double[] num_data = new double[data[0].length];
		double num_SSA_SinglePercent = 0;
		for(int i=0,j=0;i<data.length;i++)
		{
			if(Integer.parseInt(select[j])==i+1)
			{
				for(int k=0;k<num_data.length;k++)
				{
					num_data[k]+=data[i][k];
				}
				if(model.equals("SSA")) num_SSA_SinglePercent += SSA_SinglePercent[i];
				if(j<select.length-1) j++;
			}
		}
		for(int i=0;i<(Integer.parseInt(select[0])-1);i++)
		{
			resolvedata[i] = data[i].clone();
			if(model.equals("SSA")) resolve_SSA_SinglePercent[i] = SSA_SinglePercent[i];
		}
		resolvedata[Integer.parseInt(select[0])-1] = num_data.clone();
		if(model.equals("SSA")) 
		{
			resolve_SSA_SinglePercent[Integer.parseInt(select[0])-1] = num_SSA_SinglePercent;
		}
		for(int i=Integer.parseInt(select[0]),j=i,k=1; i<data.length; i++)
		{
			if(Integer.parseInt(select[k])==i+1)
			{
				if(k<select.length-1) k++;
			}
			else
			{
				resolvedata[j] = data[i].clone();
				if(model.equals("SSA")) resolve_SSA_SinglePercent[j] = SSA_SinglePercent[i];
				j++;
			}
		}
		data = resolvedata.clone();
		if(model.equals("SSA")) SSA_SinglePercent = resolve_SSA_SinglePercent.clone();
	}
	public void setSinglePercent(double[] SinglePercent)
	{
		SSA_SinglePercent = SinglePercent.clone();
	}
	public double[] getSinglePercent()
	{
		double[] sp = SSA_SinglePercent.clone();
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.0000");	//定义数字格式
		for(int i=0;i<sp.length;i++)
		{
			sp[i] = Double.parseDouble(df.format(sp[i]));
		}
		return sp.clone();
	}
}

