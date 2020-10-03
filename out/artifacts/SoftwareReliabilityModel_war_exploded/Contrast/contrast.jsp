<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<!-- javabean:inputdata ��ǰʹ������|contrastdata �Ա����ݼ�-->
<jsp:useBean id="inputdata" class="system.InputData" scope="session"></jsp:useBean>
<jsp:useBean id="contrastdata" class="system.ContrastData" scope="session"></jsp:useBean>
<%
	int number = contrastdata.getnumber(); //��ȡ�Ƚ����ݵĳ���
	int dimension = inputdata.getdimension(); //��ȡ�Ƚ����ݵ�ά��
	String[] colname = new String[dimension]; //���������е���ʽ��ȡ����
	for (int i = 0; i < dimension; i++)
	{
		colname[i] = inputdata.getcolname(i + 1);
	}
%>
<html>
	<head>
    	<title>���ܶԱ�</title>
       	<link rel="stylesheet" type="text/css" href="../CSS/universal.css" />
		<link rel="stylesheet" type="text/css" href="../CSS/maintab.css" />
		<link rel="stylesheet" type="text/css" href="../CSS/table.css" />
		<link rel="stylesheet" type="text/css" href="../CSS/waitload.css" />
		<link rel="stylesheet" type="text/css" href="../CSS/showtab.css" />
		<link rel="stylesheet" type="text/css" href="../CSS/buttons.css">
		<script type="text/javascript" src="../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../JS/waitload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../JS/button/validate_contrast.js" 
		charset="gb2312"></script>
	</head>
  
	<body>
	  	<div id="loader_container" style="display:none">
			<div id="loader">
				<div align="center">���ڴ������Ժ� ...</div>
				<div id="loader_bg">
					<div id="progress"></div>
				</div>
			</div>
		</div>
		<input type="hidden" id="model" value="contrast">
  		<input type="hidden" id="flag" value="0">
  		<input type="hidden" id="current_tab" value="2">
  		<div class="titlename">Ԥ�����ܶԱ�</div>
  		<div id="main_tab"> 
			<div class="main_tab_menu"> 
				<ul> 
					<li id="contrast_tab1" onClick="setTab('contrast',1,3)" 
					class="hover">Ԥ��Աȼ��</li> 
					<li id="contrast_tab2" onClick="setTab('contrast',2,3)">ѡ��Ա�ģ��</li> 
					<li id="contrast_tab3" onClick="setTab('contrast',3,3)" 
					style="display:none">�ԱȽ����ʾ</li> 
				</ul> 
			</div> 
			<div class="main_tab_content"> 
				<div id="contrast_con1">
					<div class="subtitle">Ԥ�����ܶԱ�</div>
					<div class="scrollbox">
						<p>
							Ԥ�����ܶԱȹ�����ָ����ͬһ�����ݼ���
							�Բ��ò�ͬģ�͵�Ԥ����������ͬһģ�Ͳ�ͬ������Ԥ�������жԱȷ�����
						</p>
						<p>
							����Ĺ�����Ҫ�Ƿֱ�ͨ����ģ����Ԥ��������ݽ������ʵ������������Ԥ�⼯���жԱȣ�
							�ó���ģ�͵����ܲ������Ӷ�ʹ�û��������ضԱȳ���ͬģ�Ͷ��ڸ����ݼ���Ԥ���������ӣ�
							��Ҫ�Ӿ�ֵ���ƽ����MSE�� �ع����߷��̵����ָ��R_Square�� ��ֵ���AE��
							�����ٷֱ����MSPE���ĸ����ܲ����Ƕ�ȥ��������
						</p>
					</div>
				</div> 
				<div id="contrast_con2" style="display:none">
				<%	if(inputdata.getlength_test()==0)
					{%>
						<div class="subtitle">�޲��Լ����ݣ��޷��Աȣ�����</div>
				<%	}
					else
					{%>
						<div class="show_tab_menu">
	    				<div style="width:100%;">
	    					<ul>
	    					<%	for(int i=0; i<dimension; i++)
								{%>
									<li id="col_tab<%= String.valueOf(i+1)%>" 
									onClick="setTab('col',<%= String.valueOf(i+1)%>,
									<%= String.valueOf(dimension)%>)" 
									<%if(i==0) {%>class="hover"<%}%>>
									<%= colname[i]%></li>
							<%	}%>
							</ul>
		    			</div>
	    				</div>
		    			<div class="show_tab_content">
						<%	for(int i=0; i<dimension; i++)
							{%>
								<div id="col_con<%= String.valueOf(i+1)%>"
									<%if(i!=0) {%> style="display:none" <%}%>>
									<div class="subtitle"><%= colname[i]%>ģ�ͶԱ�</div>
									<div class="scrollbox" align="center" style="height:500px">
										<form action="../resultshow/showcontrast.jsp" 
										method="post" target="SHOWDATA_contrast" 
										onsubmit="return validate_contrast(this);;">
	  				    					<table class="contrast">
	   											<tr>
	   												<th>ѡ��</th>
	  	 											<th>ģ����</th>
	  	 											<th>����ʱ��</th>
	  	 											<th>��������</th>
	  	 										</tr>
	  	 									<%	for(int j=0;j<number;j++)
	  	 										{
	  	 											if(contrastdata.getsequence(j)==i+1)
	  	 											{%>
	  	 												<tr>
	  	 													<td>
	  	 														<input type="checkbox" name="select" value="<%= String.valueOf(j)%>">
	  	 													</td>
	  	 													<td><%= contrastdata.getmodelname(j)%></td>
	  	 													<td><%= contrastdata.getdate(j)%></td>
	  	 													<td align="left"><%= contrastdata.getinfo(j)%></td>
	  	 												</tr>
	  	 										<%	}%>	
		 									<%	}%>
	  										</table>
	  										<br>
	  										<input type="hidden" name="model" value="contrast">
	  										<input type="hidden" name="Sequence" value="<%= String.valueOf(i+1)%>">
											<input type="submit" name="contrast_submit" class="button button-pill button-primary" value="�Աȷ���">
	  									</form>
									</div>
								</div>
						<%	}%>
						</div>
				<%	}%>
				</div>
				<div id="contrast_con3" style="display:none">
					<iframe name="SHOWDATA_contrast" src="../resultshow/showcontrast.jsp"></iframe>
				</div> 
			</div> 
		</div> 
	</body>
</html>
