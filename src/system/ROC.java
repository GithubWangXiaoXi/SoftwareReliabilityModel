package system;

import java.text.DecimalFormat;

public class ROC {

    private int TP = 0; //Ԥ����Ϊ���࣬Ԥ����ȷ��
    private int FP = 0; //Ԥ����Ϊ���࣬Ԥ�����
    private int FN = 0;  //Ԥ����Ϊ���࣬Ԥ�����
    private int TN = 0;  //Ԥ����Ϊ���࣬Ԥ����ȷ

    private double TPR;  //������ (TP / (TP + FN))
    private double FPR;  //1-�����  (FP / (FP + TN))

    private int []y_real;
    private int []y_predict;

    public ROC(int []y_realT,int []y_predictT){
        this.y_real = y_realT;
        this.y_predict = y_predictT;
        calculate();
    }

    public void calculate(){
        for (int i = 0; i < y_real.length; i++) {
            if(y_predict[i] == 1){
                if(y_real[i] == 1){
                    TP++;
                }else{
                    FP++;
                }
            }else{
                if(y_real[i] == 1){
                    FN++;
                }else{
                    TN++;
                }
            }
        }

        DecimalFormat dF = new DecimalFormat("0.00000");
        TPR = Double.parseDouble(dF.format((float)TP / (TP + FN)));
        FPR = Double.parseDouble(dF.format((float)FP / (FP + TN)));
    }

    public int getTP() {
        return TP;
    }

    public int getFP() {
        return FP;
    }

    public int getFN() {
        return FN;
    }

    public int getTN() {
        return TN;
    }

    public double getTPR() {
        return TPR;
    }

    public double getFPR() {
        return FPR;
    }
}
