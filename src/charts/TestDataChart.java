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

public class TestDataChart
{
	private String[] model;
	private double[] data_real;
	private double[][] data_test;
	private String colname;
	private int n;
	private XYDataset createDataset() 
	{
		XYSeries[] xyseries=new XYSeries[model.length+1];
		xyseries[0]=new XYSeries("真实数据");
		for(int i=0;i<model.length;i++)
		{
			xyseries[i+1]=new XYSeries(model[i]);
		}
		
		for(int i=0;i<data_real.length;i++)
		{
			xyseries[0].add(n+i+1,data_real[i]);
		}
		
		for(int i=0;i<model.length;i++)
		{
			for(int j=0;j<data_real.length;j++)
			{
				xyseries[i+1].add(n+j+1,data_test[i][j]);
			}
		}
		
		XYSeriesCollection xyseriescollection = new XYSeriesCollection();
		for(int i=0;i<model.length+1;i++)
		{
			xyseriescollection.addSeries(xyseries[i]);
		}
		return xyseriescollection;
    }
	
	 private JFreeChart createChart(XYDataset dataset)
	    {
	        JFreeChart chart = ChartFactory.createXYLineChart(
	                "软件可靠性模型测试数据对比图",          //报表标题
	                "时间序列",                               //x轴标签 
	                colname,                    //y轴标签 
	                dataset,                               //数据集 
	                PlotOrientation.VERTICAL,				//图显示的方向
	                true,                                  //是否显示图例
	                true,                                  //是否有工具条提示
	                false                                  //是否有链接
	                );

	        //设置主标题
	        chart.setTitle(new TextTitle("测试对比图", new Font("隶书", Font.ITALIC, 15)));
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
	
	
	
	 public String generateLineChart(String[] model,double[] data_real,double[][] data_test,int n,String colname,HttpSession session, PrintWriter pw)
	    {
		 	this.n = n;
		 	this.model = new String[model.length];
		 	this.data_real = new double[data_real.length];
		 	this.data_test = new double[model.length][data_real.length];
		 	this.colname = colname;
		 	for(int i=0;i<model.length;i++)
		 	{
		 		this.model[i]=model[i];
		 	}
		 	for(int i=0;i<data_real.length;i++)
		 	{
		 		this.data_real[i]=data_real[i];
		 	}
		 	for(int i=0;i<model.length;i++)
		 	{
			 	for(int j=0;j<data_real.length;j++)
			 	{
			 		this.data_test[i][j]=data_test[i][j];
			 	}
		 	}
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