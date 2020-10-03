package model.soar;

public class ServicePoolModel {
	//服务池服务的个数
	private int n;
	//服务失效率
	private double[][] lamda;
	//初始化当前服务池模型
	public void init_servicePool(int num,double[][] failurepercent) {
		this.n=num;
		this.lamda=failurepercent;
	}
	//计算该服务池的整体可靠性
	public double calcRsp() {
		if(lamda==null) return 1.0;
		double rsp=0;
		for(int i=0;i<lamda.length;i++) {
			double temp=1-lamda[i][lamda[i].length-1];
			//System.out.println(temp);
			for(int j=0;j<i;j++) {
				temp*=lamda[j][lamda[j].length-2];
			}
			rsp+=temp;
		}
		return rsp;
	}
	//计算整体失效率，t=1
	public double calcLamda() {
		double rsp=this.calcRsp();
		double lamda= -Math.log(rsp);
		return (double)Math.round(lamda*1000)/1000;
	}
	//Test
	public  static void main(String[] args) {
		//System.out.println(Math.pow(Math.E, -0.03));
		double[][] data= {{0.029 ,0.021 ,0.050},
				{0.035, 0.046 ,0.081},
				{0.081, 0.054, 0.135}
		};
		double[][] data2= {{0.023, 0.035, 0.058},
				{0.096, 0.037, 0.133},
				{0.113, 0.061, 0.174}
		};
		ServicePoolModel sModel=new ServicePoolModel();
		sModel.init_servicePool(3, data);
		System.out.println(sModel.calcRsp()+" "+sModel.calcLamda());
		
		sModel.init_servicePool(3, data2);
		System.out.println(sModel.calcRsp()+" "+sModel.calcLamda());
	}
}
