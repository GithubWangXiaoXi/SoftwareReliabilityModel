package model.mix.emd;

import java.util.ArrayList;

import java.util.LinkedList;

import modelinterface.MixModel;


public class EMD implements MixModel
{
	private boolean isMonotone = false; //原始数据是否是单调数据
	private double [] y;   //输入数据
	private double[][] outdata;   //输出结果

	private  int NUM;     //输入数据的个数
	private double x[] ;  //横坐标 [1 - 输入数据长度]
	private double zero ;  //算法中 零值 大小
 
	private LinkedList<Coefficient> m_CoeList;	 //系数 
	private int maxLoops;	 //算法产生的最大子序列个数  
	//预拟合数据的纵坐标 
	//拷贝原始y[]
	private	 double yy[];
	
	//极大值的横、纵坐标
	private  double maxX[];
	private  double maxY[];
	
	//极小值的横、纵坐标
	private  double minX[];
	private  double minY[];
	private  int MaxSize;
	private  int MinSize;
  
	
	private void initialX(){

	this.x = new double[NUM];
	
	for(int i=0; i<NUM; i++)
	{
		x[i] = i;
	}
	
	return;
}

	private void Initial()
	{
		initialX();
		this.yy = new double[NUM];
	
		//极大值的横、纵坐标
		this.maxX  = new double[NUM/2+1];
		this.maxY  = new double[NUM/2+1];
	
		//极小值的横、纵坐标
		this.minX  = new double[NUM/2+2];
		this.minY  = new double[NUM/2+2];
		this.MaxSize =0;
		this.MinSize =0;
	 
	}

//求极值
private void FindPeak(){

	StringBuffer ss = new StringBuffer();
 
	for(int i=0; i<NUM; i++)
	{
		ss.append(y[i] +" \r\n");
	}
 

	int num = 1;
	//求极大值
	for(int i = 0; i<NUM - 2; i++)
	{
		if((y[i+1]>y[i] + 0.000001) &&(y[i+1]>y[i+2] + 0.000001))
		{
			maxX[num] = x[i+1];
			maxY[num] = y[i+1];
			num++;
		}
	}

	//确定极大包络线的端点值
	maxX[0] = x[0];
	if(y[0]>0)
	{
		maxY[0] = y[0];
	}else
	{
		maxY[0] = maxY[1];
	}

	maxX[num] = x[NUM - 1];
	if(y[NUM - 1]>0)
	{
		maxY[num] = y[NUM - 1];
	}else
	{
		maxY[num] = maxY[num-1];
	}

	StringBuffer sb = new StringBuffer();
	for(int index = 0;index <= num; index++ )
	{
		sb.append(maxX[index] + "  " + maxY[index] + "\r\n" );
	}
	//PrintFile("F:\\javaPro\\spline\\max"+(counter)+".txt", sb.toString());
	sb.delete(0, sb.length());
	MaxSize = num +1;



	num = 1;
	//求极小值
	for(int i = 0; i<NUM  -2; i++)
	{
		if((y[i+1]<y[i] + 0.000001) &&(y[i+1]<y[i+2] + 0.000001))
		{
			minX[num] = x[i+1];
			minY[num] = y[i+1];
			num++;
		}

	}

	//确定极小包络线的端点值
	minX[0] = x[0];
	if(y[0]<0)
	{
		minY[0]  = y[0];
	}else
	{
		minY[0] = minY[1];
	}

	minX[num] = x[NUM - 1];

	if(y[NUM - 1]<0)
	{
		minY[num] = y[NUM - 1];
	}else
	{
		minY[num] = minY[num-1];
	}



	//minY[num] = minY[num-1]-0.01;
	MinSize = num +1;
	for(int index = 0;index <= num; index++ )
	{
		sb.append(minX[index] + "  " + minY[index] + "\r\n" );
	}
 
	sb.delete(0, sb.length());

}

//极值点的X、Y坐标，和极值点的个数,
private void CalcuCoe(double arrayX[], double arrayY[], int size, boolean flag, double splineY[]){

	m_CoeList.clear();
	double hx[] = new double[size -1];
	double dy[] = new double[size -1];

	for(int i = 0; i<size - 1 ; i++)
	{
		hx[i] = arrayX[i+1] - arrayX[i];//求出dX //h[i]
		dy[i] = (arrayY[i+1] - arrayY[i])/hx[i] ;//求出Fi
	}

	//计算LAMDAi，Ui，Ci(i: 1-n-1);
	if( size <= 2)
	{
		isMonotone = true;     //原始数据为单掉数据序列， 直接返回
		return;
	}
	
	
	for(int i = 0; i<size - 2; i++)
	{
		Coefficient coe = new Coefficient();
		coe.lamda = hx[i]/(hx[i+1] +hx[i]);
		coe.u = 1 - coe.lamda;
		coe.c = 6*(dy[i+1] - dy[i])/(hx[i+1] + hx[i]);
		m_CoeList.add(coe);
	}


	//追赶法求解矩阵
	size -=2;
	double M[] = new double[size+2];//存储size 个Mi（二阶倒数）
	double p[]=  new double[size];
	double q[]=  new double[size];
 
	double aii = 2;
	double t = 0.0;
	  
	p[0] = m_CoeList.get(0).c/aii;
	q[0] = m_CoeList.get(0).u/aii;

	//追过程
	for(int index = 1;index < m_CoeList.size(); index++)
	{
		   Coefficient co = new Coefficient();
		   co = m_CoeList.get(index);
		   t = aii - co.lamda*q[index -1];

		   p[index] = (co.c - co.lamda*p[index -1])/ t;
		   q[index] =  co.u / t;
	}

	//赶，回代
	// M[size - 1] = p[size -1];
	 M[size - 1] = M[0] =0;
	 for(int index = size; index >=1; index--)
	 {
		M[index] = p[index-1]-q[index-1]*M[index+1]; 	//得出所有得二阶导
	 }

	//输出拟合的曲线值
	 double y = 0.0;
	// StringBuffer sb = new StringBuffer();

	int kk = 0;
	for(int index = 0 ; index< M.length-1; index++)
	{
		for(double st = arrayX[index]; st<=arrayX[index+1]; st+=1)
		{
			if(st == arrayX[index]&& index>0)
			{
				 continue;
			}
			//sb.append("x " + st + " ");
			double l1 = -((M[index])*Math.pow((st - arrayX[index+1]),3)/(6*hx[index]));
			double l2 = M[index +1] *Math.pow((st - arrayX[index]),3)/(6*hx[index]);
			double l3 = -((arrayY[index]-M[index]*Math.pow(hx[index],2)/6))*((st - arrayX[index+1])/hx[index]);
			double l4 =  ((arrayY[index+1])-(M[index+1])*Math.pow(hx[index], 2)/6)*(st-arrayX[index])/hx[index];

			y = l1 +l2 + l3+l4;
			splineY[kk++] = y;
			//sb.append(y + "\r\n");
		}
  
	}
 

	return;
}

//满足IMF本征模态函数个条件
private boolean IsIMF2( )
{ 
	FindPeak();
	double splineMaxY[] = new double[NUM];
	double splineMinY[] = new double[NUM];
	CalcuCoe(maxX, maxY, MaxSize,true,splineMaxY);
	CalcuCoe(minX, minY, MinSize,false,splineMinY);

	double average[] = new double[NUM];
	for(int i = 0; i<NUM; i++)
	{
		//上下包络线的一半
		average[i] = (splineMaxY[i]+splineMinY[i])/2;

	}
 
	int zeroNum = CalZeroPeakNum(y);

	for(int i = 0; i<average.length; i++)
	{
		if(Math.abs(average[i]) > zero  )//平均包络线为 0 （>10）zero
		{ 
			return false;
		}
	}

	//极值点的个数和零点的个数相差不超过1
	if(Math.abs( zeroNum- (MinSize + MaxSize -4)) <=1)
	{ 
		return true;
	}
 
	return false;
}

private int CalZeroPeakNum(double array[])
{
	int num = 0;
	for(int i = 0; i<array.length; i++)
	{
		if(i>=1 &&(array [i]*array[i-1])<0.0)
		{
			num++;
		}

		if(i ==1 && i == array.length-1 &&Math.abs( array[i]) <1e-2)
		{
			num++;
			continue;
		}
	}

	return num;
}
   
//算法运行
private void runEMD()
{
	Initial();	  
	boolean flag = false;
	boolean maxLoopsFlag = false;   //算法产生的子序列个数 是否已达到最大 限制
 
	//用于存放所有的 imf分量和 仅有一个的剩余分量
	ArrayList<ArrayList<Double>> als = new  ArrayList<ArrayList<Double>>();
	
	//用于存放剩余分量 
	ArrayList<Double> alRest = new ArrayList<Double>();
	
	 for(int i =0; i<NUM; i++)
	{
		yy[i] = y[i];		
	}  
	  
	do{					
		if(flag)
		{
			for(int i =0; i<NUM; i++)
			{
				y[i] = yy[i];		
			}								
		}
		
		flag = false;	
		
		do{
		//拟合极大、小值
		double splineMaxY[] = new double[NUM];
		double splineMinY[] = new double[NUM];
		
	 	FindPeak();		 	
		CalcuCoe(maxX, maxY, MaxSize,true,splineMaxY);

		if(isMonotone)
		{
			return;     //原始数据为单调数据，则返回
		}
		
		CalcuCoe(minX, minY, MinSize,false,splineMinY);	
 		 
		double average[] = new double[NUM];
		 
		for(int i = 0; i<NUM; i++)
		{
			//上下包络线的一半
			average[i] = (splineMaxY[i]+splineMinY[i])/2;

			//计算h(t) = x(t)-(maxspline + minspline)/2
			y[i] -= average[i];
			 	 
		}
		
		//计算平均包络线的零点个数
	//	int zeroNum = CalZeroPeakNum(y);
		
		//满足IMF的两个条件  		
		if(IsIMF2())
		{ 
			ArrayList<Double> al = new ArrayList<Double>();
			for(int i = 0; i<y.length; i++)
			{
				al.add(y[i]); 
			}				
			als.add(al);
			flag = true;	 
		}				 
		// 算法产生的分量个数已达最大限定个数，将把剩余的
		if(als.size() == maxLoops - 1 )  
		{
			maxLoopsFlag = true;
			break;
		}
			
	}while(!flag);
		
		for(int i =0; i<NUM; i++)
		{
			y[i] = yy[i] - y[i];//r(t) = x(t) - imf(t) 作为新数据序列
		}		
		
		for(int i =0; i<NUM; i++)
		{
			yy[i] = y[i];	//记录当前的数据序列		
		}
		
		//此处 al 存放的是 减去上一个IMF 分量的 剩余分量
		alRest.clear();
		for(int i = 0; i<yy.length; i++)
		{
			alRest.add(yy[i]);			 
		}	
		  
		FindPeak();
		
		//算法产生的子序列个数已达 最大限制值
		if(maxLoopsFlag)
		{
			break;
		}
		
	}while((MinSize + MinSize)>4);//判断余项rnshifou wei 单调数据序列		
 
	//将als 中的 imf分量 和剩余分量 赋值到  outdata 中 
	als.add(alRest);
	int row = als.size();
	int col = als.get(0).size();
	
	outdata = new double[row][col];
	for(int i = 0; i < row; i++)
	{
		 ArrayList<Double> al = als.get(i);
		 for(int j = 0; j < col; j++)
		 {
			 outdata[i][j] = al.get(j);
		 }		 
	}	
 }	
	 

@Override
public void inputdata(double[] data, double[] parameter) {

	this.zero = parameter[0];
	this.maxLoops = (int) (parameter[1] + 0.1);
	this.y = data.clone();
	
	//若this.zero值大于输入数据中的最大值，则取输入数据的（最小值+最大值）/2
	double minMum = y[0];
	double maxMum = y[0];
	for(int i = 1; i < y.length; i++)
	{
		minMum = Math.min(minMum, y[i]);
		maxMum = Math.max(maxMum, y[i]);
	}
	
	//零值大于 最大值
	if(Double.compare(this.zero, maxMum) == 1)
	{
		this.zero = (minMum + maxMum) / 2;
	}
	
	this.NUM = y.length;
	
	initialX();	 
	m_CoeList =  new LinkedList<Coefficient>();
}


@Override
public double[][] getoutdata(){
	
	//运行EMD
	runEMD();
	int row = 0; 
	int col = 0;
	
	if(isMonotone)
	{
		row = 2;
		outdata = new double[row][this.y.length];
		outdata[0] = this.y.clone();
		 
	}else 
	{
		row =  this.outdata.length;
		col = this.outdata[0].length;
	}
	
	
	double[][] retOutdata = new double[row][col];
	  
	for(int i = 0; i < row; i++)
	{
		retOutdata[i] = this.outdata[i].clone();
	}
	
	return retOutdata;
}

}