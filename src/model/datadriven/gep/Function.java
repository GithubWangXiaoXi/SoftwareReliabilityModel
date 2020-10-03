package model.datadriven.gep;

class Function {
	public static int Head_length;
	public static int m;
	public static int Gene_number;
	public static int Population_size;
	public static double Mutation_rate;
	public static double IS_Transposition_rate;
	public static double RIS_Transposition_rate;
	public static double One_point_Recombination_rate;
	public static double Two_point_Recombination_rate;
	public static double Gene_Recombination_rate;
	public static int trips;
	public static double threshold;
	public static Stack stack = new Stack();

	public static int random(int n) {
		java.text.DecimalFormat df = new java.text.DecimalFormat("#.000");
		double rand;
		rand = 1000 * Double.parseDouble(df.format(Math.random())); // 将预测数据保留两位小数
		return (int) rand % n;
	}
}

class Stack {
	public double[] data_value;
	public int[] data_type;
	private int count;

	public void Init(int Head_length) {
		count = 0;
		data_value = new double[2 * Head_length + 1];
		data_type = new int[2 * Head_length + 1];
	}

	public void push(int type, double value) {
		data_value[count] = value;
		data_type[count] = type;
		count++;
	}

	public double pop() {
		count--;
		return data_value[count];
	}

	public int put_type1() {
		if (count == 0)
			return 0;
		else
			return data_type[count - 1];
	}

	public int put_type2() {
		if (count <= 1)
			return 0;
		else
			return data_type[count - 2];
	}

	int getcount() {
		return count;
	}
}
