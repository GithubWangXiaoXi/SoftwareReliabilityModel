<%@ page import="java.sql.*" language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
</head>
<body background="IMAGE\login.png"
  style=" background-repeat:no-repeat ;
  background-size:100%;
  background-attachment: fixed;">
    <center>  
    <br><br> 
    <font face="楷体" size="6" color="#000" >登录界面</font> 
    
     <br><br> 
      <!--   <h1 style="color:red">登录</h1> -->
            <form id="indexform" name="indexForm" action="indexcheck.jsp" method="post">
              
                <div>
                        <div align = "center">
                        	 账号：
                           <input type="text" name="username" id="username" />  
                           <br><br>
                         </div> 
                       <div align = "center">
                        	密码：
                           <input type="password" name="password" id="password" />
                         <br><br>
                      </div>  
                 </div>
                <div  align = "center" >
                <input type="submit" value="登录" style="color:#BC8F8F">
                <!-- </div>
                <font style="width:0%;padding:0;margin:0;float:left;box-sizing:border-box;" style="width:20%;padding:0;margin:0;float:left;box-sizing:border-box;"> -->
                <input type="button" value="取消 " style="color:#BC8F8F">
                </div>
                <br><br>
               <!--  <font><br>请点击<a href="register.jsp">注册</a>! 
                </font> -->
            </form>
            
            
    </center>
</body>
</html>