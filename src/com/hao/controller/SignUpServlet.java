package com.hao.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Bean.DBBean;

public class SignUpServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// 处理注册信息
	public void doGet(HttpServletRequest request,  
            HttpServletResponse response)  
            throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		String name=request.getParameter("name");
		String email=request.getParameter("email");
		String password=request.getParameter("password");		
		// System.out.println(name+email+password);
		// 插入到表中
		String sql="insert into usermanager value('"+name+"','"+password+"','"+email+"');";
		DBBean dbBean=new DBBean();
		dbBean.executeUpdate(sql);
		response.sendRedirect("/Myzk/log.jsp");
		// response.setHeader("refresh", "0;url=log.jsp");
	}
	public void doPost(HttpServletRequest request,  
            HttpServletResponse response)  
            throws ServletException, IOException {  
  
        this.doGet(request, response);  
          
    }  
}
