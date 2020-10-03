package charts;

import java.awt.Font;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpSession;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.plot.XYPlot;
import org.jfree.chart.renderer.xy.XYItemRenderer;
import org.jfree.chart.renderer.xy.XYLineAndShapeRenderer;
import org.jfree.chart.servlet.ServletUtilities;
import org.jfree.chart.title.TextTitle;
import org.jfree.data.xy.XYDataset;
import org.jfree.data.xy.XYSeries;
import org.jfree.data.xy.XYSeriesCollection;
import org.jfree.ui.RectangleInsets;

public class PLRChart
{
	private double[] data;
	private String model1;
	private String model2;
	private XYDataset createDataset() 
	{
		XYSeries xyseries1=new XYSeries("PLRֵ");
		XYSeries xyseries2=new XYSeries("�Խ���");
		xyseries1.add(0,0);
		for(int i=0;i<data.length;i++)
		{
			xyseries1.add((i+1)*1.0/data.length,data[i]);
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
	        		"PLR�Ա�ͼ",         			 		//�������
	                model1+"ģ��",						//x���ǩ
	                model2+"ģ��",						//y���ǩ
	                dataset,							//���ݼ�
	                PlotOrientation.VERTICAL,
	                true,                                  //�Ƿ���ʾͼ��
	                true,                                  //�Ƿ��й�������ʾ
	                false                                  //�Ƿ�������
	                );

	        //����������
	        chart.setTitle(new TextTitle("PLR�Ա�ͼ", new Font("����", Font.ITALIC, 15)));
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
	public String generateLineChart(double[] data,String model1,String model2, HttpSession session, PrintWriter pw)
	{
		this.data = data.clone();
		this.model1 = model1;
		this.model2 = model2;
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
