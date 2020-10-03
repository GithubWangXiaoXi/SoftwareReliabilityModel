package util;
import java.util.Arrays;
import java.util.Comparator;

/**
 * 参考 https://blog.csdn.net/water84222/article/details/83297184
 */
public class ArraySort {

    public static void sort(double[][] ob, final int[] order) {
        Arrays.sort(ob, new Comparator<Object>() {
            public int compare(Object o1, Object o2) {
                double[] one = (double[]) o1;
                double[] two = (double[]) o2;
                for (int i = 0; i < order.length; i++) {
                    int k = order[i];
                    if (one[k] > two[k]) {
                        return 1;
                    } else if (one[k] < two[k]) {
                        return -1;
                    } else {
                        continue;  //如果按一条件比较结果相等，就使用第二个条件进行比较。
                    }
                }
                return 0;
            }
        });
    }

    public static void main(String[] args) {
        double array[][] = new double[][] {
                { 12.0, 34, 68, 32, 9, 12, 545 },
                { 34.0, 72, 82, 57, 56, 0, 213 },
                { 12.0, 34, 68, 32, 21, 945, 23 },
                { 91.0, 10, 3, 2354, 73, 34, 18 },
                { 12.0, 83, 189, 26, 27, 98, 33 },
                { 47.0, 23, 889, 24, 899, 23, 657 },
                { 12.0, 34, 68, 343, 878, 235, 768 },
                { 12.0, 34, 98, 56, 78, 12, 546 },
                { 26.0, 78, 2365, 78, 34, 256, 873 } };
        sort(array, new int[] {0,1,3});
        for (int i = 0; i < array.length; i++) {
            for (int j = 0; j < array[i].length; j++) {
                System.out.print(array[i][j]);
                System.out.print("\t");
            }
            System.out.println();
        }
    }
}