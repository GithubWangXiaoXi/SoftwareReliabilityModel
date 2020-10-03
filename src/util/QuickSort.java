package util;

/**
 * �ο� https://blog.csdn.net/weixin_30363263/article/details/82462088
 */
public class QuickSort {

    //�Ӵ�С����
    public static void reverseQuickSort(double[] L, int[] indexArr) {
        Qsort(L,0,L.length-1,indexArr);
    }

    public static void Qsort(double[] L,int low,int high,int[] indexArr) {
        int pivot;
        if(low<high) {
            //��L[low,high]һ��Ϊ��,�������ֵpivot,��ֵ��λ�ù̶�,�����ٱ仯
            pivot = partition(L,low,high,indexArr);

            //�����ߵ�����ֱ�����
            Qsort(L,low,pivot-1,indexArr);
            Qsort(L,pivot+1,high,indexArr);
        }
    }

    //  ѡ��һ������ֵ(�ؼ���) �����ŵ�ĳ��λ�� ʹ����ߵ�ֵ������С �ұߵ�ֵ��������
    public static int partition(double[] L,int low,int high,int[] indexArr) {
        double pivotkey;
        pivotkey =L[low];
        //˳�����Ҫ��Ҫ�ȴ��ұ���
        while(low<high) {
            while(low < high && L[high] <= pivotkey) {  //�Ӻ���ǰ�ҵ���key��ķŵ�ǰ��ȥ
                high--;
            }
            swap(L,low,high);
            swap1(indexArr,low,high);
            while(low < high && L[low] >= pivotkey) {  //��ǰ�����ҵ���keyС�ķŵ�����ȥ
                low++;
            }
            swap(L,low,high);
            swap1(indexArr,low,high);
        } //�������м�¼  low��λ�ü�Ϊ key����λ��, �ҹ̶�,�����ٸı�
        return low;
    }

    //����double���������λ��
    public static void swap(double[] L,int i,int j) {
        double temp=L[i];
        L[i]=L[j];
        L[j]=temp;
    }

    //����double���������λ��
    public static void swap1(int[] L,int i,int j) {
        int temp=L[i];
        L[i]=L[j];
        L[j]=temp;
    }
}
