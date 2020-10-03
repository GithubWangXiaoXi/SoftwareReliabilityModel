package system;

public class ParameterInfo
{
	private String step="5";
	private String[] arima={"0.1","0.2","0.3","0.4"};
	private String[] bpn={"0.1","5","10000","0.01"};
	private String[] gep={"30","5","6","3","0.044","0.1",
						"0.1","0.3","0.3","0.1","1000","0.1"};
	private String[] gm={"1"};
	private String[] rbfn={"5","0.1"};
	private String[] svm={"4","2","1","1","0.1","0.5","0","0.001"};
	private String[] boost={"1","100","0.2"};
	private String[] go={"0.001","0.001"};
	private String[] mo={"0.001","0.001"};
	private String[] weibull={};
	private String[] duane={};
	private String[] jm={"0.001","0.001"};
	private String[] schneidewind={"0.00001","0.00001"};
	private String[] gammasrm={};
	private String[] exponentialsrm={};
	private String[] lognormalsrm={};
	public void setparameter(String model, String[] parameter)
	{
		if(model.equals("ARIMA"))
		{
			for(int i=0;i<arima.length;i++)
			{
				arima[i]=parameter[i];
			}
		}
		if(model.equals("BPN"))
		{
			for(int i=0;i<bpn.length;i++)
			{
				bpn[i]=parameter[i];
			}
		}
		if(model.equals("GEP"))
		{
			for(int i=0;i<gep.length;i++)
			{
				gep[i]=parameter[i];
			}
		}
		if(model.equals("GM"))
		{
			for(int i=0;i<gm.length;i++)
			{
				gm[i]=parameter[i];
			}
		}
		if(model.equals("RBFN"))
		{
			for(int i=0;i<rbfn.length;i++)
			{
				rbfn[i]=parameter[i];
			}
		}
		if(model.equals("SVM"))
		{
			for(int i=0;i<svm.length;i++)
			{
				svm[i]=parameter[i];
			}
		}
		if(model.equals("BOOST"))
		{
//			for(int i=0;i<boost.length;i++)
//			{
//				boost[i]=parameter[i];
//			}
		}
		if(model.equals("GO"))
		{
			for(int i=0;i<go.length;i++)
			{
				go[i]=parameter[i];
			}
		}
		if(model.equals("MO"))
		{
			for(int i=0;i<go.length;i++)
			{
				mo[i]=parameter[i];
			}
		}
		if(model.equals("JM"))
		{
			for(int i=0;i<jm.length;i++)
			{
				jm[i]=parameter[i];
			}
		}
		if(model.equals("DUANE"))
		{
			for(int i=0;i<duane.length;i++)
			{
				duane[i]=parameter[i];
			}
		}
		if(model.equals("WEIBULL"))
		{
			for(int i=0;i<weibull.length;i++)
			{
				weibull[i]=parameter[i];
			}
		}
		if(model.equals("SCHNEIDEWIND"))
		{
			for(int i=0;i<schneidewind.length;i++)
			{
				schneidewind[i]=parameter[i];
			}
		}
		if(model.equals("GammaSRM"))
		{
			for(int i=0;i<gammasrm.length;i++)
			{
				gammasrm[i]=parameter[i];
			}
		}
		
		if(model.equals("ExponentialSRM"))
		{
			for(int i=0;i<exponentialsrm.length;i++)
			{
				exponentialsrm[i]=parameter[i];
			}
		}
		
		if(model.equals("LogNormalSRM"))
		{
			for(int i=0;i<lognormalsrm.length;i++)
			{
				lognormalsrm[i]=parameter[i];
			}
		}
		
	}
	public String[] getparameter(String model)
	{
		if(model.equals("ARIMA"))
		{
			return arima;
		}
		if(model.equals("BPN"))
		{
			return bpn;
		}
		if(model.equals("GEP"))
		{
			return gep;
		}
		if(model.equals("GM"))
		{
			return gm;
		}
		if(model.equals("RBFN"))
		{
			return rbfn;
		}
		if(model.equals("SVM"))
		{
			return svm;
		}
		if(model.equals("BOOST"))
		{
			return boost;
		}
		if(model.equals("GO"))
		{
			return go;
		}
		if(model.equals("MO"))
		{
			return mo;
		}
		if(model.equals("JM"))
		{
			return jm;
		}
		if(model.equals("DUANE"))
		{
			return duane;
		}
		if(model.equals("WEIBULL"))
		{
			return weibull;
		}
		if(model.equals("SCHNEIDEWIND"))
		{
			return schneidewind;
		}
		if(model.equals("GammaSRM"))
		{
			return gammasrm;
		}
		
		if(model.equals("ExponentialSRM"))
		{
			return exponentialsrm;
		}
		
		if(model.equals("LogNormalSRM"))
		{
			return lognormalsrm;
		}
		
		return svm;
	}
	public String getstep()
	{
		return step;
	}
	public int getnumber(String model)
	{
		if(model.equals("ARIMA"))
		{
			return arima.length;
		}
		if(model.equals("BPN"))
		{
			return bpn.length;
		}
		if(model.equals("GEP"))
		{
			return gep.length;
		}
		if(model.equals("GM"))
		{
			return gm.length;
		}
		if(model.equals("RBFN"))
		{
			return rbfn.length;
		}
		if(model.equals("SVM"))
		{
			return svm.length;
		}
		
		if(model.equals("GO"))
		{
			return go.length;
		}
		if(model.equals("MO"))
		{
			return mo.length;
		}
		if(model.equals("JM"))
		{
			return jm.length;
		}
		if(model.equals("DUANE"))
		{
			return duane.length;
		}
		if(model.equals("WEIBULL"))
		{
			return weibull.length;
		}
		if(model.equals("SCHNEIDEWIND"))
		{
			return schneidewind.length;
		}
		if(model.equals("GammaSRM"))
		{
			return gammasrm.length;
		}
		
		if(model.equals("ExponentialSRM"))
		{
			return exponentialsrm.length;
		}
		
		if(model.equals("LogNormalSRM"))
		{
			return lognormalsrm.length;
		}
		
		return 0;
	}
}
