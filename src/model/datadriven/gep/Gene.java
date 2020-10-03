package model.datadriven.gep;

class Gene {
	public int[] expression;

	private double yunsuan1(double y, double x) {
		if (y == 6) {
			return Math.pow(Math.E, x);
		} else if (y == 7) {
			return Math.log(Math.abs(x));
		} else if (y == 8) {
			return Math.sqrt(Math.abs(x));
		} else if (y == 9) {
			return Math.abs(x);
		} else
			return 0;
	}

	private double yunsuan2(double y, double x1, double x2) {
		if (y == 0) {
			return x2 + x1;
		} else if (y == 1) {
			return x2 - x1;
		} else if (y == 2) {
			return x2 * x1;
		} else if (y == 3) {
			if ((x1 == 0))
				return x2;
			return x2 / x1;
		} else if (y == 4) {
			return Math.max(x1, x2);
		} else if (y == 5) {
			return Math.min(x1, x2);
		} else
			return 0;
	}

	private void adjust() {
		while (true) {
			if (Function.stack.put_type1() == 0
					&& Function.stack.put_type2() != 2
					&& Function.stack.getcount() >= 2) {
				double num1 = Function.stack.pop();
				int type;
				double value;
				if (Function.stack.put_type1() == 0) {
					double num2 = Function.stack.pop();
					value = yunsuan2(Function.stack.pop(), num1, num2);
				} else {
					value = yunsuan1(Function.stack.pop(), num1);
				}
				type = 0;
				Function.stack.push(type, value);
			} else
				break;
		}
	}

	public void copyGene(Gene x) {
		expression = x.expression.clone();
	}

	public void creatGene() {
		expression = new int[2 * Function.Head_length + 1];
		int n, rand, z;
		for (int i = 0; i < expression.length; i++) {
			if (i < Function.Head_length)
				n = 3;
			else
				n = 1;
			rand = Function.random(n);
			if (rand == 0) {
				z = Function.random(Function.m + 1);
				if (z == 0) {
					expression[i] = Function.random(10) + 10;
				} else {
					expression[i] = z + 19;
				}
			} else if (rand == 1) {
				expression[i] = Function.random(4);
			} else {
				expression[i] = Function.random(6) + 4;
			}
		}
	}

	public double calculateGene(double[] variable) {
		int type;
		double value;
		Function.stack.Init(Function.Head_length);
		for (int i = 0; i < expression.length; i++) {
			if (expression[i] <= 5) {
				type = 2;
				value = expression[i];
			} else if (expression[i] >= 6 && expression[i] <= 9) {
				type = 1;
				value = expression[i];
			} else {
				type = 0;
				if (expression[i] <= 19) {
					value = expression[i] - 10;
				} else {
					value = variable[expression[i] - 20];
				}
			}
			Function.stack.push(type, value);
			adjust();
			if (Function.stack.getcount() == 1
					&& Function.stack.put_type1() == 0)
				break;
		}
		return Function.stack.pop();
	}

	public String printGene() {
		String string = "";
		for (int i = 0; i < expression.length; i++) {
			switch (expression[i]) {
			case 0: {
				string += "+" + " ";
				break;
			}
			case 1: {
				string += "-" + " ";
				break;
			}
			case 2: {
				string += "*" + " ";
				break;
			}
			case 3: {
				string += "/" + " ";
				break;
			}
			case 4: {
				string += "Max" + " ";
				break;
			}
			case 5: {
				string += "Min" + " ";
				break;
			}
			case 6: {
				string += "Exp" + " ";
				break;
			}
			case 7: {
				string += "Ln" + " ";
				break;
			}
			case 8: {
				string += "Sqrt" + " ";
				break;
			}
			case 9: {
				string += "Abs" + " ";
				break;
			}
			case 10: {
				string += "0" + " ";
				break;
			}
			case 11: {
				string += "1" + " ";
				break;
			}
			case 12: {
				string += "2" + " ";
				break;
			}
			case 13: {
				string += "3" + " ";
				break;
			}
			case 14: {
				string += "4" + " ";
				break;
			}
			case 15: {
				string += "5" + " ";
				break;
			}
			case 16: {
				string += "6" + " ";
				break;
			}
			case 17: {
				string += "7" + " ";
				break;
			}
			case 18: {
				string += "8" + " ";
				break;
			}
			case 19: {
				string += "9" + " ";
				break;
			}
			case 20: {
				string += "X1" + " ";
				break;
			}
			case 21: {
				string += "X2" + " ";
				break;
			}
			case 22: {
				string += "X3" + " ";
				break;
			}
			case 23: {
				string += "X4" + " ";
				break;
			}
			case 24: {
				string += "X5" + " ";
				break;
			}
			case 25: {
				string += "X6" + " ";
				break;
			}
			case 26: {
				string += "X7" + " ";
				break;
			}
			case 27: {
				string += "X8" + " ";
				break;
			}
			case 28: {
				string += "X9" + " ";
				break;
			}
			case 29: {
				string += "X10" + " ";
				break;
			}
			default: {
				string += "?" + " ";
				break;
			}
			}
		}
		string += "\n";
		return string;
	}

	public void mutationGene(int i) {
		int n, rand, z;
		if (i < Function.Head_length)
			n = 3;
		else
			n = 1;
		rand = Function.random(n);
		if (rand == 0) {
			z = Function.random(Function.m + 1);
			if (z == 0) {
				expression[i] = Function.random(10) + 10;
			} else {
				expression[i] = z + 19;
			}
		} else if (rand == 1) {
			expression[i] = Function.random(4);
		} else {
			expression[i] = Function.random(6) + 4;
		}
	}
}
