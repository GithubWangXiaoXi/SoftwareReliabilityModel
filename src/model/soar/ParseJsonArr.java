package model.soar;

import java.util.ArrayList;
import java.util.List;
import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;

public class ParseJsonArr {
	public double[][] execParse(String json){
		
		JSONArray list=JSONArray.fromObject(json);
		List<List<String>> mlList=JSONArray.toList(list,new ArrayList<String>(),new JsonConfig());
		int row=mlList.size();
		int col=mlList.get(0).size();
		double[][] data=new double[row][col];
		for(int i=0;i<row;i++) {
			for(int j=0;j<col-1;j++) {
				data[i][j]=Double.parseDouble(mlList.get(i).get(j+1));
			}
			data[i][col-1]=data[i][0]+data[i][1];
		}
		//Utils.printMatrix(data);
		return data;
	}
	
	public double[][] execParse2(String json){
		
		JSONArray list=JSONArray.fromObject(json);
		List<List<String>> mlList=JSONArray.toList(list,new ArrayList<String>(),new JsonConfig());
		int row=mlList.size();
		int col=mlList.get(0).size()-3;
		double[][] data=new double[row][col];
		for(int i=0;i<row;i++) {
			for(int j=0;j<col;j++) {
				data[i][j]=Double.parseDouble(mlList.get(i).get(j+3));
			}
			//data[i][col-1]=data[i][0]+data[i][1];
		}
		// Utils.printMatrix(data);
		return data;
	}
	public double[] execParse3(String json){
		
		JSONArray list=JSONArray.fromObject(json);
		List<List<String>> mlList=JSONArray.toList(list,new ArrayList<String>(),new JsonConfig());
		int row=mlList.size();
		//int col=mlList.get(0).size()-3;
		double[] data=new double[row];
		for(int i=0;i<row;i++) {
			data[i]=Double.parseDouble(mlList.get(i).get(2));
			//data[i][col-1]=data[i][0]+data[i][1];
		}
		// Utils.printMatrix(data);
		return data;
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ParseJsonArr parseJsonArr=new ParseJsonArr();
		String json="[[\"1\",\"1\",\"4\"],[\"2\",\"2\",\"5\"],[\"3\",\"3\",\"6\"]]";
		parseJsonArr.execParse(json);
		String  json2="[[\"1\",\"1\",\"0\",\"0\",\"0.69\",\"0.31\",\"0\",\"0\",\"0\"],[\"2\",\"2\",\"0\",\"0\",\"0\",\"0\",\"1\",\"0\",\"0\"],[\"3\",\"3\",\"0\",\"0\",\"0\",\"0\",\"1\",\"0\",\"0\"],[\"4\",\"4\",\"0\",\"0.78\",\"0\",\"0\",\"0\",\"0.22\",\"0\"],[\"5\",\"5\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"1\"],[\"6\",\"6\",\"0\",\"1\",\"0\",\"0\",\"0\",\"0\",\"0\"]]";
		parseJsonArr.execParse2(json2);
		parseJsonArr.execParse3(json2);
	}

}
