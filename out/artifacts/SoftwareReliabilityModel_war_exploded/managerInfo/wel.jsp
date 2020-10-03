<%@ page language="java" import="java.util.*,java.sql.*,com.hao.model.*" pageEncoding="UTF-8"%>  
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
            + request.getServerName() + ":" + request.getServerPort()  
            + path + "/";  
%>  
  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">  
<html>  
<head>  
<base href="<%=basePath%>">  
  
<title>My JSP 'wel.jsp' starting page</title>  
  
<meta http-equiv="pragma" content="no-cache">  
<meta http-equiv="cache-control" content="no-cache">  
<meta http-equiv="expires" content="0">  
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">  
<meta http-equiv="description" content="This is my page">  

    <link rel="stylesheet" type="text/css" href="maintab.css"> 
   
<script type="text/javascript">  
    <!--   
    function askdel()  
    {  
        return window.confirm("你真的要删除吗？");  
    }  
    -->  
</script>  
<style type="text/css">
table,td,th
  {
  border:1px solid black;
  }

table
  {
  width:50%;
  }

th
  {
  height:50px;
  }
</style>

</head>  
  
<body bgcolor="#CED#FE">  
   <!--  <img  src="img/th.png"/>  --> 
    <center>  
<%-- <%  
//防止用户非法登录  
    String u=(String)session.getAttribute("myName") ;  
    if(u==null)  
    {  
        response.sendRedirect("log.jsp?err=1");  
        return ;  
    }  
 %>  
    登录成功！哈哈<%=u%><br>   --%>
  <!--   <a href="log.jsp">返回重新登录</a> -->  <!-- <a href="./systemManager/wel.jsp">返回主界面</a>  --> 
    <hr>  
    <h2>用户信息列表</h2>  
    <%  
          
        //UserBeanCl ubc=new  UserBeanCl();  
        //ArrayList<UserBean> al=ubc.getUsersByPage(pageNow);  
        ArrayList<UserBean> al=(ArrayList<UserBean>)request.getAttribute("result");  
          
  
        %>  
            <table border="1" >  
            <tr bgcolor="#CED3FE"><td>用户ID</td><td>用户名</td>  
            <td>密码</td><td>电子邮件</td><td>级别</td>  
            <td>修改用户</td><td>删除用户</td></tr>  
        <%  
                String []color={"silver","silver"};  
                for(int i=0;i<al.size();i++)  
                {  
                    UserBean ub=(UserBean)al.get(i);  
                    %>  
                            <tr bgcolor=<%=color[i%2]%>><td><%=ub.getUserId() %></td><td><%=ub.getUsername() %></td>  
                            <td><%=ub.getPasswd() %></td><td><%=ub.getEmail() %></td><td><%=ub.getGrade() %></td>  
                            <td><a href="./managerInfo/updateuser.jsp?userId=<%=ub.getUserId() %>&username=<%=ub.getUsername()%>&password=<%=ub.getPasswd()%>  
                            &email=<%=ub.getEmail()%>&grade=<%=ub.getGrade()%>">修改</a></td><td>  
                            <a  onclick="return askdel();" href="UsersClServlet?flag=deluser&&userId=<%=ub.getUserId()%>">删除</a></td>  
                            </tr>  
                       
                    <%  
                }  
             %>  
            </table>  
            <%   
            int pageNow=((Integer)request.getAttribute("pageNow")).intValue();  
            if(pageNow!=1)  
            {  
            //显示上一页  
                out.println("<a href=UsersClServlet?pageNow="+(pageNow-1)+"&&flag=cutpage>上一页</a>");  
            }  
            int pageCount=((Integer)request.getAttribute("pageCount")).intValue();  
            //显示超链接  
            for(int i=1;i<=pageCount;i++)  
            {  
                out.println("<a href=UsersClServlet?pageNow="+i+"&&flag=cutpage> ["+i+"]</a>");  
            }  
            if(pageNow!=pageCount)  
            {  
            //显示下一页  
                out.println("<a href=UsersClServlet?pageNow="+(pageNow+1)+"&&flag=cutpage>下一页</a>");  
            }  
            %>  
        <%  
    %>  
    </center>  
    <hr>  
      <!--  <img  src="img/logo.png" />   -->
</body>  
</html>  