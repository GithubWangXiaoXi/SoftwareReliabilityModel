package model.combination.bcm;

import modelinterface.BasicModel;
import modelinterface.CombinationModel;
import model.classic.duane.DUANE;
import model.classic.exponential.ExponentialSRM;
import model.classic.gamma.GammaSRM;
import model.classic.go.GO;
import model.classic.jm.JM;
import model.classic.lognormal.LogNormalSRM;
import model.classic.mo.MO;
import model.classic.schneidewind.Schneidewind;
import model.classic.weibull.Weibull;
import model.datadriven.arima.ARIMA;
import model.datadriven.bpn.BPN;
import model.datadriven.gep.GEP;
import model.datadriven.gm.GM;
import model.datadriven.rbfn.RBFN;
import model.datadriven.svm.SVM;

public class BCM implements CombinationModel
{
	private double[] outdata;		//预测数据
	private String[] modelselect;	//模型选择
	private double[][] fitnessdata;	//拟合数据
	private double[] fitnessdata_combination; //组合后的拟合数据
	private double[][] predictdata;			//组合后的预测数据
	private double[][] percentage;  //百分比
	private BasicModel Factory(String model)	//对象创建工厂
	{
		if(model.equals("ARIMA")) return new ARIMA();
		if(model.equals("BPN")) return new BPN();
		if(model.equals("GEP")) return new GEP();
		if(model.equals("GM")) return new GM();
		if(model.equals("RBFN")) return new RBFN();
		if(model.equals("SVM")) return new SVM();
		if(model.equals("DUANE")) return new DUANE();
		if(model.equals("GO")) return new GO();
		if(model.equals("JM")) return new JM();
		if(model.equals("MO")) return new MO();
		if(model.equals("GammaSRM")) return new GammaSRM();
		if(model.equals("ExponentialSRM")) return new ExponentialSRM();
		if(model.equals("LogNormalSRM")) return new LogNormalSRM();
		if(model.equals("SCHNEIDEWIND")) return new Schneidewind();
		if(model.equals("WEIBULL")) return new Weibull();
		return new BPN();
	}
	public void inputdata(double data[],int step,String[] modelselect,double[][] parameter)
	{
                int e = (int ) parameter[parameter.length-1][0];
		outdata = new double[step];
		fitnessdata = new double[data.length][modelselect.length];
		fitnessdata_combination = new double[data.length];
		double[][] fitness = new double[modelselect.length][data.length];
		predictdata=new double[modelselect.length][step];
		this.modelselect=modelselect.clone();
                java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//定义数字格式
                percentage = new double[modelselect.length][data.length];
                int[] flag = new int[fitnessdata.length];
		for(int i=0;i<modelselect.length;i++)
		{
			BasicModel basicModel = Factory(modelselect[i]);
			basicModel.inputdata(data, parameter[i]);			
			predictdata[i] = basicModel.getoutdata(step).clone();
			fitness[i] = basicModel.getfitness().clone();
		}
                
                for(int i=0;i<data.length;i++)
                {
                    for(int j=0;j<modelselect.length;j++)
                    {
                        fitnessdata[i][j] = fitness[j][i];
                    }
                }
                for(int i=0; i<fitnessdata.length; i++)
		{
			flag[i] = 0;
			for(int j=0; j<fitnessdata[i].length; j++)
			{
				if(fitnessdata[i][j] == 0.001) flag[i]=1;
			}
		}
                double sum = 0;
                double value= 0;
                double[] variance = new double[modelselect.length];
                for(int m=0;m<modelselect.length;m++)
                {
                    sum=0;
                    value=0;
                    for(int i=0;i<fitnessdata.length;i++)
                    {
                        value = value + fitnessdata[i][m];
                    }
                    value = value / fitnessdata.length;

                    for(int i=0;i<fitnessdata.length;i++)
                    {
                        sum = sum + Math.pow(fitnessdata[i][m]-value, 2);
                    }
                    variance[m] = sum / fitnessdata.length;

                }
                double a = 0;
                double b = 0;
                double c = 0;
                for(int i=0;i<modelselect.length;i++)
                {
                    percentage[i][0]=(double)1/modelselect.length;//初始权重
                }
                for(int i=0;i<modelselect.length;i++)
                {
                    if(flag[0]==1)
                    {
                        fitnessdata_combination[0]=0.001;
                    }
                    else
                    {
                        fitnessdata_combination[0] = fitnessdata_combination[0] + fitnessdata[i][0]*percentage[i][0];
                        fitnessdata_combination[0] = Double.parseDouble(df.format(fitnessdata_combination[0]));
                    }
                }
                
                if(e==1)
                {
                    for(int j=1;j<data.length;j++)
                    {
                        for(int i=0;i<modelselect.length;i++)
                        {
                            a = (double)1/(Math.sqrt(2*Math.PI*variance[i]*variance[i]))*percentage[i][j-1]*Math.pow(Math.E, -((data[j]-fitnessdata[j][i])/variance[i])*((data[j]-fitnessdata[j][i])/variance[i]));
                            b = b + a;
                        }
                        for(int i=0;i<modelselect.length;i++)
                        {
                            a = (double)1/(Math.sqrt(2*Math.PI*variance[i]*variance[i]))*percentage[i][j-1]*Math.pow(Math.E, -((data[j]-fitnessdata[j][i])/variance[i])*((data[j]-fitnessdata[j][i])/variance[i]));
                            percentage[i][j] = (double)a / b;
                            if(percentage[i][j]<0.0001)
                            {
                                percentage[i][j]=0.9*percentage[i][j-1]+0.1*percentage[i][0];
                            }

                            c = c + percentage[i][j];
                        }
                        for(int i=0;i<modelselect.length;i++)
                        {
                            percentage[i][j] = percentage[i][j]/c;
                            if(flag[j]==1)
                            {
                                fitnessdata_combination[j]=0.001;
                            }
                            else
                            {
                                fitnessdata_combination[j] = fitnessdata_combination[j] + fitnessdata[j][i]*percentage[i][j];
                                fitnessdata_combination[j] = Double.parseDouble(df.format(fitnessdata_combination[j]));
                            }
                        }
                        a=0;
                        b=0;
                        c=0;
                    }
                    for(int i=0;i<outdata.length;i++)
                    {
                        for(int j=0;j<modelselect.length;j++)
                        {
                            outdata[i] = outdata[i] + predictdata[j][i]*percentage[j][data.length-1];
                        }
                        outdata[i] = Double.parseDouble(df.format(outdata[i]));
                    }
                }
                if(e==2)
                {
                    int s =5;
                    if(data.length<=s)
                    {
                        for(int j=1;j<data.length;j++)
                        {
                            for(int i=0;i<modelselect.length;i++)
                            {   
                                a = (double)1/(Math.sqrt(2*Math.PI*variance[i]*variance[i]))*percentage[i][j-1]*Math.pow(Math.E, -((data[j]-fitnessdata[j][i])/variance[i])*((data[j]-fitnessdata[j][i])/variance[i]));
                                b = b + a;
                            }
                            for(int i=0;i<modelselect.length;i++)
                            {
                                a = (double)1/(Math.sqrt(2*Math.PI*variance[i]*variance[i]))*percentage[i][j-1]*Math.pow(Math.E, -((data[j]-fitnessdata[j][i])/variance[i])*((data[j]-fitnessdata[j][i])/variance[i]));
                                percentage[i][j] = (double)a / b;
                                if(percentage[i][j]<0.0001)
                                {
                                    percentage[i][j]=0.9*percentage[i][j-1]+0.1*percentage[i][0];
                                }
                                c = c + percentage[i][j];
                            }
                            for(int i=0;i<modelselect.length;i++)
                            {
                                percentage[i][j] = percentage[i][j]/c;
                                if(flag[j]==1){fitnessdata_combination[j]=0.001;}
                                else
                                {
                                    fitnessdata_combination[j] = fitnessdata_combination[j] + fitnessdata[j][i]*percentage[i][j];
                                    fitnessdata_combination[j] = Double.parseDouble(df.format(fitnessdata_combination[j]));
                                }
                            } 
                            
                            a=0;
                            b=0;
                            c=0;
                        }
                        for(int i=0;i<outdata.length;i++)
                        {
                            for(int j=0;j<modelselect.length;j++)
                            {
                                outdata[i] = outdata[i] + predictdata[j][i]*percentage[j][data.length-1];
                            }
                        }
                    }
                    else
                    {
                        for(int i=0;i<modelselect.length;i++)
                        {
                            percentage[i][data.length-s]=(double)1/modelselect.length;
                        }
                        for(int j=0;j<data.length-s+1;j++)
                        {
                            for(int i=0;i<modelselect.length;i++)
                            {
                                if(flag[j]==1){fitnessdata_combination[j]=0.001;}
                                else
                                {
                                    fitnessdata_combination[j] = fitnessdata_combination[j] + fitnessdata[j][i]*percentage[i][data.length-s];
                                    fitnessdata_combination[j] = Double.parseDouble(df.format(fitnessdata_combination[j]));
                                }
                            }
                            
                        }
                    for(int j=data.length-s+1;j<data.length;j++)
                    {
                        for(int i=0;i<modelselect.length;i++)
                        {
                            a = (double)1/(Math.sqrt(2*Math.PI*variance[i]*variance[i]))*percentage[i][j-1]*Math.pow(Math.E, -((data[j]-fitnessdata[j][i])/variance[i])*((data[j]-fitnessdata[j][i])/variance[i]));
                            b = b + a;
                        }
                        for(int i=0;i<modelselect.length;i++)
                        {
                            a = (double)1/(Math.sqrt(2*Math.PI*variance[i]*variance[i]))*percentage[i][j-1]*Math.pow(Math.E, -((data[j]-fitnessdata[j][i])/variance[i])*((data[j]-fitnessdata[j][i])/variance[i]));
                            percentage[i][j] = (double)a / b;
                            if(percentage[i][j]<0.0001)
                            {
                                percentage[i][j]=0.9*percentage[i][j-1]+0.1*percentage[i][0];
                            }
                            c = c + percentage[i][j];
                        }
                        for(int i=0;i<modelselect.length;i++)
                        {
                            percentage[i][j] = percentage[i][j]/c;
                            if(flag[j]==1){fitnessdata_combination[j]=0.001;}
                            else
                            {
                                fitnessdata_combination[j] = fitnessdata_combination[j] + fitnessdata[j][i]*percentage[i][j];
                                fitnessdata_combination[j] = Double.parseDouble(df.format(fitnessdata_combination[j]));
                            }
                        }
                        a=0;
                        b=0;
                        c=0;
                    }
                    for(int i=0;i<outdata.length;i++)
                    {
                        for(int j=0;j<modelselect.length;j++)
                        {
                            outdata[i] = outdata[i] + predictdata[j][i]*percentage[j][data.length-1];
                        }
                    }
                 }
                    
             }
	}
	public double[] getoutdata()
	{
		return outdata.clone();
	}
	public double[][] getpredictdata()
	{
		return predictdata.clone();
	}
	public double[][] getfitnessdata()
	{
		return fitnessdata.clone();
	}
	public double[] getfitnessdata_combination()
	{
		return fitnessdata_combination.clone();
	}
	public String getparameterinfo()
	{
		String info="";
		for(int i=1;i<=modelselect.length;i++)
		{
			info = info+i+"??"+modelselect[i-1]+"?? ";
		}
		return info;
	}
	public String getprocess()
	{
		double[] p = new double[modelselect.length];
                for(int i=0;i<modelselect.length;i++)
                {
                    p[i]=percentage[i][fitnessdata.length-1]*100;
                }
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");
		
		String process = "";
		for(int i=1;i<=modelselect.length;i++)
		{
                    p[i-1] = Double.parseDouble(df.format(p[i-1]));
			process = process + "模型" + i + "：" + modelselect[i-1] 
					+ "   " + p[i-1] + "%" + "\n\n";
		}
		return process;
	}
}