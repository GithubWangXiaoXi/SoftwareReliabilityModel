package system;

import java.text.DecimalFormat;

public class ROC {

    private int TP = 0; //预测结果为正类，预测正确。
    private int FP = 0; //预测结果为正类，预测错误
    private int FN = 0;  //预测结果为负类，预测错误
    private int TN = 0;  //预测结果为负类，预测正确

    private double TPR;  //灵敏度 (TP / (TP + FN))
    private double FPR;  //1-特异度  (FP / (FP + TN))

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
