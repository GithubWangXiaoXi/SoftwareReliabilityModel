package charts;

import java.awt.Font;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpSession;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.plot.XYPlot;
import org.jfree.chart.renderer.xy.XYItemRenderer;
import org.jfree.chart.renderer.xy.XYLineAndShapeRenderer;
import org.jfree.chart.servlet.ServletUtilities;
import org.jfree.chart.title.TextTitle;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.ui.RectangleInsets;
import org.jfree.data.xy.XYDataset;
import org.jfree.data.xy.XYSeries;
import org.jfree.data.xy.XYSeriesCollection;

public class ThreeStepChart
{
	private double[] data_real;
	private double[] data_test;
	private double[] data_fitness;
	private double[] data_pre;
	private String model;
	private String colname;
	private XYDataset createDataset() 
	{
		String series1="真实数据";
		String series2="测试数据";
		String series3="预测数据";
		String series4="模型拟合数据";
		XYSeries xyseries1=new XYSeries(series1);
		XYSeries xyseries2=new XYSeries(series2);
		XYSeries xyseries3=new XYSeries(series3);
		XYSeries xyseries4=new XYSeries(series4);
		for(int i=0;i<data_real.length;i++)
		{
			xyseries1.add(i+1,data_real[i]);
		}
		for(int i=0;i<data_test.length;i++)
		{
			xyseries2.add(data_real.length-data_test.length+i+1,data_test[i]);
		}
		xyseries3.add(data_real.length,data_real[data_real.length-1]);
		for(int i=0;i<data_pre.length;i++)
		{
			xyseries3.add(data_real.length+i+1,data_pre[i]);
		}
		for(int i=0;i<data_fitness.length;i++)
		{
			if(data_fitness[i]!=0.001) xyseries4.add(i+1,data_fitness[i]);
		}
		XYSeriesCollection xyseriescollection = new XYSeriesCollection();
		xyseriescollection.addSeries(xyseries1);
		xyseriescollection.addSeries(xyseries2);
		xyseriescollection.addSeries(xyseries3);
		if(data_fitness.length > 5) xyseriescollection.addSeries(xyseries4);
		return xyseriescollection;
    }
	
	 private JFreeChart createChart(XYDataset dataset)
	    {
	        JFreeChart chart = ChartFactory.createXYLineChart(
	                "软件可靠性测试及预测数据图",          //报表标题
	                "时间序列",                               //x轴标签 
	                colname,                    		//y轴标签 
	                dataset,                               //数据集 
	                PlotOrientation.VERTICAL,
	                true,                                  //是否显示图例
	                true,                                  //是否有工具条提示
	                false                                  //是否有链接
	                );

	        //设置主标题
	        chart.setTitle(new TextTitle(model+"模型测试-预测图", new Font("隶书", Font.ITALIC, 15)));
	        chart.setAntiAlias(true);
	        
	        XYPlot plot = (XYPlot)chart.getPlot(); 
	        plot.setAxisOffset(new RectangleInsets(5,5,5,5));
	        
	        XYItemRenderer r=plot.getRenderer();
	        XYLineAndShapeRenderer renderer=(XYLineAndShapeRenderer) r;
	        renderer.setBaseShapesVisible(true);
	        
	        
	        NumberAxis axis = (NumberAxis)plot.getDomainAxis();
	        axis.setVerticalTickLabels(true);
	        axis.setStandardTickUnits(NumberAxis.createIntegerTickUnits());
	        
	        return chart;
	    }
	
	
	
	 public String generateLineChart(double[] data_train,double[] data_test,double[] data_out,double[] data_fitness,String model,String colname,HttpSession session, PrintWriter pw)
	    {
		 	this.data_fitness = data_fitness.clone();
		 	data_real=new double[data_train.length+data_test.length];
		 	this.data_test=new double[data_test.length];
		 	data_pre=new double[data_out.length-data_test.length];
		 	int k=0;
		 	for(int i=0;i<data_train.length;i++,k++)
		 	{
		 		data_real[k]=data_train[i];
		 	}
		 	for(int i=0;i<data_test.length;i++,k++)
		 	{
		 		data_real[k]=data_test[i];
		 	}
		 	k=0;
		 	for(int i=0;i<data_test.length;i++,k++)
		 	{
		 		this.data_test[i]=data_out[k];
		 	}
		 	for(int i=0;i<data_out.length-data_test.length;i++,k++)
		 	{
		 		data_pre[i]=data_out[k];
		 	}
		 	this.model=model;
		 	this.colname=colname;
	        XYDataset dataset = createDataset();
	        JFreeChart chart = createChart(dataset);
	        String filename=null;
	        try
	        {
	        	filename = ServletUtilities.saveChartAsPNG(chart,800,500,null,session);
	        }
	        catch (IOException e)
	        {
	            e.printStackTrace();
	        }
	        return filename;
	    }
	 public String generateLineChart(double[] data_train,double[] data_test,String model,String colname,HttpSession session, PrintWriter pw)
	    {
		 	this.data_fitness = data_fitness.clone();
		 	data_real=new double[data_train.length+data_test.length];
		 	this.data_test=new double[data_test.length];
		 	//data_pre=new double[data_out.length-data_test.length];
		 	int k=0;
		 	for(int i=0;i<data_train.length;i++,k++)
		 	{
		 		data_real[k]=data_train[i];
		 	}
		 	for(int i=0;i<data_test.length;i++,k++)
		 	{
		 		data_real[k]=data_test[i];
		 	}
		 	k=0;
		 	/*for(int i=0;i<data_test.length;i++,k++)
		 	{
		 		this.data_test[i]=data_out[k];
		 	}*/
		 	/*for(int i=0;i<data_out.length-data_test.length;i++,k++)
		 	{
		 		data_pre[i]=data_out[k];
		 	}*/
		 	this.model=model;
		 	this.colname=colname;
	        XYDataset dataset = createDataset();
	        JFreeChart chart = createChart(dataset);
	        String filename=null;
	        try
	        {
	        	filename = ServletUtilities.saveChartAsPNG(chart,800,500,null,session);
	        }
	        catch (IOException e)
	        {
	            e.printStackTrace();
	        }
	        return filename;
	    }
}
