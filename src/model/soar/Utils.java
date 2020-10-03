package model.soar;

import java.io.IOException;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class Utils {
	private static final ObjectMapper JACKSON_MAPPER = new ObjectMapper();
	private static List<List<String>> Blist=null;
	public static double[][] matrixMultiplication(double[][] a,double[][] b){
		double[][] c=new double[a.length][b[0].length];
		
		for (int i = 0; i < c.length; i++)
			for (int j = 0; j < c[0].length; j++)
				for (int k = 0; k < a[0].length; k++)
					c[i][j] += a[i][k] * b[k][j];
		
		return c;
	}
	public static double getRound(double a) {
		return (double)Math.round(a*1000)/1000;
	}
	public static double[] getFinalStatus(double[][] a,double[][] b) {
		Blist=new ArrayList<>();
		for(int i=0;i<200;i++){
			if(i%10==0) {
				getBigArr(a[0]);
			}
			a=	matrixMultiplication(a, b);	
		}
		for(int j=0;j<a[0].length;j++) {
			a[0][j]=getRound(a[0][j]);
		}
		return a[0];
	}
	public static void getBigArr(double[] arr) {
		
		List<String> list2=new ArrayList<>();
		for(double d:arr) {
			list2.add(getRound(d)+"");
		}
		Blist.add(list2);
		
	}
	public static String getArrJson() {
		return convertObjectToString(Blist);
	}
	public static double[][] transferMartix(double[][] arr){
		double[][] res=new double[arr[0].length][arr.length];
		for (int i = 0; i < res.length; i++) {
			for (int j = 0; j < res[i].length; j++) {
				res[i][j] = arr[j][i];
			}
		}
		return res;
	}
	public static String reverseParse(double[][] arr) {
		
		List<List<String>> list=new ArrayList<>();
		for(int i=0;i<arr.length;i++) {
			List<String> innerList=new ArrayList<>();
			for(int j=0;j<arr[i].length;j++) {
				innerList.add(arr[i][j]+"");
			}
			list.add(innerList);
		}
		return convertObjectToString(list);
	}
	public static String convertObjectToString(Object obj) {

        StringWriter w = new StringWriter();

        String jsonValue = null;

        try {

            JACKSON_MAPPER.writeValue(w, obj);

            jsonValue = w.toString();

        } catch (JsonParseException e) {

            // 异常时，记录日志，不中断程序

            e.printStackTrace();

        } catch (JsonMappingException e) {

            // 异常时，记录日志，不中断程序

            e.printStackTrace();

        } catch (IOException e) {

            // 异常时，记录日志，不中断程序

            e.printStackTrace();

        }

        return jsonValue;

    }

	public static void main(String[] args) {
		
			
		double[][] a= {{0.391,0.101,0.090,0.291,0.064,0.063}};
		//double[][] a= {{0.31,0.58,0.11}};
		/*double[][] b= {
				{0.65,0.35,0},
				{0,0.67,0.33},
				{0.48,0,0.52}
		};*/
		double[][] b={
				{0,0.69,0.31,0,0,0},
				{0,0,0,1,0,0},
				{0,0,0,1,0,0},
				{0.78,0,0,0,0.22,0},
				{0,0,0,0,0,1},
				{1,0,0,0,0,0}
		};
		double[] res=getFinalStatus(a, b);
		printMatrix(res);
		System.out.println(getArrJson());
		
		
	}
	public static void printMatrix(double[][] a) {
		for(double[] row:a) {
			for(double col:row) {
				System.out.print(getRound(col)+" ");
			}
			System.out.println();
		}
		System.out.println();

	}
	public static void printMatrix(double[] a) {
		for(double row:a) {
				System.out.print(row+" ");
		}
		System.out.println();

	}
}
