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

public class UYChart
{
	private double[] data;
	private String type;
	private XYDataset createDataset() 
	{
		XYSeries xyseries1=new XYSeries("预测数据");
		XYSeries xyseries2=new XYSeries("对角线");
		xyseries1.add(0,0);
		for(int i=0;i<data.length;i++)
		{
			double x=i+1;
			double y=data.length;
			xyseries1.add(data[i],x/y);
		}
		xyseries2.add(0,0);
		xyseries2.add(1,1);
		XYSeriesCollection xyseriescollection = new XYSeriesCollection();
		xyseriescollection.addSeries(xyseries1);
		xyseriescollection.addSeries(xyseries2);
		
		return xyseriescollection;
    }
	
	 private JFreeChart createChart(XYDataset dataset)
	    {
	        JFreeChart chart = ChartFactory.createXYLineChart(
	        		type+"-结构图",         			 		//报表标题
	                "X轴",                               //x轴标签 
	                "Y轴",                    //y轴标签 
	                dataset,                               //数据集 
	                PlotOrientation.VERTICAL,
	                true,                                  //是否显示图例
	                true,                                  //是否有工具条提示
	                false                                  //是否有链接
	                );

	        //设置主标题
	        chart.setTitle(new TextTitle(type+"-结构图", new Font("隶书", Font.ITALIC, 15)));
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
	public String generateLineChart(double[] data,String type,HttpSession session, PrintWriter pw)
	{
		this.data=new double[data.length];
		for(int i=0;i<data.length;i++)
		{
			this.data[i]=data[i];
		}
		this.type=type;
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
