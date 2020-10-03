package model.datadriven.gep;

import modelinterface.FunctionMiningModel;

public class GEP implements FunctionMiningModel {
	private double[][] data;
	private double[] result;
	private int count;
	private Chromosome[] chromosome;
	private Chromosome chromosome_best = new Chromosome();

	private void creatPopulation() {
		for (int i = 0; i < chromosome.length; i++) {
			chromosome[i] = new Chromosome();
			chromosome[i].creatChromosome();
		}
		chromosome_best.creatChromosome();
		chromosome_best.setfitness(100000);
	}

	private double MSE(double x[])// 求Mspe值
	{
		double num = 0, s;
		for (int i = 0; i < result.length; i++) {
			s = (result[i] - x[i]);
			num += s * s;
		}
		return Math.sqrt(num) / result.length;
	}

	private double calculatefitness(int i) {
		double[] r_r = new double[result.length];
		for (int j = 0; j < data.length; j++) {
			r_r[j] = chromosome[i].calculateChromosome(data[j]);
		}
		chromosome[i].setfitness(MSE(r_r));
		return chromosome[i].getfitness();
	}

	private double calculatefitness(Chromosome x) {
		double[] r_r = new double[result.length];
		for (int j = 0; j < data.length; j++) {
			r_r[j] = x.calculateChromosome(data[j]);
		}
		return MSE(r_r);
	}

	private void variation() {
		for (int i = 0; i < chromosome.length; i++) {
			Chromosome x = new Chromosome();
			x.copyChromosome(chromosome[i]);
			for (int j = 0; j <= 5; j++) {
				switch (j) {
				case 0: {
					x.mutation();
					break;
				}
				case 1: {
					x.IS_transposition();
					break;
				}
				case 2: {
					x.RIS_transposition();
					break;
				}
				case 3: {
					x.One_point_recombination(chromosome[Function
							.random(Function.Population_size)]);
					break;
				}
				case 4: {
					x.Two_point_recombination(chromosome[Function
							.random(Function.Population_size)]);
					break;
				}
				case 5: {
					x.Gene_recombination(chromosome[Function
							.random(Function.Population_size)].gene[Function
							.random(Function.Gene_number)]);
					break;
				}
				}
				x.setfitness(calculatefitness(x));
				if (i >= chromosome.length - 5
						|| x.getfitness() < chromosome[i].getfitness())
					chromosome[i].copyChromosome(x);
			}
		}
	}

	private void train() {
		count = 1;
		while (count < Function.trips
				&& chromosome_best.getfitness() > Function.threshold) {
			for (int i = 1; i <= 5; i++) {
				chromosome[chromosome.length - i]
						.copyChromosome(chromosome_best);
			}
			variation();
			double best_fitness = calculatefitness(0);
			int best_subscript = 0;
			for (int i = 1; i < chromosome.length; i++) {
				double f = calculatefitness(i);
				if (f <= best_fitness) {
					best_subscript = i;
					best_fitness = f;
				}
			}
			chromosome_best.copyChromosome(chromosome[best_subscript]);
			count++;
		}
	}

	public void printChromosome_best() {
		System.out.print("最优：");
		chromosome_best.printChromosome();
	}

	public void inputdata(double[] data, double[] parameter) {
		Function.Population_size = (int) parameter[0];
		Function.m = (int) parameter[1];
		Function.Head_length = (int) parameter[2];
		Function.Gene_number = (int) parameter[3];
		Function.Mutation_rate = parameter[4];
		Function.IS_Transposition_rate = parameter[5];
		Function.RIS_Transposition_rate = parameter[6];
		Function.One_point_Recombination_rate = parameter[7];
		Function.Two_point_Recombination_rate = parameter[8];
		Function.Gene_Recombination_rate = parameter[9];
		Function.trips = (int) parameter[10];
		Function.threshold = parameter[11];

		Reconstruction reconstruction = new Reconstruction(data, Function.m); // 相空间重构，传入序列以及重构维数
		int n = reconstruction.getn(); // 返回n值
		this.data = new double[n][Function.m];
		this.data = reconstruction.getInput();
		result = reconstruction.getRes();
		chromosome = new Chromosome[Function.Population_size];
		creatPopulation();
		train();
	}

	public double[] getoutdata(int step)// 输出接口
	{
		double[] outdata = new double[step];// 初始化数据
		double x[] = new double[Function.m];
		for (int i = 0; i < Function.m; i++) {
			x[i] = result[data.length - Function.m + i];
		}
		for (int i = 0; i < step; i++)// 向后预测，把结果存入outdata数组中
		{
			double a = chromosome_best.calculateChromosome(x);
			outdata[i] = a;
			for (int j = 0; j < Function.m - 1; j++) {
				x[j] = x[j + 1];
			}
			x[Function.m - 1] = a;
		}
		return outdata;
	}

	public double[] getfitness() {
		double[] x;
		double[] outdata = new double[data.length + Function.m];
		for (int i = 0; i < Function.m; i++) {
			outdata[i] = 0.001;
		}
		java.text.DecimalFormat df = new java.text.DecimalFormat("#.00"); // 定义数字格式
		for (int i = 0; i < data.length; i++) {
			x = data[i].clone();
			double a = chromosome_best.calculateChromosome(x);
			outdata[i + Function.m] = Double.parseDouble(df.format(a));
		}
		return outdata.clone();
	}

	public String getparameterinfo() {
		String info = "";
		info = info + "种群大小：" + String.valueOf(Function.Population_size)
				+ "； 重构维数：" + String.valueOf(Function.m) + "； 基因头部长度："
				+ String.valueOf(Function.Head_length) + "； 基因数量："
				+ String.valueOf(Function.Gene_number) + "； 变异概率："
				+ String.valueOf(Function.Mutation_rate) + "； IS迁移概率："
				+ String.valueOf(Function.IS_Transposition_rate) + "； RIS迁移概率："
				+ String.valueOf(Function.RIS_Transposition_rate) + "； 单点重组概率："
				+ String.valueOf(Function.One_point_Recombination_rate)
				+ "； 双点重组概率："
				+ String.valueOf(Function.Two_point_Recombination_rate)
				+ "； 基因重组概率："
				+ String.valueOf(Function.Gene_Recombination_rate) + "； 训练代数："
				+ String.valueOf(Function.trips) + "； 阈值："
				+ String.valueOf(Function.threshold);
		return info;
	}

	public String getprocess() {
		String string = "训练代数：" + count + "\n\n";
		for (int i = 0; i < chromosome.length; i++) {
			string += "第" + (i + 1) + "条染色体：" + chromosome[i].printChromosome()
					+ "\n";
		}
		string += "最优染色体：" + chromosome_best.printChromosome();
		return string;
	}

	public void inputdata2(double data[][], double[] result, double[] parameter) {
		Function.Population_size = (int) parameter[0];
		Function.m = data[0].length;
		Function.Head_length = (int) parameter[2];
		Function.Gene_number = (int) parameter[3];
		Function.Mutation_rate = parameter[4];
		Function.IS_Transposition_rate = parameter[5];
		Function.RIS_Transposition_rate = parameter[6];
		Function.One_point_Recombination_rate = parameter[7];
		Function.Two_point_Recombination_rate = parameter[8];
		Function.Gene_Recombination_rate = parameter[9];
		Function.trips = (int) parameter[10];
		Function.threshold = parameter[11];

		this.data = data.clone();
		this.result = result.clone();
		chromosome = new Chromosome[Function.Population_size];
		creatPopulation();
		train();
	}

	public double[] getoutdata2(int step, double[][] data) {
		double[] outdata = new double[step];// 初始化数据
		for (int i = 0; i < step; i++) {
			outdata[i] = chromosome_best.calculateChromosome(data[i]);
		}
		return outdata.clone();
	}

	public double[] getfitness2() {
		double[] x;
		double[] outdata = new double[0];
		java.text.DecimalFormat df = new java.text.DecimalFormat("#.00"); // 定义数字格式
		outdata = new double[data.length];
		for (int i = 0; i < data.length; i++) {
			x = data[i].clone();
			double a = chromosome_best.calculateChromosome(x);
			outdata[i] = Double.parseDouble(df.format(a));
		}
		return outdata.clone();
	}
}