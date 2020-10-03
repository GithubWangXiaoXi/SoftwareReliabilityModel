package util;

public class InputDataChange {

    /**
     * 原来的inputData的行数 = 维数，列数 = 样本个数
     * 该函数的目的是将inputData转置，即行数 = 样本个数，列数 = 维数
     * @param inputDataT
     */
    public static double[][] MatrixTranspose(double[][] inputDataT){
        int row = inputDataT.length;
        int col = inputDataT[0].length;

        double[][] inputData = new double[col][row];

        for (int i = 0; i < row; i++) {
            for (int j = 0; j < col; j++) {
                inputData[j][i] = inputDataT[i][j];
            }
        }

        return inputData;
    }
}
