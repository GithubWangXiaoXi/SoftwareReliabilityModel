<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>  
<%  
String path = request.getContextPath();  
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
%>  
  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">  
<html>  
  <head>  
    <base href="<%=basePath%>">  
      
    <title>My JSP 'addUser.jsp' starting page</title>  
      
    <meta http-equiv="pragma" content="no-cache">  
    <meta http-equiv="cache-control" content="no-cache">  
    <meta http-equiv="expires" content="0">      
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">  
    <meta http-equiv="description" content="This is my page">  
    <link rel="stylesheet" type="text/css" href="../../CSS/buttons.css"> 
 
  </head>  
    
  <body bgcolor="#CED3FE">  
     <!--  <img  src="img/th.png"/>   -->
<center>  
   
   <h2>删除用户信息</h2>  
   <form action="UsersClServlet?flag=deluser" method="post">  
   <table border="1" height="5%" width="30%">  
   <tr><td bgcolor="silver">用户id</td><td><input style="width:100%;height:30px; font-size: 18px" type="text" type="text" name="userId"/></td></tr>  
  
  <tr><td><input type="submit" style="width:100% " class="button button-pill button-primary" value="删除"></td>
  <td><input  type="reset" style="width:100% " class="button button-pill button-primary" value="重置"></td></tr>  
   </table>  
   </form>  
   
    </center>  
    <!-- <img  src="img/logo.png" />   -->
  </body>  
</html>  