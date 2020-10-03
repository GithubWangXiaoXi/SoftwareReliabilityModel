package model.faultDetect.boost;


import java.util.LinkedList;

public interface BasicBoost
{
    public void inputdata(double[][] x_trainP, int[] y_trainP, double[][] x_testP, int[] y_testP, String[] featureSel, String label);  //获取原生数据
    public int[] getoutdata(double thresholdT);  //通过概率，预测测试数据集
    public int[] getoutdata();  //通过规则预测测试数据集
    public double getCorrectRate();  //预测准确率
    public void calculate();
    public void setHeight(int heightP);  //设置树的高度
    public void setShrehold(double thresholdP);  //设置阈值
    public void setTIMES(int timesP);  //设置迭代次数
    public int getTIMES();
}
