package model.mix.wave;

import modelinterface.MixModel;

public class Wave implements MixModel
{
    private double[][] outdata;
 	public void inputdata(double ds1[], double[] ds2)
     {
         
      double l1[] = new double[ds1.length];//�����������
     double h1[][] = new double[20][ds1.length];//�����������

     int n;
         n = ds1.length;
  //   java.text.DecimalFormat df=new java.text.DecimalFormat("#.00");	//�������ָ�ʽ


     //�����m
     int m = 0;    
 for(int d=ds1.length;d>=1;d=(int) (d-Math.pow(2, m)))
 {

     int b = d;//Ϊʹdֵ���䣬����b��ͨ�������b�ݹ��������
     m = 0;
     
     for(;b/2>=1;m++)
     {
         b=(b/2);
     }
     

     double x[] = new double[ds1.length];
     double y[][] = new double[m][ds1.length];
     double l[][][] = new double[m][m+1][ds1.length];
     double h[][][] = new double[m][m+1][ds1.length];
     //��n����2��m�η���Ҳ����˵n����ĳ���Ϊ��ȡ���ʱ�����г���
     n=(int) Math.pow(2, m);     
     for(int i=0;i<n;i++)
     {
         x[i]=ds1[d-(int)Math.pow(2, m)+i];//ÿ�δ�ѭ����dֵ��Ϊ���޳����������еĳ���
     }


 if(n!=1)//�ж�ÿ��ѭ�����Ƿ�Ҫ���������ֻ��һ��Ԫ��
 {
     //�ȸ���ԭʼ��ʱ�����������һ���С���任����
     for(int i=0,j=0;i<n;i=i+2,j++)
     {
         y[0][j]= (x[i]+x[i+1])/Math.sqrt(2);
         l[0][1][i/2]=y[0][j];
     }
     for(int i=0,j=n/2;i<n;i=i+2,j++)
     {
         y[0][j]=(x[i]-x[i+1])/Math.sqrt(2);
         h[0][1][i/2]=y[0][j];
     }
     //ѭ�����ֱ��M���С���任����
     n=n/2;
     for(int i=1;i<m;i++)
     {
      
         int t=0;
         for(int j=0;j<n;j=j+2,t++)
         {
             y[i][t]=(y[i-1][j]+y[i-1][j+1])/Math.sqrt(2);
             l[i][i+1][(j/2)]=y[i][t];
         }
         
         for(int j=0;j<n;j=j+2,t++)
         {
             y[i][t]=(y[i-1][j]-y[i-1][j+1])/Math.sqrt(2);
             h[i][i+1][(j/2)]=y[i][t];
         }
         
         for(;t<(int) Math.pow(2, m);t++)
         {
             
             y[i][t]=y[i-1][t];
         }
         n=n/2;
     
     }
     //System.out.println("���С���ֽ��ĵ�Ƶ��Ƶϵ�����У� ");


     
     //�ع�
     for(int a=m-1;a>=0;a--)
     {
         int t=0;
         for(int i=a+1;i>0;i--)
         {
             
             for(int j=0;j<(int)Math.pow(2, m-i);j++)
             {
                 h[a][i-1][2*j]= h[a][i][j]/Math.sqrt(2);
                 if(t==0)
                 {
                     h[a][i-1][2*j+1]=-h[a][i-1][2*j];
                 }
                 else
                 {
                     h[a][i-1][2*j+1]=h[a][i-1][2*j];
                 }
             }
             t++;
             
         }
     }

     
     for(int i=0;i<m;i++)
     {
         for(int j=0;j<(int)Math.pow(2, m);j++)
         {                
             h1[i][d-(int)Math.pow(2, m)+j]=h[i][0][j];
         }

     }
     
    
         for(int i=m;i>0;i--)
         {
             
             for(int j=0;j<(int)Math.pow(2, m-i);j++)
             {
                 l[m-1][i-1][2*j]= l[m-1][i][j]/Math.sqrt(2);
                 l[m-1][i-1][2*j+1]=l[m-1][i-1][2*j];
             }
         }

         for(int j=0;j<(int)Math.pow(2, m);j++)
         {                
             l1[d-(int)Math.pow(2, m)+j]=l[m-1][0][j];
         }

 }
 else
 {
     l1[0]=x[0];
     ////////////
 }
     
 } //����for����  


 System.out.println();
 int nnn = ds1.length;
 int maxm = 0;
 for(;nnn/2>=1;maxm++)
 {
     nnn=(nnn/2);
 }

 outdata = new double[maxm+1][ds1.length];
 int i;
 for( i=0;i<maxm;i++)
 {
     for(int j=0;j<ds1.length;j++)
     {
         outdata[i][j] = h1[i][j];
     }
 }
 for(int j=0;j<ds1.length;j++)
 {
     outdata[i][j]=l1[j];
 }

 
 }
     
	public double[][] getoutdata()
     {
         return outdata.clone();
     }
}
