package model.faultDetect.boost;


import java.util.LinkedList;

public interface BasicBoost
{
    public void inputdata(double[][] x_trainP, int[] y_trainP, double[][] x_testP, int[] y_testP, String[] featureSel, String label);  //��ȡԭ������
    public int[] getoutdata(double thresholdT);  //ͨ�����ʣ�Ԥ��������ݼ�
    public int[] getoutdata();  //ͨ������Ԥ��������ݼ�
    public double getCorrectRate();  //Ԥ��׼ȷ��
    public void calculate();
    public void setHeight(int heightP);  //�������ĸ߶�
    public void setShrehold(double thresholdP);  //������ֵ
    public void setTIMES(int timesP);  //���õ�������
    public int getTIMES();
}
