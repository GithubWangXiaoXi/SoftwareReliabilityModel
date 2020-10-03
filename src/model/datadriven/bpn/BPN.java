package model.datadriven.bpn;

import modelinterface.FunctionMiningModel;;

public class BPN implements FunctionMiningModel
{
	private double[][] data;	//�ع��������
	private double[] result;		//�ع����Ӧ���ݵĽ��
	private double[] outdata;		//Ԥ������
	private int m;					//�ع�ά��
	private int n;					//��������
	private double learningCoefficient;//ѧϰϵ��
	private int trips;				//ѵ������
	private double threshold;		//Mspe��ֵ
	private double data_min; 		//��������С����
	private double width;			//�������
	private String process;
	private HiddenNode[] hiddenNode;//�����м�㣨���ز㣩�ڵ�
	private ExportNode exportNode;	//���������ڵ�
	private double max(double a[])//���������ֵ
	{
		double maxt=a[0];
		for(int i=1;i<a.length;i++)
		{
			if(a[i]>maxt) maxt=a[i];
		}
		return maxt;
	}
	private double max(double a[][], double[] b)//��������Сֵ
	{
		double maxt=b[0];
		for(int i=1;i<b.length;i++)
		{
			if(b[i]>maxt) maxt=b[i];
		}
		for(int i=0;i<a.length;i++)
		{
			for(int j=0;j<a[0].length;j++)
			{
				if(a[i][j]>maxt) maxt=a[i][j];
			}
		}
		return maxt;
	}
	
	private double min(double a[])//��������Сֵ
	{
		double mint=a[0];
		for(int i=1;i<a.length;i++)
		{
			if(a[i]<mint) mint=a[i];
		}
		return mint;
	}
	private double min(double a[][], double[] b)//��������Сֵ
	{
		double mint=b[0];
		for(int i=1;i<b.length;i++)
		{
			if(b[i]<mint) mint=b[i];
		}
		for(int i=0;i<a.length;i++)
		{
			for(int j=0;j<a[0].length;j++)
			{
				if(a[i][j]<mint) mint=a[i][j];
			}
		}
		return mint;
	}
	
	private double changedataForward(double x)//�����ݱ��0��1֮��
	{
		return (x-data_min)/width;
	}
	private double changedataBackward(double x)//�����ݴ�0��1�ָ�
	{
		double y = x*width+data_min;
		if(Double.isNaN(y)) y=0;
		return y;
	}
	private double MSE(double x[])//��Mspeֵ
	{
		double num=0,s;
		for(int i=0;i<n;i++)
		{
			s=(result[i]-x[i]);
			num+=s*s;
		}
		return Math.sqrt(num)/n;
	}
	private double calculateNet(double x[])//����������Ԫ�����������磬��������ֵ
	{
		double y[]=new double[2*m+1];
		for(int i=0;i<2*m+1;i++)
		{
			y[i]=hiddenNode[i].calculate(x);
		}
		return exportNode.calculate(y);
	}
	private void train()	
	{
		hiddenNode=new HiddenNode[2*m+1];  //��ʼ�����ز�ڵ�
		for(int i=0;i<hiddenNode.length;i++)
		{
			hiddenNode[i]=new HiddenNode(m);
		}
		exportNode=new ExportNode(2*m+1);  //��ʼ�������ڵ�
		for(int i=0;i<n;i++)
		{
			for(int j=0;j<m;j++)
			{
				this.data[i][j]=changedataForward(this.data[i][j]);
			}
			result[i]=changedataForward(result[i]);
		}
		int count=0;
		double res_prediction[]=new double[n];
		while(count<trips)  //ѵ��ѭ��
		{
			count++;
			for(int i=0;i<n;i++)
			{
				res_prediction[i]=calculateNet(data[i]); //���ÿ��������������ļ�������������res_prediction����
			}
			if(MSE(res_prediction)<=threshold) break; //���Ԥ��ֵ��ʵ��ֵ��MspeֵС�ڹ涨����ֵ����ֹͣѵ��
			double hiddenvalue[]=new double[2*m+1];	//�����ݴ��м�����ֵ
			double pc_yc[]=new double[2*m+1];	//���ڴ洢�м������ֵ
			double pc_sc;						//���ڴ洢���������ֵ
			for(int i=0;i<n;i++)		//�޸�Ȩֵ����
			{
				for(int j=0;j<2*m+1;j++)	//����һ������
				{
					hiddenvalue[j]=hiddenNode[j].calculate(data[i]);
					hiddenNode[j].setoutdata(hiddenvalue[j]);
				}
				exportNode.setoutdata(exportNode.calculate(hiddenvalue));
				pc_sc=exportNode.getoutdata()*(1-exportNode.getoutdata())*(result[i]-exportNode.getoutdata());//������������ 
				for(int j=0;j<m*2+1;j++)					//����Ȩֵ
				{
					pc_yc[j]=hiddenNode[j].getoutdata()*(1-hiddenNode[j].getoutdata())*pc_sc*exportNode.getw(j);
					hiddenNode[j].adjustw(learningCoefficient*pc_yc[j],data[i]);	//�����м���Ȩֵ
				}
				exportNode.adjustw(learningCoefficient*pc_sc,hiddenNode);	//����������Ȩֵ
			}
		}
		double[] w;
		process = "ѵ��������" + count + "\n\n���ֵ��"+MSE(res_prediction)+"\n\n���ز�Ȩֵ��";
		for(int i=0;i<hiddenNode.length;i++)
		{
			w=hiddenNode[i].getw();
			process += "���ز�"+(i+1)+"��";
			for(int j=0;j<w.length;j++)
			{
				process += w[j] + " ";
			}
			process += "\n";
		}
		process += "\n�����Ȩֵ��";
		w=exportNode.getw();
		for(int i=0;i<w.length;i++)
		{
			process += w[i] + " ";
		}
	}
	public void inputdata(double data[],double[] parameter)//����ӿ�
	{
		learningCoefficient=parameter[0];
		trips=(int)parameter[2];
		threshold=parameter[3];
		data_min=min(data);				//����������Сֵ
		width=max(data)-data_min;			//�����������
		if(width==0) width=1;
		Reconstruction reconstruction=new Reconstruction(data,(int)parameter[1]);	//��ռ��ع������������Լ��ع�ά��
		m=reconstruction.getm();		//����mֵ
		n=reconstruction.getn();		//����nֵ
		this.data=new double[n][m];
		result=new double[n];
		this.data=reconstruction.getInput();//�����ع�������ݾ���
		result=reconstruction.getRes();		//�����������ֵ
		train();//��ʼѵ��
	}
	public void inputdata2(double data[][], double[] result, double[] parameter)
	{
		learningCoefficient=parameter[0];
		trips=(int)parameter[2];
		threshold=parameter[3];
		data_min=min(data, result);				//����������Сֵ
		width=max(data,result)-data_min;			//�����������
		if(width==0) width=1;
		m = data[0].length;
		n = data.length;
		this.data = data.clone();
		this.result = result.clone();
		train();//��ʼѵ��
	}
	
	public double[] getoutdata(int step)//����ӿ�
	{
		outdata=new double[step];//��ʼ������
		double x[]=new double[m];
		for(int i=0;i<m;i++)
		{
			x[i]=result[n-m+i];
		}
		for(int i=0;i<step;i++)//���Ԥ�⣬�ѽ������outdata������
		{
			double a=calculateNet(x);
			outdata[i]=changedataBackward(a);
			for(int j=0;j<m-1;j++)
			{
				x[j]=x[j+1];
			}
			x[m-1]=a;
		}
		return outdata.clone();
	}
	
	public double[] getoutdata2(int step, double[][] data)
	{
		for(int i=0;i<data.length;i++)
		{
			for(int j=0;j<data[i].length;j++)
			{
				data[i][j] = changedataForward(data[i][j]);
			}
		}
		outdata=new double[step];//��ʼ������
		for(int i=0;i<step;i++)
		{
			outdata[i] = changedataBackward(calculateNet(data[i]));
		}
		return outdata.clone();
	}
	public String getprocess()
	{
		return process;
	}
	public String getparameterinfo()
	{
		String info="";
		info=info+"ѧϰϵ����"+String.valueOf(learningCoefficient)
				+"�� �ع�ά����"+String.valueOf(m)
				+"�� ѵ��������"+String.valueOf(trips)
				+"�� ��ֵ��"+String.valueOf(threshold)+"��";
		return info;
	}
	public double[] getfitness()
	{
		double[] x;
		double[] outdata=new double[0];
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//�������ָ�ʽ
		outdata=new double[data.length+m];
		for(int i=0;i<m;i++)
		{
			outdata[i] = 0.001;
		}
		for(int i=0;i<data.length;i++)
		{
			x = data[i].clone();
			double a = calculateNet(x);
			outdata[i+m] = Double.parseDouble(df.format(changedataBackward(a)));
		}
		return outdata.clone();
	}
	public double[] getfitness2()
	{
		double[] x;
		double[] outdata=new double[0];
		java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//�������ָ�ʽ
		outdata=new double[data.length];
		for(int i=0;i<data.length;i++)
		{
			x = data[i].clone();
			double a = calculateNet(x);
			outdata[i] = Double.parseDouble(df.format(changedataBackward(a)));
		}
		return outdata.clone();
	}
}