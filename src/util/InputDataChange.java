package util;

public class InputDataChange {

    /**
     * ԭ����inputData������ = ά�������� = ��������
     * �ú�����Ŀ���ǽ�inputDataת�ã������� = �������������� = ά��
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
