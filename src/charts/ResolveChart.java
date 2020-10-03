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

public class ResolveChart
{
	private double[] data_resolve;
	private String resolvename;
	private String colname;
	private XYDataset createDataset() 
	{
		XYSeries xyseries=new XYSeries(resolvename);
		for(int i=0;i<data_resolve.length;i++)
		{
			xyseries.add(i+1,data_resolve[i]);
		}
		XYSeriesCollection xyseriescollection = new XYSeriesCollection();
		xyseriescollection.addSeries(xyseries);
		return xyseriescollection;
    }
	
	 private JFreeChart createChart(XYDataset dataset)
	    {
	        JFreeChart chart = ChartFactory.createXYLineChart(
	                "�ֽ�����ͼ",         			 		//�������
	                "ʱ������",                               //x���ǩ 
	                colname,                    		//y���ǩ 
	                dataset,                               //���ݼ� 
	                PlotOrientation.VERTICAL,
	                false,                                  //�Ƿ���ʾͼ��
	                true,                                  //�Ƿ��й�������ʾ
	                false                                  //�Ƿ�������
	                );

	        //����������
	        chart.setTitle(new TextTitle(resolvename+"�ֽ�����ͼ", new Font("����", Font.ITALIC, 15)));
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
	public String generateLineChart(double[] data_resolve,String resolvename,
								String colname,HttpSession session, PrintWriter pw)
	{
		this.data_resolve=new double[data_resolve.length];
		for(int i=0;i<data_resolve.length;i++)
		{
			this.data_resolve[i]=data_resolve[i];
		}
		this.resolvename=resolvename;
		this.colname=colname;
		XYDataset dataset = createDataset();
        JFreeChart chart = createChart(dataset);
        String filename=null;
        try
        {
        	filename = ServletUtilities.saveChartAsPNG(chart,400,250,null,session);
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
        return filename;
	 }
}
