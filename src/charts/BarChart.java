package charts;

import java.io.IOException;
import java.io.PrintWriter;
import java.awt.*;
import javax.servlet.http.HttpSession;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.servlet.ServletUtilities;
import org.jfree.chart.plot.*;
import org.jfree.chart.labels.*;
import org.jfree.chart.renderer.category.BarRenderer3D;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.ui.*;

//����״ͼ
public class BarChart
{
	private String name;	//������ʾ��Ҫ��ͼ������������MSE��AE��
	private String[] model;	//ģ�������飬��BPN_1��RBFN_1��
	private double[] value;	//ÿ��ģ�;����ֵ
	private DefaultCategoryDataset createDataset()	//�������ݼ���������������
	{
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();	
											//����һ��DefaultCategoryDataset����ʵ��
		for(int i = 0; i < model.length; i++)	
		{
			dataset.addValue(value[i], name, model[i]);	
		}				//value[i]�����������ֵ��nameΪ��������model[i]Ϊ������ģ����
		return dataset;
	}
	private JFreeChart createChart(DefaultCategoryDataset dataset)	//����ͼƬ
	{
		JFreeChart chart = ChartFactory.createBarChart3D(name+"ͼ", //�������
                "ģ������",					//x���ǩ 
                name+"ֵ",					//y���ǩ
                dataset,					//���ݼ� 
                PlotOrientation.VERTICAL,	//ͼ��ʾ�ķ���
                false,						//�Ƿ���ʾͼ��
                false,						//�Ƿ��й�������ʾ
                false);						//�Ƿ�������
		
		//���Ի�����
		CategoryPlot plot = chart.getCategoryPlot();	//�������񱳾���ɫ
		plot.setBackgroundPaint(Color.white);			//��������������ɫ
		plot.setDomainGridlinePaint(Color.blue);		//�������������ɫ
		plot.setRangeGridlinePaint(Color.blue);			//��ʾÿ��������ֵ�����޸ĸ���ֵ����������
		BarRenderer3D renderer = new BarRenderer3D();
		renderer.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
		renderer.setBaseItemLabelsVisible(true);//Ĭ�ϵ�������ʾ�������У�ͨ����������ɵ������ֵ���ʾ
		renderer.setBasePositiveItemLabelPosition(new ItemLabelPosition(
											ItemLabelAnchor.OUTSIDE12, 
											TextAnchor.BASELINE_LEFT));
		renderer.setItemLabelAnchorOffset(10D);	//����ÿ��������������ƽ������֮�����
		plot.setRenderer(renderer); 			//����ģ��������ʾλ��
		return chart;
	}
	
	public String generateBarChart(String name, 
									String[] model, 
									double[] value, 
									HttpSession session, 
									PrintWriter pw)		//������״ͼ���ⲿ�ӿں���
    {
		this.name=name;
		this.model=new String[model.length];
		this.value=new double[value.length];
		for(int i=0;i<model.length;i++)
		{
			this.model[i]=model[i];
			this.value[i]=value[i];
		}			//��ʼ������
		DefaultCategoryDataset dataset = createDataset();	//�������ݼ����뷽��
        JFreeChart chart = createChart(dataset);	//��������ͼƬ����
        String filename=null;	//����filename��
        try
        {
        	filename = ServletUtilities.saveChartAsPNG(chart,800,500,null,session);
        	//����ͼƬ���ļ���������filename��
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
        return filename;
    }
}
