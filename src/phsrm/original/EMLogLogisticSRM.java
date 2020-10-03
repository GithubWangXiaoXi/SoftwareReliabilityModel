package phsrm.original;

import phsrm.common.*;

public class EMLogLogisticSRM extends EMCommonSRM {

	LogLogisticSRM srm;
	double omega;
	double shape;
	double scale;
	int dsize;

	//work
	double en1;
	double en2;
	double en3;

	public EMLogLogisticSRM(LogLogisticSRM srm) {
		this.srm = srm;
	}

	public void doEstimation() {
		omega = srm.getTotal();
		scale = srm.getScale();
		shape = srm.getShape();
		dsize = fdat.getNumberOfRecords();
		em.runEMRunnableModel(this);
	}

	public String getParameterString() {
		return srm.getParameterString();
	}

	public double doEMstep() {
		double x, t, y;
		double tmp1, tmp2, tmp3;
		double llf;
		double g00, g01, g02;
		double g10, g11, g12;
		double en1, en2, en3;
		
		// E-step
		t = fdat.getTime(1);
		x = fdat.getNumber(1);
		y = Math.exp((Math.log(t)-scale)/shape);
		en1 = 0.0;
		en2 = 0.0;
		en3 = 0.0;
		llf = 0.0;
		g00 = 1.0/(1.0+y);
		g01 = 1.0/(2.0*(1.0+y)*(1.0+y));
		g02 = (1.0+(1.0+Math.log(y))*y)/((1.0+y)*(1.0+y));
		if (x != 0.0) {
			tmp1 = 1.0 - g00;
			tmp2 = 0.5 - g01;
			tmp3 = 1.0 - g02;
			en1 += x;
			en2 += x * tmp2 / tmp1;
			en3 += x * tmp3 / tmp1;
			llf += x * Math.log(tmp1) - Numlib.loggamma(x+1);
		}
		if (fdat.getType(1) == 1) {
			en1 += 1.0;
			en2 += 1.0/(1.0+y);
			en3 += (y-1.0)*Math.log(y)/(1.0+y);
			llf += Math.log(srm.getPDF(t));
		}
		for (int j=2; j<=fdat.getNumberOfRecords(); j++) {
			t += fdat.getTime(j);
			x = fdat.getNumber(j);
			y = Math.exp((Math.log(t)-scale)/shape);
			g10 = 1.0/(1.0+y);
			g11 = 1.0/(2.0*(1.0+y)*(1.0+y));
			g12 = (1.0+(1.0+Math.log(y))*y)/((1.0+y)*(1.0+y));
			if (x != 0.0) {
				tmp1 = g00 - g10;
				tmp2 = g01 - g11;
				tmp3 = g02 - g12;
				en1 += x;
				en2 += x * tmp2 / tmp1;
				en3 += x * tmp3 / tmp1;
				llf += x * Math.log(tmp1) - Numlib.loggamma(x+1);
			}
			if (fdat.getType(j) == 1) {
				en1 += 1.0;
				en2 += 1.0/(1.0+y);
				en3 += (y-1.0)*Math.log(y)/(1.0+y);
				llf += Math.log(srm.getPDF(t));
			}
			g00 = g10;
			g01 = g11;
			g02 = g12;
		}
		llf += Math.log(omega) * en1;  // en1 is total number of faults
		en1 += omega * g00;  // g00 is the last time
		en2 += omega * g01;  // g01 is the last time
		en3 += omega * g02;  // g02 is the last time
		llf += - omega * (1.0 - g00);
		
		// M-step
		omega =  en1;
		shape = shape*en3/en1;
		scale = scale + shape*(Math.log(en1/2.0) - Math.log(en2));
		srm.setOmega(omega);
		srm.setScale(scale);
		srm.setShape(shape);
		return llf;
	}


}
