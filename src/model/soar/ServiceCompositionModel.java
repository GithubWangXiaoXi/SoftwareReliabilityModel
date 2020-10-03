package model.soar;


//服务组合模型，整个SOA服务模型的可靠性，以及失效率计算
public class ServiceCompositionModel {
	//服务组合中成分服务个数
	private int N;
	//每个成分服务的失效率
	private double[] failurePercent;
	//状态转移矩阵
	private double[][] transPercent;
	//各个状态的稳态分布
	private double[] Z;
	//每个服务对应的t
	private double[] t;
	
	//初始化该组合模型
	public void init(int num,double[] fdata,double[][] tdata) {
		this.N=num;
		this.failurePercent=fdata;
		this.transPercent=tdata;
		this.Z=new double[N];
		this.t=new double[N];
	}
	public double[][] createOriginStatus() {
		double[][] status=new double[1][N];
		double tempSum=0;
		for(int i=0;i<N-1;i++) {
			status[0][i]=Math.random()/N;
			tempSum+=status[0][i];
		}
		status[0][N-1]=1-tempSum;
		//Utils.printMatrix(status);
		return status;
	}
	//根据所给的状态转移矩阵，运用Markov链求解各个状态的稳态分布
	public void calcZ() {
		//生成初始状态集
		double[][] initStatus=createOriginStatus();
		
		//double[] data= {0.291,0.201,0.090,0.291,0.064,0.064};
		this.Z=Utils.getFinalStatus(initStatus, this.transPercent);
		//Utils.printMatrix(this.Z);
	}
	
	//计算每个服务对应的t
	public void calsT() {
		for(int i=0;i<N;i++) {
			t[i]=Z[i]/Z[N-1];
		}
	}
	
	//计算最终的整个服务组合模型的失效率
	/*
	 * 
	 */
	public double getFinalLamda() {
		double res=0;
		for(int i=0;i<N;i++) {
			res+=failurePercent[i]*t[i];
		}
		return res;
	}
	
	//计算最终的整个服务组合模型的可靠性
	public double getFinalRsp() {
		double rsp= Math.pow(Math.E, 0-this.getFinalLamda());
		return (double)Math.round(rsp*1000)/1000;
	}
	public static void main(String[] args) {
		ServiceCompositionModel sModel=new ServiceCompositionModel();
		double[] fdata= {0,0.030,0.027,0,0.02,0};
		double[][] tdata= {
				{0,0.69,0.31,0,0,0},
				{0,0,0,1,0,0},
				{0,0,0,1,0,0},
				{0.78,0,0,0,0.22,0},
				{0,0,0,0,0,1},
				{1,0,0,0,0,0}
		};
		
		sModel.init(6, fdata, tdata);
		sModel.calcZ();
		sModel.calsT();
		System.out.println(sModel.getFinalLamda()+" "+sModel.getFinalRsp());
	}
}
