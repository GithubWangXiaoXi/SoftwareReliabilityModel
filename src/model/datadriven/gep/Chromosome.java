package model.datadriven.gep;

class Chromosome {
	public Gene[] gene;
	private double fitness;

	public void creatChromosome() {
		gene = new Gene[Function.Gene_number];
		for (int i = 0; i < gene.length; i++) {
			gene[i] = new Gene();
			gene[i].creatGene();
		}
	}

	public String printChromosome() {
		String string = " Îó²îÖµ = " + fitness + "\n";
		for (int i = 0; i < gene.length; i++) {
			string += gene[i].printGene();
		}
		return string;
	}

	public double calculateChromosome(double[] variable) {
		double num = 0;
		for (int i = 0; i < gene.length; i++) {
			num += gene[i].calculateGene(variable);
		}
		return num;
	}

	public void copyChromosome(Chromosome x) {
		gene = new Gene[x.gene.length];
		for (int i = 0; i < gene.length; i++) {
			gene[i] = new Gene();
			gene[i].expression = x.gene[i].expression.clone();
		}
		fitness = x.fitness;
	}

	public void setfitness(double fitness) {
		this.fitness = fitness;
	}

	public double getfitness() {
		return fitness;
	}

	public void mutation() {
		for (int i = 0; i < gene.length; i++) {
			for (int j = 0; j < 2 * Function.Head_length + 1; j++) {
				if (Math.random() < Function.Mutation_rate) {
					gene[i].mutationGene(j);
				}
			}
		}
	}

	public void IS_transposition() {
		for (int i = 0; i < gene.length; i++) {
			if (Math.random() < Function.IS_Transposition_rate) {
				int n1 = Function.random(2 * Function.Head_length + 1);
				int n2 = Function.random(2 * Function.Head_length + 1 - n1)
						+ n1;
				int n3 = Function.random(Function.Head_length - 1);
				int[] IS = new int[Function.Head_length - 1];
				int n = n2 - n1 + 1;
				if (n >= Function.Head_length)
					n = Function.Head_length - 1;
				for (int j = 0; j < n; j++) {
					IS[j] = gene[i].expression[n1 + j];
				}
				for (int j = 0; j < Function.Head_length - 1; j++) {
					if (Function.Head_length - 1 - j + n < Function.Head_length
							&& Function.Head_length - 1 - j >= n3 + 1)
						gene[i].expression[Function.Head_length - 1 - j + n] = gene[i].expression[Function.Head_length
								- 1 - j];
				}
				for (int j = 0; j < n; j++) {
					gene[i].expression[n3 + 1 + j] = IS[j];
					if (n3 + 1 + j >= Function.Head_length - 1)
						break;
				}
			}
		}
	}

	public void RIS_transposition() {
		for (int i = 0; i < gene.length; i++) {
			if (Math.random() < Function.RIS_Transposition_rate) {
				int n1 = Function.random(Function.Head_length);
				while (gene[i].expression[n1] > 9
						&& n1 < 2 * Function.Head_length)
					n1++;
				if (n1 < Function.Head_length) {
					int n2 = Function.random(Function.Head_length) + 1;
					int[] RIS = new int[Function.Head_length];
					for (int j = 0; j < n2; j++) {
						RIS[j] = gene[i].expression[n1 + j];
					}
					for (int j = 0; j < n1; j++) {
						if (n1 - 1 - j + n2 < Function.Head_length)
							gene[i].expression[n1 - 1 - j + n2] = gene[i].expression[n1
									- 1 - j];
					}
					for (int j = 0; j < n2; j++) {
						gene[i].expression[j] = RIS[j];
					}
				}
			}
		}
	}

	public void One_point_recombination(Chromosome x) {
		if (Math.random() < Function.One_point_Recombination_rate) {
			int n1 = Function.random((2 * Function.Head_length + 1)
					* gene.length);
			int i = n1 / (2 * Function.Head_length + 1), j = n1
					% (2 * Function.Head_length + 1);
			while (true) {
				gene[i].expression[j] = x.gene[i].expression[j];
				j = (j + 1) % (2 * Function.Head_length + 1);
				if (j == 0)
					i++;
				if (i >= gene.length)
					break;
			}
		}
	}

	public void Two_point_recombination(Chromosome x) {
		if (Math.random() < Function.Two_point_Recombination_rate) {
			int n1 = Function.random((2 * Function.Head_length + 1)
					* gene.length);
			int n2 = Function.random((2 * Function.Head_length + 1)
					* gene.length - n1)
					+ n1;
			int i = n1 / (2 * Function.Head_length + 1), j = n1
					% (2 * Function.Head_length + 1);
			for (int k = 0; k < n2 - n1 + 1; k++) {
				gene[i].expression[j] = x.gene[i].expression[j];
				j = (j + 1) % (2 * Function.Head_length + 1);
				if (j == 0)
					i++;
			}
		}
	}

	public void Gene_recombination(Gene x) {
		if (Math.random() < Function.Gene_Recombination_rate) {
			gene[Function.random(gene.length)].copyGene(x);
		}
	}
}
