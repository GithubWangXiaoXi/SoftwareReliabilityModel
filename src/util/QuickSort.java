package util;

/**
 * 参考 https://blog.csdn.net/weixin_30363263/article/details/82462088
 */
public class QuickSort {

    //从大到小排序
    public static void reverseQuickSort(double[] L, int[] indexArr) {
        Qsort(L,0,L.length-1,indexArr);
    }

    public static void Qsort(double[] L,int low,int high,int[] indexArr) {
        int pivot;
        if(low<high) {
            //将L[low,high]一分为二,算出枢轴值pivot,该值得位置固定,不用再变化
            pivot = partition(L,low,high,indexArr);

            //对两边的数组分别排序
            Qsort(L,low,pivot-1,indexArr);
            Qsort(L,pivot+1,high,indexArr);
        }
    }

    //  选择一个枢轴值(关键字) 把它放到某个位置 使其左边的值都比它小 右边的值都比它大
    public static int partition(double[] L,int low,int high,int[] indexArr) {
        double pivotkey;
        pivotkey =L[low];
        //顺序很重要，要先从右边找
        while(low<high) {
            while(low < high && L[high] <= pivotkey) {  //从后往前找到比key大的放到前面去
                high--;
            }
            swap(L,low,high);
            swap1(indexArr,low,high);
            while(low < high && L[low] >= pivotkey) {  //从前往后找到比key小的放到后面去
                low++;
            }
            swap(L,low,high);
            swap1(indexArr,low,high);
        } //遍历所有记录  low的位置即为 key所在位置, 且固定,不用再改变
        return low;
    }

    //交换double数组的两个位置
    public static void swap(double[] L,int i,int j) {
        double temp=L[i];
        L[i]=L[j];
        L[j]=temp;
    }

    //交换double数组的两个位置
    public static void swap1(int[] L,int i,int j) {
        int temp=L[i];
        L[i]=L[j];
        L[j]=temp;
    }
}
