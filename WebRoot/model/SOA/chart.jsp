<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="height: 100%">
   <head>
       <meta charset="utf-8">
   </head>
   <body style="height: 100%; margin: 0">
       <div id="container" style="height: 100%"></div>
       <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/echarts.min.js"></script>
       
       <script type="text/javascript">
			window.onload=function(){
				var dom = document.getElementById("container");
				var myChart = echarts.init(dom);
				var app = {};
				option = null;
				option = {
				    title: {
				        text: '折线图堆叠'
				    },
				    tooltip: {
				        trigger: 'axis'
				    },
				    legend: {
				        data:['邮件营销','联盟广告','视频广告','直接访问','搜索引擎']
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
				        data: ['周一','周二','周三','周四','周五','周六','周日']
				    },
				    yAxis: {
				        type: 'value'
				    },
				    series: [
				        {
				            name:'邮件营销',
				            type:'line',
				            stack: '总量',
				            data:[0.03,0.03,0.03,0.03,0.03,0.03,0.03]
				        },
				        {
				            name:'联盟广告',
				            type:'line',
				            stack: '总量',
				            data:[0.04,0.04,0.04,0.04,0.04,0.04,0.04]
				        },
				        {
				            name:'视频广告',
				            type:'line',
				            stack: '总量',
				            data:[0.04,0.04,0.04,0.04,0.04,0.04,0.04]
				        },
				        {
				            name:'直接访问',
				            type:'line',
				            stack: '总量',
				            data:[0.04,0.04,0.04,0.04,0.04,0.04,0.04]
				        },
				        {
				            name:'搜索引擎',
				            type:'line',
				            stack: '总量',
				            data:[0.04,0.04,0.04,0.04,0.04,0.04,0.04]
				        }
				    ]
				};
				;
				if (option && typeof option === "object") {
				    myChart.setOption(option, true);
				}
			}
       </script>
   </body>
</html>