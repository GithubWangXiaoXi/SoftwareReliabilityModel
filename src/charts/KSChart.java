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

public class KSChart
{
	private double[] data1;
	private double[] data2;
	private XYDataset createDataset() 
	{
		XYSeries xyseries1=new XYSeries("��ʵ����");
		XYSeries xyseries2=new XYSeries("Ԥ������");
		XYSeries xyseries3=new XYSeries("�Խ���");
		xyseries1.add(0,0);
		xyseries2.add(0,0);
		for(int i=0;i<data1.length;i++)
		{
			xyseries1.add((i+1)*1.0/data1.length,data1[i]);
			xyseries2.add((i+1)*1.0/data2.length,data2[i]);
		}
			xyseries3.add(0,0);
			xyseries3.add(1,1);
		XYSeriesCollection xyseriescollection = new XYSeriesCollection();
		xyseriescollection.addSeries(xyseries1);
		xyseriescollection.addSeries(xyseries2);
		xyseriescollection.addSeries(xyseries3);
		
		return xyseriescollection;
    }
	
	 private JFreeChart createChart(XYDataset dataset)
	    {
	        JFreeChart chart = ChartFactory.createXYLineChart(
	        		"K-S����ͼ",         			 		//�������
	                "X��",                               //x���ǩ 
	                "Y��",                    //y���ǩ 
	                dataset,                               //���ݼ� 
	                PlotOrientation.VERTICAL,
	                true,                                  //�Ƿ���ʾͼ��
	                true,                                  //�Ƿ��й�������ʾ
	                false                                  //�Ƿ�������
	                );

	        //����������
	        chart.setTitle(new TextTitle("K-S����ͼ", new Font("����", Font.ITALIC, 15)));
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
	public String generateLineChart(double[] data1,double[] data2, HttpSession session, PrintWriter pw)
	{
		this.data1 = data1.clone();
		this.data2 = data2.clone();
		XYDataset dataset = createDataset();  //�����ݼ����㱣����XYSeries��
        JFreeChart chart = createChart(dataset);  //��XYSeries��Ϊ��������chart
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
