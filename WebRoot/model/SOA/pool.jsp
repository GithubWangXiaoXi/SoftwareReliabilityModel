<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
    <%@ page import="model.soar.Utils" %>
<jsp:useBean id="inputdata" class="system.InputData" scope="page"></jsp:useBean>
<jsp:useBean id="contrastdata" class="system.ContrastData" scope="page"></jsp:useBean>
<jsp:useBean id="parse" class="model.soar.ParseJsonArr" scope="page"></jsp:useBean>
<jsp:useBean id="singleServie" class="model.soar.SingleServiceModel" scope="page"></jsp:useBean>
<jsp:useBean id="poolmodel" class="model.soar.ServicePoolModel" scope="page"></jsp:useBean>
 
 <%
    

/* 	int dimension = inputdata.getdimension();	
	double[][] data_train = new double[dimension][];	//将当前数据训练集读入一份到页面
	for(int i=0;i<dimension;i++)
	{
		data_train[i] = inputdata.getdata_train(i+1).clone();
	}
	double[][] temp=Utils.transferMartix(data_train);
	String json=Utils.reverseParse(temp);
	System.out.print(json); */

 	 String tdata="";
 	tdata=request.getParameter("tdata");
	String snum="0";
	snum=request.getParameter("snum"); 
	poolmodel.init_servicePool(Integer.parseInt(snum), parse.execParse(tdata));
	double rsp=0;
	rsp=poolmodel.calcRsp();
	rsp=(double)Math.round(rsp*1000)/1000;
	double lamda=0;
	lamda=poolmodel.calcLamda();
    %>
<!DOCTYPE html>
<html>
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
		<script type="text/javascript" src="../../JS/onload.js" charset="gb2312"></script>	
		<script type="text/javascript" src="../../JS/tab.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/waitload.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/addsubmodel.js" charset="gb2312"></script>
		<script type="text/javascript" src="../../JS/button/combination/validate_Combination.js" 
  		charset="gb2312"></script>
	</head>
	<body onload="onload()">
	
	<input type="hidden" id="data" value='<%=tdata %>'>
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
					<div style="width: 800px;margin-left: 100px;">
						<h2>基于当前失效数据，可构建该服务池的DTMC模型如下</h2>
						<canvas id="myCanvas" width="1200" height="800" style=""></canvas>
		
					</div>
				</div>
				<div id="pool_con2" style="padding-left: 20px;">
					<h3>方程求解</h3>
					<p>采用稳态分析方法求解。即设其稳态分布为η= (Z1 ,Z2 ,… ,ZN ,ZC ,ZF ) , 则有η= ηP </p>
					<p> 再联立全体稳态概率和为 1的约束条件可得如下方程组:</p>
					<img alt="" src="../../IMAGE/SOA/fangcheng.JPG">
					<h3>服务池可靠性求解</h3>
					<img alt="" src="../../IMAGE/SOA/f4.JPG">
					<img alt="" src="../../IMAGE/SOA/f5.JPG">
					<h3>&nbsp;&nbsp;&nbsp;该服务池整体失效率 λ = <%=lamda %></h3>
					<h3>&nbsp;&nbsp;&nbsp;该服务池整体可靠性 Rsp = <%=rsp %></h3>
					
				</div>
			</div>
	
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
			ctx.fillText(this.text,this.x-this.r/2,this.y);
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
			for(var i=0;i<num+1;i++){
				var txt='';
				if(i!=num){
					txt="服务"+(i+1);
				}else{
					txt="失败";
				}
				var status=new StatusCircle(curX,curY,40,txt);
				status.draw(ctx);
				array.push(status);
				if(i!=num)curX+=4*r;
				
			}
			curX=(curX+initX)/2;
			curY=curY+180;
			var suc=new StatusCircle(curX,curY,40,"成功");
			suc.draw(ctx);
			array.push(suc);
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
			}
			//return array;
		}
        /* var line=new Line(100,260,900,260);
        line.drawArcLine(ctx); */
        
       
		//console.log(data)
		var arr=JSON.parse(data);
		for(var i=0;i<arr.length;i++){
			arr[i].splice(0,1);
			var temp=parseFloat(arr[i][0])+parseFloat(arr[i][1]);
			var res=(1-temp).toFixed(3);
			arr[i].push((res).toString());
		}
		console.log(arr);
		drawStatus(ctx,arr.length,40,arr);
		
		/* ctx.beginPath();
		ctx.moveTo(150, 190);
		ctx.arcTo( 150 , 300 , 275 , 300 ,175);
		ctx.stroke(); */
		
		
		
	</script>
</body>
</html>