<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%@ page contentType="text/html;charset= gb2312"%>
<%@ page import="model.soar.Utils" %>
<%@ page import="system.*" %>
<!-- javabean:inputdata ��ǰʹ������ | parameterinfo Ĭ�ϲ�����Ϣ -->
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="parameterinfo" class="system.ParameterInfo" scope="page"></jsp:useBean>
<%
	//InputData inputdata =new InputData();
	HistoryData historydata=new HistoryData();
	ReadTable rt = new ReadTable();
	ContrastData contrastdata =new ContrastData();
	ArrayList<DataSet> list=rt.getDataSet(1);
	for(int i=0;i<list.size();i++){
		DataSet ds=list.get(i);	
		historydata.entry(ds.getData(), ds.getSetname(), ds.getColname(), ds.getSetinfo());
	
	}
	DataSet curds=list.get(list.size()-1);
	inputdata.setdata(curds.getData(),		//�ñ�ѡ���ݼ��е�ָ�������滻����ǰ����
	 			curds.getSetname(),
	 			curds.getColname(),
	  			curds.getPercent(),
				curds.getSetinfo());
	int dimension = inputdata.getdimension();	
	double[][] data_train = new double[dimension][];	//����ǰ����ѵ��������һ�ݵ�ҳ��
	for(int i=0;i<dimension;i++)
	{
		data_train[i] = inputdata.getdata_train(i+1).clone();
	}
	double[][] temp=Utils.transferMartix(data_train);
	String json=Utils.reverseParse(temp);
	//System.out.println(json);
%>
<html>
	<head>
		<title>SOA������ݴ�ģ��</title>
		<link rel="stylesheet" type="text/css" href="../../CSS/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">	
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/addsubmodel.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/button/combination/validate_Combination.js" 
  		charset="gb2312"></script>
  		<script type="text/javascript" src="../../JS/jquery1.8.3.min.js"></script>
	</head>
	<body>
		<div id="loader_container" style="display:none">   <!-- ִ�еȴ��� -->
			<div id="loader">
				<div align="center">����ִ�У����Ժ� ...</div>
				<div id="loader_bg">
					<div id="progress"></div>
				</div>
			</div>
		</div>
		<input type="hidden" id="flag" value="0">
		<div class="titlename">������ݴ�ģ��</div>
		<div id="main_tab"> 
			<div class="main_tab_menu">
				<ul> 
					<li id="DW_tab1" onClick="setTab('DW',1,4)" class="hover">ģ�ͼ��</li> 
					<li id="DW_tab2" onClick="setTab('DW',2,4)" >ʧЧ����</li> 
					<li id="DW_tab3" onClick="setTab('DW',3,4)">��������</li>
					<li id="DW_tab4" onClick="setTab('DW',4,4)" style="display:none">�������</li> 
				</ul>
			</div>
			<div class="main_tab_content">
				<div id="DW_con1">
					<div class="subtitle">ģ�ͼ��</div>
					<div class="scrollbox">
						<p>
							�� �� �� �� �� �� ϵ �� �� ( service-orientedarchitecture, SOA)���ж�̬����Эͬ�Եı������� ,��ʹ�ô�ͳ������ɿ����������������������� SOAӦ�õĿ�
���ԡ� ����ⷽ�����Ҫ���� ,�����һ���µĿɿ��Զ�̬�������� ,������������߼�⵽�������������ķ�����Ͽɿ���ģ�͡�
						</p>
						<p>
							��ģ��ͨ���Ե����ϵ� 3�����������Ŀ��ϵͳ�Ķ�̬�仯 ,��: ����ɿ��ԵĶ���ģ�͡�������ݴ�ģ�ͺͻ��� Markov���ķ������ʹ��ģ�͡�
						</p>
						
						<p style="text-align:center;"><img src="../../IMAGE/SOA/soa.JPG"></p>
						<p>
							�ɿ���������һ��ʱ��ĸ��� ,�����޹��ϼ��ʱ�� ( M TT F)��Ϊ�ɿ���ָ�ꡣ����ѧ������ ,ͨ�����ɿ��ȶ���Ϊ���Ӹ�ָ���ֲ�,</p>
							<p>����ʽ:<br>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;R = e- ��t. 
                                                                                     ����: ��(�ˡ� [0, 1 ])ΪʧЧ�� ,һ���ȡ����; t ��ʾ�������е�ʱ�䡣</p>
                                                                                     <p>��������� , t��Ϊ��ɢ�ĵ��ô����������Ƕ�ε��õ����������ǽ�������� ,����
һ����ʹ�������� ,���ض��������������������
ʧЧͬ��Ҳ������Ϊ������ġ�
                                                                                     
						</p>
						<p style="text-align:center;"><img src="../../IMAGE/SOA/soa2.JPG"></p>
						<p>������̬����������⡣��������̬�ֲ�Ϊ��= (Z1 ,Z2 ,�� ,ZN ,ZC ,ZF ) , ���Ц�= ��P </p>
					<p> ������ȫ����̬���ʺ�Ϊ 1��Լ�������ɵ����·�����:</p>
					<img alt="" src="../../IMAGE/SOA/fangcheng.JPG">
					<h3>����˷����÷��̹������£�</h3>
					<p>�����������������̣����������ģ�͵�����ɿ��ԣ�</p>
					<img alt="" src="../../IMAGE/SOA/f2.JPG">
					<img alt="" src="../../IMAGE/SOA/f3.JPG">
					</div>
				</div>
				<div id="DW_con2" style="display:none">
					<%-- <div class="subtitle">���ݻ�����Ϣ</div>
					<div class="currentdata">
						�������ƣ�<%= inputdata.getdataname()%><br><br>
  	 					����������<%= inputdata.getlength_train()+inputdata.getlength_test()%><br><br>
  	 					ѵ�����ݣ�<%= inputdata.getlength_train()%><br><br>
  	 					�������ݣ�<%= inputdata.getlength_test()%><br><br>
						����ά���� <%= inputdata.getdimension()%><br><br>
  	 					����������<%= inputdata.getdatainfo()%>
					</div> --%>
					<iframe id="targetframe"name="targetframe" src="../../resultshow/showhistorydata.jsp"></iframe>
				</div>
				<div id="DW_con3" style="display:none">
					<div class="subtitle">��������<button id="fastcommit"class="button button-pill button-primary pull-right"style="margin-right: 150px;">ʹ�õ�ǰ���Լ�</button></div>
					<div class="setup" style="height:84%">
						<form id="myform"action="pool.jsp" method="post"
								target="SHOWDATA_DW" onsubmit="return validate_Combination(this);"onkeydown="if(event.keyCode==13){return false;}">
							<div class="parametersetup_title">��ѡ���������</div>
							<div class="parametersetup_content">
								<input style=""type="text" name="snum" value=""id="snum">
										(���õ�ǰ����صı�ѡ�������,���������������ʧЧ��)
							</div>
							<div id="data-table"style="display:none;">
							
							</div>
							
						
							<div style="text-align:center">
								<input type="hidden" id="model" name="model" value="DW">
								<input type="hidden" id="number" name="number" value="<%=temp.length%>">
								<input type="hidden"  name="prestep" value="2">
								<input type="hidden" id="tdata" name="tdata" value='<%= json%>'>
								<input type="hidden" id="current_tab" value="3">
								<input type="submit" class="button button-pill button-primary" value="Ԥ��"id="smit">
							</div>
						</form>
					</div>	
				</div>
				<div id="DW_con4" style="display:none">
					<iframe name="SHOWDATA_DW" src="pool.jsp"></iframe>
				</div>
			</div>		
		</div>
		<script type="text/javascript">
		$(function () {
			$('#snum').blur(function () {
				//console.log()
				if($('#data-table').css('display')!='none')return;
				//console.log($('#data-table').css('display'))
				if($(this).val()==null||$(this).val()=='')return;
				var num=parseInt($(this).val());
				if(num<=0) {
					alert("��������Ч����");
					return;
				}
				var html1='<table contenteditable="true" class="table table-bordered"><thead><th>������</th><th>����ʧЧ��</th><th>����ʧЧ��</th></thead>';
				var tbody='';
				for(var i=0;i<num;i++){
					tbody+='<tr><td><span contenteditable="true">'+(i+1)+'</span></td><td><span contenteditable="true">0.</span></td><td><span contenteditable="true">0.</span></td></tr>'
				}	  
				var html2='</table>';
				$('#data-table').html(html1+tbody+html2).show();
			});
			
			$('#smit').click(function(){
				if($('#snum').val()=="")return;
				var set = [];
				$('#data-table tr').each(function() {
				    var row = [];
				    
				    $(this).find('span').each(function() {
				        row.push($(this).text());
				    });
				    
				    set.push(row);
				});
				set.splice(0,1);
				$('#tdata').val(JSON.stringify(set));
				console.log($('#tdata').val())
			});
			
				$('#fastcommit').click(function () {
					var len=$("#number").val();
					console.log(len);
					
					$("#snum").val(len);
					
					console.log($("#snum").val());
					$('#smit').unbind().click();
				})
			})
		</script>
	</body>
</html>