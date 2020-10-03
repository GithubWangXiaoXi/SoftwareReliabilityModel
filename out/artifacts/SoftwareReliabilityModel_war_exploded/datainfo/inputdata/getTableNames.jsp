<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page contentType="text/html;charset= utf-8"%>
<%@ page import="model.soar.*" %>

<jsp:useBean id="readtable" class="system.ReadTable" scope="page"></jsp:useBean>
<%
	String mode = request.getParameter("mode");	//提取数据模式
	String user = request.getParameter("user");	//提取用户名
	String password = request.getParameter("password");	//提取密码
	String choseDataBase = request.getParameter("choseDataBase");	//选择数据库
	String databasename = request.getParameter("tablename");
	//System.out.print("@@__@@"+databasename);
	String[] tablenames=readtable.getRealTableName(user,password,choseDataBase,databasename);
	//System.out.println("表名长度："+tablename.length);
	List<String> list =new ArrayList();
	for(String table:tablenames){
		list.add(table);
	}
	String result=Utils.convertObjectToString(list);
	response.getWriter().print(result);
%>

