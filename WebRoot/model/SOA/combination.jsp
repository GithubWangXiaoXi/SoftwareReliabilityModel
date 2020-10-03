<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
    <%@ page import="model.soar.Utils" %>
    <%@ page import="system.*" %>
    <%@ page import="java.util.*" %>
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="contrastdata" class="system.ContrastData" scope="page"></jsp:useBean>
<jsp:useBean id="parse" class="model.soar.ParseJsonArr" scope="page"></jsp:useBean>
<jsp:useBean id="singleServie" class="model.soar.SingleServiceModel" scope="page"></jsp:useBean>
<jsp:useBean id="commodel" class="model.soar.ServiceCompositionModel" scope="page"></jsp:useBean>
 
 <%
 	HistoryData historydata=new HistoryData();
	ReadTable rt = new ReadTable();
	
	ArrayList<DataSet> list=rt.getDataSet(1);
	for(int i=0;i<list.size();i++){
		DataSet ds=list.get(i);	
		historydata.entry(ds.getData(), ds.getSetname(), ds.getColname(), ds.getSetinfo());
	
	}
	DataSet curds=list.get(list.size()-1);
	inputdata.setdata(curds.getData(),		//用备选数据集中的指定数据替换掉当前数据
	 			curds.getSetname(),
	 			curds.getColname(),
	  			curds.getPercent(),
				curds.getSetinfo());
 	request.setCharacterEncoding("utf-8");
 	String tdata=request.getParameter("tdata");
	//System.out.println(tdata);
	double[] lamdas=null;
	lamdas=parse.execParse3(tdata);
	double[][] ps=null;
	ps=parse.execParse2(tdata);
	commodel.init(lamdas.length,lamdas , ps);
	commodel.calcZ();
	String progress="";
	progress=Utils.getArrJson();
	commodel.calsT();
	double rsp=0;
	rsp=commodel.getFinalRsp();
	rsp=(double)Math.round(rsp*1000)/1000;
	double lamda=0;
	lamda=commodel.getFinalLamda();
	lamda=(double)Math.round(lamda*1000)/1000;
    %>
<!DOCTYPE html>
<html >
	<head>
		<meta charset="UTF-8">
		<title>服务池结果展示</title>
		<link rel="stylesheet" type="text/css" href="../../CSS/universal.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/maintab.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/waitload.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/parametersetup.css">
		<link rel="stylesheet" type="text/css" href="../../CSS/buttons.css">
  		<link rel="stylesheet" type="text/css" href="../../CSS/showtab.css">
  		<link rel="stylesheet" type="text/css" href="../../CSS/table.css">
  		<script type="text/javascript" src="../../JS/jquery1.8.3.min.js"></script>
		<script type="text/javascript" src="../../JS/onload.js" charset="gb2312"></script>	
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/addsubmodel.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/button/combination/validate_Combination.js" 
  		charset="gb2312"></script>
	</head>
	<body onload="onload()">
	
	<input type="hidden" id="data" value='<%=tdata %>'>
	<input type="hidden" id="prodata" value='<%=progress %>'>
	<div class="show_tab_menu">
    			<div style="width:100%;">
					<ul> 
						<li id="pool_tab1" onClick="setTab('pool',1,2)" class="hover">动态建模</li>
						<li id="pool_tab2" onClick="setTab('pool',2,2)">分析结果</li>
					</ul> 
				</div>
	</div>
    <div class="show_tab_content">
				<div id="pool_con1">
					<div style="width: 1156px;margin-left:100px;overflow: scroll;">
						<h2>基于当前失效数据，可构建该组合模型的DTMC状态图如下</h2>
						<canvas id="myCanvas" width="1156" height="500" style=""></canvas>
		
					</div>
				</div>
				<div id="pool_con2">
					<h2>模型求解：</h2>
					
					<div id="container" style="width:800px;height: 600px;margin-left: 20px;overflow: auto;"></div>
					
					<div style="margin-left: 20px;">
					<h3>&nbsp;&nbsp;&nbsp;该服务组合模型整体失效率 λ = <%=lamda %></h3>
					<h3>&nbsp;&nbsp;&nbsp;该服务组合模型整体可靠性 Rsp = <%=rsp %></h3>
					</div>
				</div>
	</div>
	<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/echarts.min.js"></script>
       
      					<script type="text/javascript">
				var str=document.getElementById("prodata").value;
				
				var prodata=JSON.parse(str);
				//console.log(prodata);
				var propx=[];
				var propy=[];
				var seriesdata=[];
				for(var i=0;i<prodata.length;i++){
					propx.push(i);
				}
				for(var i=0;i<prodata[0].length;i++){
					var txtstr='服务'+(i+1);
					propy.push(txtstr);
					var temparr={
				            name:txtstr,
				            type:'line',
				            
				            data:[]
				    };
					for(var j=0;j<prodata.length;j++){
						
						temparr.data.push(parseFloat(prodata[j][i]));
						
					}
					seriesdata.push(temparr);
				}
				
				var dom = document.getElementById("container");
				var myChart = echarts.init(dom);
				var app = {};
				option = null;
				
				option = {
				    title: {
				        text: '稳态分布图'
				    },
				    tooltip: {
				        trigger: 'axis'
				    },
				    legend: {
				        data:[]
				    },
				    grid: {
				        left: '3%',
				        right: '4%',
				        bottom: '3%',
				        containLabel: true
				    },
				    toolbox: {
				        feature: {
				            saveAsImage: {}
				        }
				    },
				    xAxis: {
				        type: 'category',
				        boundaryGap: false,
				        data: []
				    },
				    yAxis: {
				        type: 'value',
				       
				    },
				    series: [
				    ]
				};
				option.legend.data=propy;
				option.xAxis.data=propx;
				option.series=seriesdata;
				//console.log(option);
				if (option && typeof option === "object") {
				    myChart.setOption(option, true);
				}
			
       </script>
	<script type="text/javascript">
	 	var ele=document.getElementById("myCanvas");
		var data=document.getElementById("data").value;
		var ctx=ele.getContext('2d');
		//带箭头的线
		function Line(x1,y1,x2,y2){
            this.x1=x1;
            this.y1=y1;
            this.x2=x2;
            this.y2=y2;
        }
        Line.prototype.drawWithArrowheads=function(ctx){

            // arbitrary styling
            ctx.strokeStyle="black";
            ctx.fillStyle="black";
            ctx.lineWidth=1;
            
            // draw the line
            ctx.beginPath();
            ctx.moveTo(this.x1,this.y1);
            ctx.lineTo(this.x2,this.y2);
            ctx.stroke();

            // draw the starting arrowhead
           /*  var startRadians=Math.atan((this.y2-this.y1)/(this.x2-this.x1));
            startRadians+=((this.x2>this.x1)?-90:90)*Math.PI/180;
            this.drawArrowhead(ctx,this.x1,this.y1,startRadians); */
            // draw the ending arrowhead
            var endRadians=Math.atan((this.y2-this.y1)/(this.x2-this.x1));
            endRadians+=((this.x2>this.x1)?90:-90)*Math.PI/180;
            this.drawArrowhead(ctx,this.x2,this.y2,endRadians);

        }
        Line.prototype.drawArcLine=function(ctx){
        	ctx.strokeStyle="black";
            ctx.fillStyle="black";
            ctx.lineWidth=1;          
            ctx.beginPath();
            ctx.moveTo(this.x1,this.y1);
            var L=Math.abs(this.x2-this.x1);
            var ver=(L/2)*Math.tan(60*Math.PI*2/360);
            ctx.arc(this.x1+L/2,this.y1+ver,ver/Math.sin(60*Math.PI*2/360),4*Math.PI/3,5*Math.PI/3);
            ctx.stroke();
            
            var endRadians=Math.atan((L/2)/(this.x2-this.x1));
            endRadians+=((this.x2>this.x1)?90:-90)*Math.PI/180;
            this.drawArrowhead(ctx,this.x2,this.y2,endRadians);
        }
        Line.prototype.drawOppositeArcLine=function(ctx){
        	ctx.strokeStyle="black";
            ctx.fillStyle="black";
            ctx.lineWidth=1;          
            ctx.beginPath();
            ctx.moveTo(this.x1,this.y1);
            var L=Math.abs(this.x2-this.x1);
            var ver=(L/2)*Math.tan(60*Math.PI*2/360);
            ctx.arc(this.x1-L/2,this.y1-ver,ver/Math.sin(60*Math.PI*2/360),Math.PI/3,2*Math.PI/3);
            ctx.stroke();
            
            var endRadians=Math.atan((L/2)/(this.x1-this.x2));
            endRadians+=((this.x2>this.x1)?90:-90)*Math.PI/180;
            this.drawArrowhead(ctx,this.x2,this.y2,endRadians);
        }
        Line.prototype.getL=function(){
        	var xx=(this.x2-this.x1)*(this.x2-this.x1);
        	var yy=(this.y2-this.y1)*(this.y2-this.y1);
        	return Math.sqrt(xx+yy)/1.73;
        }
        Line.prototype.drawArrowhead=function(ctx,x,y,radians){
            ctx.save();
            ctx.beginPath();
            ctx.translate(x,y);
            ctx.rotate(radians);
            ctx.moveTo(0,0);
            ctx.lineTo(5,20);
            ctx.lineTo(-5,20);
            ctx.closePath();
            ctx.restore();
            ctx.fill();
        }
        function StatusCircle(x,y,r,text){
        	this.x=x;
        	this.y=y;
        	this.r=r;
        	this.text=text;
        }
        StatusCircle.prototype.draw=function(ctx){
        	ctx.beginPath();
			ctx.arc(this.x,this.y,this.r,0,2*Math.PI);
			ctx.closePath();
			ctx.stroke();
			ctx.fillText(this.text,this.x-2*this.r/3,this.y);
        }
        function drawLamda(ctx,txt,x,y) {
			ctx.fillText(txt,x,y);
		}
        function drawStatus(ctx,num,r,darr){
        	var array=[];
        	ctx.font="16px Arial";
			var initX=100;
			var initY=200;
			var curX=initX;
			var curY=initY;
			for(var i=0;i<num;i++){
				var txt='S'+darr[i][1].split('.')[0];
				
				var status=new StatusCircle(curX,curY,r,txt);
				status.draw(ctx);
				array.push(status);
				if(i!=num)curX+=3*r;
				
			}
			//console.log(array);
			for(var i=0;i<num-1;i++){
				//var curstat=0;
				for(var j=3;j<darr[i].length;j++){
					if(parseFloat(darr[i][j])>0)
					{
						if(j==i+4){
							var lline=new Line(array[i].x+r,array[i].y,array[i+1].x-r,array[i+1].y);
							lline.drawWithArrowheads(ctx);
							drawLamda(ctx,darr[i][j],lline.x1+5,lline.y1-5);
						}else if(j>i+4){
							var tline=new Line(array[i].x,array[i].y-r,array[j-3].x,array[j-3].y-r);
							tline.drawArcLine(ctx);
							drawLamda(ctx,darr[i][j],tline.x1+10,tline.y1-10);
						}else if(j-3<i){
							var bline=new Line(array[i].x,array[i].y+r,array[j-3].x,array[j-3].y+r);
							console.log(i+" "+j);
							bline.drawOppositeArcLine(ctx);
							drawLamda(ctx,darr[i][j],bline.x1-10,bline.y1+10);
						}
					}	
					
				}
			}
			/* 
			for(var i=0;i<num;i++){
				var lline=new Line(array[i].x+r,array[i].y,array[i+1].x-r,array[i].y);
				lline.drawWithArrowheads(ctx);
				drawLamda(ctx,darr[i][0],lline.x1+5,lline.y1-5);
				var tline=new Line(array[i].x,array[i].y-r,array[num].x,array[num].y-r);
				tline.drawArcLine(ctx);
				drawLamda(ctx,darr[i][1],tline.x1+10,tline.y1-10);
				var bline=new Line(array[i].x,array[i].y+r,suc.x,suc.y-r);
				bline.drawWithArrowheads(ctx);
				drawLamda(ctx,darr[i][2],bline.x1,bline.y1+20);
			} */
			//return array;
		}
        /* var line=new Line(100,260,900,260);
        line.drawArcLine(ctx); */
        
       
		//console.log(data)
		var arr=JSON.parse(data);
		/* for(var i=0;i<arr.length;i++){
			arr[i].splice(0,1);
			var temp=parseFloat(arr[i][0])+parseFloat(arr[i][1]);
			arr[i].push((1-temp).toString());
		} */
		//console.log(arr);
		var statusR = 40;
		if(arr.length>6){
			statusR = 40-(arr.length-6)*5;
		}
		//console.log(ele.width)
		if(arr.length>10) {
			statusR = 15;
			ele.width += (arr.length-10)*40;
		}
		/* if(arr.length>24){
			$(".show_tab_content").css("width",ele.width+"px")
		} */
		drawStatus(ctx,arr.length,statusR,arr);
		
		/* ctx.beginPath();
		ctx.moveTo(150, 190);
		ctx.arcTo( 150 , 300 , 275 , 300 ,175);
		ctx.stroke(); */
		
		
		
	</script>
	
</body>
</html>