package model.mix.emd;

import java.util.ArrayList;

import java.util.LinkedList;

import modelinterface.MixModel;


public class EMD implements MixModel
{
	private boolean isMonotone = false; //ԭʼ�����Ƿ��ǵ�������
	private double [] y;   //��������
	private double[][] outdata;   //������

	private  int NUM;     //�������ݵĸ���
	private double x[] ;  //������ [1 - �������ݳ���]
	private double zero ;  //�㷨�� ��ֵ ��С
 
	private LinkedList<Coefficient> m_CoeList;	 //ϵ�� 
	private int maxLoops;	 //�㷨��������������и���  
	//Ԥ������ݵ������� 
	//����ԭʼy[]
	private	 double yy[];
	
	//����ֵ�ĺᡢ������
	private  double maxX[];
	private  double maxY[];
	
	//��Сֵ�ĺᡢ������
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
	
		//����ֵ�ĺᡢ������
		this.maxX  = new double[NUM/2+1];
		this.maxY  = new double[NUM/2+1];
	
		//��Сֵ�ĺᡢ������
		this.minX  = new double[NUM/2+2];
		this.minY  = new double[NUM/2+2];
		this.MaxSize =0;
		this.MinSize =0;
	 
	}

//��ֵ
private void FindPeak(){

	StringBuffer ss = new StringBuffer();
 
	for(int i=0; i<NUM; i++)
	{
		ss.append(y[i] +" \r\n");
	}
 

	int num = 1;
	//�󼫴�ֵ
	for(int i = 0; i<NUM - 2; i++)
	{
		if((y[i+1]>y[i] + 0.000001) &&(y[i+1]>y[i+2] + 0.000001))
		{
			maxX[num] = x[i+1];
			maxY[num] = y[i+1];
			num++;
		}
	}

	//ȷ����������ߵĶ˵�ֵ
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
	//��Сֵ
	for(int i = 0; i<NUM  -2; i++)
	{
		if((y[i+1]<y[i] + 0.000001) &&(y[i+1]<y[i+2] + 0.000001))
		{
			minX[num] = x[i+1];
			minY[num] = y[i+1];
			num++;
		}

	}

	//ȷ����С�����ߵĶ˵�ֵ
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

//��ֵ���X��Y���꣬�ͼ�ֵ��ĸ���,
private void CalcuCoe(double arrayX[], double arrayY[], int size, boolean flag, double splineY[]){

	m_CoeList.clear();
	double hx[] = new double[size -1];
	double dy[] = new double[size -1];

	for(int i = 0; i<size - 1 ; i++)
	{
		hx[i] = arrayX[i+1] - arrayX[i];//���dX //h[i]
		dy[i] = (arrayY[i+1] - arrayY[i])/hx[i] ;//���Fi
	}

	//����LAMDAi��Ui��Ci(i: 1-n-1);
	if( size <= 2)
	{
		isMonotone = true;     //ԭʼ����Ϊ�����������У� ֱ�ӷ���
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


	//׷�Ϸ�������
	size -=2;
	double M[] = new double[size+2];//�洢size ��Mi�����׵�����
	double p[]=  new double[size];
	double q[]=  new double[size];
 
	double aii = 2;
	double t = 0.0;
	  
	p[0] = m_CoeList.get(0).c/aii;
	q[0] = m_CoeList.get(0).u/aii;

	//׷����
	for(int index = 1;index < m_CoeList.size(); index++)
	{
		   Coefficient co = new Coefficient();
		   co = m_CoeList.get(index);
		   t = aii - co.lamda*q[index -1];

		   p[index] = (co.c - co.lamda*p[index -1])/ t;
		   q[index] =  co.u / t;
	}

	//�ϣ��ش�
	// M[size - 1] = p[size -1];
	 M[size - 1] = M[0] =0;
	 for(int index = size; index >=1; index--)
	 {
		M[index] = p[index-1]-q[index-1]*M[index+1]; 	//�ó����еö��׵�
	 }

	//�����ϵ�����ֵ
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

//����IMF����ģ̬����������
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
		//���°����ߵ�һ��
		average[i] = (splineMaxY[i]+splineMinY[i])/2;

	}
 
	int zeroNum = CalZeroPeakNum(y);

	for(int i = 0; i<average.length; i++)
	{
		if(Math.abs(average[i]) > zero  )//ƽ��������Ϊ 0 ��>10��zero
		{ 
			return false;
		}
	}

	//��ֵ��ĸ��������ĸ���������1
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
   
//�㷨����
private void runEMD()
{
	Initial();	  
	boolean flag = false;
	boolean maxLoopsFlag = false;   //�㷨�����������и��� �Ƿ��Ѵﵽ��� ����
 
	//���ڴ�����е� imf������ ����һ����ʣ�����
	ArrayList<ArrayList<Double>> als = new  ArrayList<ArrayList<Double>>();
	
	//���ڴ��ʣ����� 
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
		//��ϼ���Сֵ
		double splineMaxY[] = new double[NUM];
		double splineMinY[] = new double[NUM];
		
	 	FindPeak();		 	
		CalcuCoe(maxX, maxY, MaxSize,true,splineMaxY);

		if(isMonotone)
		{
			return;     //ԭʼ����Ϊ�������ݣ��򷵻�
		}
		
		CalcuCoe(minX, minY, MinSize,false,splineMinY);	
 		 
		double average[] = new double[NUM];
		 
		for(int i = 0; i<NUM; i++)
		{
			//���°����ߵ�һ��
			average[i] = (splineMaxY[i]+splineMinY[i])/2;

			//����h(t) = x(t)-(maxspline + minspline)/2
			y[i] -= average[i];
			 	 
		}
		
		//����ƽ�������ߵ�������
	//	int zeroNum = CalZeroPeakNum(y);
		
		//����IMF����������  		
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
		// �㷨�����ķ��������Ѵ�����޶�����������ʣ���
		if(als.size() == maxLoops - 1 )  
		{
			maxLoopsFlag = true;
			break;
		}
			
	}while(!flag);
		
		for(int i =0; i<NUM; i++)
		{
			y[i] = yy[i] - y[i];//r(t) = x(t) - imf(t) ��Ϊ����������
		}		
		
		for(int i =0; i<NUM; i++)
		{
			yy[i] = y[i];	//��¼��ǰ����������		
		}
		
		//�˴� al ��ŵ��� ��ȥ��һ��IMF ������ ʣ�����
		alRest.clear();
		for(int i = 0; i<yy.length; i++)
		{
			alRest.add(yy[i]);			 
		}	
		  
		FindPeak();
		
		//�㷨�����������и����Ѵ� �������ֵ
		if(maxLoopsFlag)
		{
			break;
		}
		
	}while((MinSize + MinSize)>4);//�ж�����rnshifou wei ������������		
 
	//��als �е� imf���� ��ʣ����� ��ֵ��  outdata �� 
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
	
	//��this.zeroֵ�������������е����ֵ����ȡ�������ݵģ���Сֵ+���ֵ��/2
	double minMum = y[0];
	double maxMum = y[0];
	for(int i = 1; i < y.length; i++)
	{
		minMum = Math.min(minMum, y[i]);
		maxMum = Math.max(maxMum, y[i]);
	}
	
	//��ֵ���� ���ֵ
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
	
	//����EMD
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