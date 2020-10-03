<%@ page import="java.sql.*" language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link rel="stylesheet" type="text/css" href="jquery-easyui-1.5/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="jquery-easyui-1.5/themes/icon.css">
<link rel="stylesheet" type="text/css" href="jquery-easyui-1.5/themes/universal.css">
<link rel="stylesheet" type="text/css" href="jquery-easyui-1.5/themes/buttons.css">
<script type="text/javascript" src="jquery-easyui-1.5/jquery.min.js"></script>
<script type="text/javascript" src="jquery-easyui-1.5/jquery.easyui.min.js"></script>
<script type="text/javascript" src="jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
</head>
<body background="IMAGE\log.jpg"
  style=" background-repeat:no-repeat ;
  background-size:100%;
  background-attachment: fixed;">
    <center>  
            <form id="indexform" name="indexForm" action="indexcheck.jsp" method="post" >
                 <div style="margin:450px 0 0 10px">
                     <font face="黑体" size="6" color="#000" >用户登录</font>
                     <br></br>
         			 <table width="400" height = "180" border="3" bordercolor="#F0FFFF">  		
         			 	<tr> 		  
         			 		<th> <font face="黑体" size="5" color="#000" > 账   户：</font></th> 
         			 		<td><input style="width:180px;height:32px;margin:10px;" type="text" name="username"  value = "请输入用户名" maxlength = "80" onfocus = "if(this.value == '请输入用户名') this.value =''"></td> 	    
         			 	</tr> 	   
         			 	<tr> 		  
         			 		<th> <font face="黑体" size="5" color="#000" > 密   码：</font></th> 
         			 		<td><input style="width:180px;height:32px;margin:10px;" type="password" name="password"  value = "请输入密码" maxlength = "80" onfocus = "if(this.value == '请输入密码') this.value =''" ></td> 	   
         			  </tr> 	   
         			  <tr> 	      
         		  		  <th colspan = "2" align = "center"> 	<font face="黑体" size="5" color="#FFF" > <input style="width:120px;height:35px" type="submit" name="submit" value="登    录"> 		    <input type="button" style="width:120px;height:35px" value="返   回" 	> </font>    </th> 	   
         			   </tr> 	  
         		   </table>
                </div>
                <br><br>
               <!--  <font><br>请点击<a href="register.jsp">注册</a>! 
                </font> -->
            </form>
            
            
    </center>
</body>
</html>