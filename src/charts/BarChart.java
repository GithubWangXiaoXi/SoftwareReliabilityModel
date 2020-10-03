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

//画柱状图
public class BarChart
{
	private String name;	//用来表示需要画图的类型名，如MSE、AE等
	private String[] model;	//模型名数组，如BPN_1、RBFN_1等
	private double[] value;	//每个模型具体的值
	private DefaultCategoryDataset createDataset()	//创建数据集，输入横纵坐标点
	{
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();	
											//声明一个DefaultCategoryDataset类型实例
		for(int i = 0; i < model.length; i++)	
		{
			dataset.addValue(value[i], name, model[i]);	
		}				//value[i]代表纵坐标的值，name为类型名，model[i]为横坐标模型名
		return dataset;
	}
	private JFreeChart createChart(DefaultCategoryDataset dataset)	//生成图片
	{
		JFreeChart chart = ChartFactory.createBarChart3D(name+"图", //报表标题
                "模型名称",					//x轴标签 
                name+"值",					//y轴标签
                dataset,					//数据集 
                PlotOrientation.VERTICAL,	//图显示的方向
                false,						//是否显示图例
                false,						//是否有工具条提示
                false);						//是否有链接
		
		//个性化设置
		CategoryPlot plot = chart.getCategoryPlot();	//设置网格背景颜色
		plot.setBackgroundPaint(Color.white);			//设置网格竖线颜色
		plot.setDomainGridlinePaint(Color.blue);		//设置网格横线颜色
		plot.setRangeGridlinePaint(Color.blue);			//显示每个柱的数值，并修改该数值的字体属性
		BarRenderer3D renderer = new BarRenderer3D();
		renderer.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
		renderer.setBaseItemLabelsVisible(true);//默认的数字显示在柱子中，通过如下两句可调整数字的显示
		renderer.setBasePositiveItemLabelPosition(new ItemLabelPosition(
											ItemLabelAnchor.OUTSIDE12, 
											TextAnchor.BASELINE_LEFT));
		renderer.setItemLabelAnchorOffset(10D);	//设置每个地区所包含的平行柱的之间距离
		plot.setRenderer(renderer); 			//设置模型名的显示位置
		return chart;
	}
	
	public String generateBarChart(String name, 
									String[] model, 
									double[] value, 
									HttpSession session, 
									PrintWriter pw)		//生成柱状图的外部接口函数
    {
		this.name=name;
		this.model=new String[model.length];
		this.value=new double[value.length];
		for(int i=0;i<model.length;i++)
		{
			this.model[i]=model[i];
			this.value[i]=value[i];
		}			//初始化数据
		DefaultCategoryDataset dataset = createDataset();	//调用数据集输入方法
        JFreeChart chart = createChart(dataset);	//调用生成图片方法
        String filename=null;	//声明filename名
        try
        {
        	filename = ServletUtilities.saveChartAsPNG(chart,800,500,null,session);
        	//生成图片，文件名保存在filename中
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
        return filename;
    }
}
