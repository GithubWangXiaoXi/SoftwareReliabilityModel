package model.datadriven.svm;
 
import java.util.*;

class svm_predict {
	
	private double[] output;
	
//	private static svm_print_interface svm_print_null = new svm_print_interface()
//	{
//		public void print(String s) {}
//	};

	private static svm_print_interface svm_print_stdout = new svm_print_interface()
	{
		public void print(String s)
		{
			//System.out.print(s);
		}
	};

	private static svm_print_interface svm_print_string = svm_print_stdout;

	static void info(String s) 
	{
		svm_print_string.print(s);
	}

	private static double atof(String s)
	{
		return Double.valueOf(s).doubleValue();
	}

	private static int atoi(String s)
	{
		return Integer.parseInt(s);
	}

	private static double[] predict(/*BufferedReader input, DataOutputStream output, */svm_model model, int predict_probability, double[] y) //throws IOException
	{
		double[] out = null;
		int correct = 0;
		int total = 0;
		double error = 0;
		double sumv = 0, sumy = 0, sumvv = 0, sumyy = 0, sumvy = 0;

		int svm_type=svm_ori.svm_get_svm_type(model);
//		int nr_class=svm_ori.svm_get_nr_class(model);
//		double[] prob_estimates=null;

//		if(predict_probability == 1)
//		{
//			if(svm_type == svm_parameter.EPSILON_SVR ||
//			   svm_type == svm_parameter.NU_SVR)
//			{
//				svm_predict.info("Prob. model for test data: target value = predicted value + z,\nz: Laplace distribution e^(-|z|/sigma)/(2sigma),sigma="+svm.svm_get_svr_probability(model)+"\n");
//			}
//			else
//			{
//				int[] labels=new int[nr_class];
//				svm.svm_get_labels(model,labels);
//				prob_estimates = new double[nr_class];
//				output.writeBytes("labels");
//				for(int j=0;j<nr_class;j++)
//					output.writeBytes(" "+labels[j]);
//				output.writeBytes("\n");
//			}
//		}
		
		
		int yLen = y.length;
		int counter = 0;
		out = new double[yLen];
		while(true)
		{
			if(counter >= yLen)
			{
				break;
			}
			String line = ""+y[counter]+" "+1+":"+(svm_parameter.failureTimeth[counter]);//fp.readLine();
			
			counter++;
			
//			if(line == null) break;

			StringTokenizer st = new StringTokenizer(line," \t\n\r\f:");

			double target = atof(st.nextToken());
			int m = st.countTokens()/2;
			svm_node[] x = new svm_node[m];
			for(int j=0;j<m;j++)
			{
				x[j] = new svm_node();
				x[j].index = atoi(st.nextToken());
				x[j].value = atof(st.nextToken());
			}

			double v = 0; 
			//分类
			if (predict_probability==1 && (svm_type==svm_parameter.C_SVC || svm_type==svm_parameter.NU_SVC))
			{
//				v = svm.svm_predict_probability(model,x,prob_estimates);
//				output.writeBytes(v+" ");
//				for(int j=0;j<nr_class;j++)
//					output.writeBytes(prob_estimates[j]+" ");
//				output.writeBytes("\n");
			}
			else  //回归
			{
				v = svm_ori.svm_predict(model,x);
				//output.writeBytes(v+"\n");
				out[counter-1] = v;
			}

			if(v == target)
				++correct;
			error += (v-target)*(v-target);
			sumv += v;
			sumy += target;
			sumvv += v*v;
			sumyy += target*target;
			sumvy += v*target;
			++total;
		}
		if(svm_type == svm_parameter.EPSILON_SVR ||
		   svm_type == svm_parameter.NU_SVR)
		{
			svm_predict.info("Mean squared error = "+error/total+" (regression)\n");
			svm_predict.info("Squared correlation coefficient = "+
				 ((total*sumvy-sumv*sumy)*(total*sumvy-sumv*sumy))/
				 ((total*sumvv-sumv*sumv)*(total*sumyy-sumy*sumy))+
				 " (regression)\n");
		}
		else
			svm_predict.info("Accuracy = "+(double)correct/total*100+
				 "% ("+correct+"/"+total+") (classification)\n");
		
		return out.clone();
	}

	//--
//	private static void exit_with_help()
//	{
//		System.err.print("usage: svm_predict [options] test_file model_file output_file\n"
//		+"options:\n"
//		+"-b probability_estimates: whether to predict probability estimates, 0 or 1 (default 0); one-class SVM not supported yet\n"
//		+"-q : quiet mode (no outputs)\n");
//		System.exit(1);
//	}

	public double[] getPredication(/*String[] argv,*/ svm_model model, double[] y)// throws IOException
	{
		runPredication(/*argv*/ model, y);
		return  output.clone();
	}
	
	//输入文件名， 模型文件名， 输出文件名
	public void runPredication(/*String[] argv,*/ svm_model model, double[] y) //throws IOException
	{		
		//int i,
		int predict_probability=0;
        	svm_print_string = svm_print_stdout;

		// parse options
//		for(i=0;i<argv.length;i++)
//		{
//			if(argv[i].charAt(0) != '-') break;
//			++i;
//			switch(argv[i-1].charAt(1))
//			{
//				case 'b':
//					predict_probability = atoi(argv[i]);
//					break;
//				case 'q':
//					svm_print_string = svm_print_null;
//					i--;
//					break;
//				default:
//					System.err.print("Unknown option: " + argv[i-1] + "\n");
//					exit_with_help();
//			}
//		}
//		if(i>=argv.length-2)
//			exit_with_help();
//		try 
//		{
			//BufferedReader input = new BufferedReader(new FileReader(argv[i]));
//			DataOutputStream output = new DataOutputStream(new BufferedOutputStream(new FileOutputStream(argv[i+2])));
			//svm_model modelss = svm.svm_load_model(argv[i+1]);
			
			if(predict_probability == 1)
				if(svm_ori.svm_check_probability_model(model)==0)
			{
				{
					System.err.print("Model does not support probabiliy estimates\n");
					System.exit(1);
				}
			}
			else
			{
				if(svm_ori.svm_check_probability_model(model)!=0)
				{
					svm_predict.info("Model supports probability estimates, but disabled in prediction.\n");
				}
			}
		this.output = predict(/*input,*//*output,*/model,predict_probability, y);
		//	input.close();
		//	output.close();
//		} 
//		catch(FileNotFoundException e) 
//		{
//			exit_with_help();
//		}
//		catch(ArrayIndexOutOfBoundsException e) 
//		{
//			exit_with_help();
//		}
	}
	
	 
}
