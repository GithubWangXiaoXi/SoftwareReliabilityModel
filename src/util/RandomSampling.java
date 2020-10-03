package util;

import java.util.Arrays;
import java.util.Random;

public class RandomSampling {

    public static void getNum(int[] array,int size){

        int []temp = new int[size];

        Random r = new Random();
        for (int i = 0; i < array.length; i++) {

            int number = r.nextInt(size);

            while(temp[number] == 1){
                number = r.nextInt(size);
            }

            array[i] = number;
            temp[number] = 1;
        }

        Arrays.sort(array);
    }
}
