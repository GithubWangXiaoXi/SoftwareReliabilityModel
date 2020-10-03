package system;

import java.io.*;


import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;
public class ReadFile
{
	private String filename;
	private String[][] readdata;
	private int exist;
	private int maxcol;
	
	private void readtxt()
	{
		File file = new File(filename);
		
		//���ж�ȡTXT�ļ��е�
		try 
		{
			BufferedReader br = new BufferedReader(new FileReader(file));
			String line = null;		 
			String[] str = null;
			int count = 0;
			while ((line = br.readLine()) != null )
			{					 
				str = line.split("\\s+");
				maxcol = Math.max(maxcol, str.length);	
				count++;
			}
			br.close(); 
			//��ȡ��������
			if(count==0) exist=0;
			else
			{
				maxcol = Math.min(10, maxcol);
				BufferedReader br2 = new BufferedReader(new FileReader(file));
				readdata = new String[count][];
				count = 0;
				while ((line = br2.readLine()) != null)
				{					 
					readdata[count++] = line.split("\\s+").clone();					
				}
				br2.close();
			}
		}
		catch (IOException e) 
		{
			e.printStackTrace();
		}
	}
	
	private void readexcel()
	{
		Workbook wb = null;  
		try
		{  
			// ����Workbook��������������  
			wb = Workbook.getWorkbook(new File(filename));  
		}
		catch (BiffException e)
		{
			e.printStackTrace();  
		}
		catch (IOException e)
		{  
			e.printStackTrace();  
		}  
		if (wb!=null)
        {
			// �����Workbook����֮�󣬾Ϳ���ͨ�����õ�Sheet��������������  
			Sheet[] sheet = wb.getSheets();
			if (sheet != null && sheet.length > 0)
			{
				// �õ���ǰ�����������  
				int rowNum = sheet[0].getRows();
				if(rowNum==0)
				{
					exist=0;
				}
				else
				{
					readdata=new String[rowNum][];
					for (int i = 0; i < rowNum; i++)
					{
						// �õ���ǰ�е����е�Ԫ��  
						Cell[] cells = sheet[0].getRow(i);
						if (cells != null && cells.length > 0)
	                    {  
							// ��ÿ����Ԫ�����ѭ��
							readdata[i]=new String[Math.min(10, cells.length)];
							for (int j = 0; j < cells.length; j++)
							{
								// ��ȡ��ǰ��Ԫ���ֵ
								if(j>=10) break;
								readdata[i][j] = cells[j].getContents(); 
							}
							if(cells.length>maxcol) maxcol=cells.length;
	                    }
					}
				}
				maxcol = Math.min(10, maxcol);
			}
			else
			{
				exist=0;
			}
			// ���ر���Դ���ͷ��ڴ�  
			wb.close();
        }
		else
		{
			exist=0;
		}
    }
	
	private void readcsv()
	{
		File file = new File(filename);
		
			
		//���ж�ȡCSV�ļ��е�
		try 
		{ 
			BufferedReader br = new BufferedReader(new FileReader(file));
			String line = null;		 
			String[] str = null;
			int count = 0;
			while ((line = br.readLine()) != null )
			{					 
				str = line.split(",");
				maxcol = Math.max(maxcol, str.length);	
				count++;
			}
			//��ȡ��������
			br.close();
			if(count==0) exist=0;
			else
			{
				maxcol = Math.min(10, maxcol);
				BufferedReader br2 = new BufferedReader(new FileReader(file));
				readdata = new String[count][];
				count = 0;
				while ((line = br2.readLine()) != null)
				{					 
					readdata[count++] = line.split(",").clone();			
				}
				br2.close();
			}
		}
		catch (IOException e) 
		{
			e.printStackTrace();
		}   
	}
	 	
	
	public void read(String filename,String extension)
	{
		exist=1;
		maxcol=0;
		this.filename=filename;
		if(extension.equals("txt"))
		{
			readtxt();
		}
		else if(extension.equals("xls"))
		{
	        readexcel(); 
		}
		else if(extension.equals("csv"))
		{
			readcsv();
		}
		else
		{
			exist=0;
			readdata= new String[1][1];
		}
		if(maxcol>10) maxcol=10;
	}

	public String[][] getreaddata()
	{
		int length;
		//if(readdata.length>1000) length=1000;
		 length=readdata.length;
		String[][] data=new String[length][maxcol];
		for(int i=0;i<readdata.length;i++)
		{
			for(int j=0;j<readdata[i].length;j++)
			{
				data[i][j]=readdata[i][j];
			}
		}
		return data;
	}

	public int getexist()
	{
		return exist;
	}
	
	public int getmaxcol()
	{
		return maxcol;
	}
}
