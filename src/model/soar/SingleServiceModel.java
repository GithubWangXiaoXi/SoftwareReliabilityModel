package model.soar;
/*
    *       单个服务的可靠性
 * 
 *  R 可靠度
 *  λ 失效率
 *  t 连续运行时间，此处为离散的调用次数
 * */
public class SingleServiceModel {
	//功能可靠性 
	private double lamdaf;
	//private double reliabilityf;
	//绑定可靠性
	private double lamdab=1;
	//private double reliabilityb;
	//连接可靠性
	private double lamdac;
	//private double reliabilityc;
	//单个服务的可靠性
	private double lamda;
	private double reliability;
	
	private int time;
	public void setTime(int t) {
		this.time=t;
	}
	
	public void setLamdaf(double lamdaf) {
		this.lamdaf = lamdaf;
	}
	
	
	public void setLamdac(double lamdac) {
		this.lamdac = lamdac;
	}
	
	public double getLamda() {
		return lamdaf+lamdac;
	}
	
	public double calcReliability() {
		//R=e`-λt
		
		double rf=Math.pow(Math.E, 0-lamdaf*time);
		double rc=Math.pow(Math.E, 0-lamdac*time);
		return Utils.getRound(rf*rc);
		
	}
	
}
