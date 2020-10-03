package util;

import java.text.DecimalFormat;
import java.util.LinkedList;

/**
 * �ο� https://blog.csdn.net/lz_peter/article/details/84574716
 */
public class SoftMax {

    public static double[] normalization(double score[],LinkedList<Integer> positiveList){

        double[] results = new double[positiveList.size()];

        //�����÷�����С�����5λ
        DecimalFormat dF = new DecimalFormat("0.00000");
        for (int i = 0; i < score.length; i++) {
            score[i] = Double.parseDouble(dF.format(score[i]));
        }

        double sum = getSum(score,positiveList);

        for (int i = 0; i < positiveList.size(); i++) {
            results[i] = Math.exp(score[positiveList.get(i)]) / sum;
        }
        return results;
    }

    //�����е÷����δ���ָ�����������
    public static double getSum(double score[],LinkedList<Integer> positiveList){

        double sum = 0.0;
        for (int i = 0; i < positiveList.size(); i++) {
            sum += Math.exp(score[positiveList.get(i)]);
        }
        return sum;
    }
}
