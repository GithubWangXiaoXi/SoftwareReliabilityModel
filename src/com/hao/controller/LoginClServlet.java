package com.hao.controller;

import java.io.IOException;  
//import java.io.PrintWriter;  
import java.util.ArrayList;  
  
import javax.servlet.ServletException;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
  
import com.hao.model.*;  
public class LoginClServlet extends HttpServlet {  
  
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/** 
     * The doGet method of the servlet. <br> 
     * 
     * This method is called when a form has its tag value method equals to get. 
     *  
     * @param request the request send by the client to the server 
     * @param response the response send by the server to the client 
     * @throws ServletException if an error occurred 
     * @throws IOException if an error occurred 
     */  
    public void doGet(HttpServletRequest request,  
            HttpServletResponse response)  
            throws ServletException, IOException {  
        //得到用户名和密码  
        String u=request.getParameter("username");  
        String p=request.getParameter("passname");  
        UserBeanCl ubc=new UserBeanCl();  
        //System.out.println("使用servlet");  
        if(ubc.checkUser(u, p))  
        {  
            ArrayList<UserBean> al=ubc.getUsersByPage(1);  
            int pageCount=ubc.getPageCount();  
            request.setAttribute("result", al);  
            request.setAttribute("pageCount", pageCount);  
            request.setAttribute("pageNow", 1);  
            //将用户名放入session,以备后用  
            request.getSession().setAttribute("myName", u);  
              
            request.getRequestDispatcher("usermanager.jsp").forward(request, response);  
  
        }  
        else  
        {  
            request.getRequestDispatcher("log.jsp").forward(request, response);  
        }  
    }  
  
    /** 
     * The doPost method of the servlet. <br> 
     * 
     * This method is called when a form has its tag value method equals to post. 
     *  
     * @param request the request send by the client to the server 
     * @param response the response send by the server to the client 
     * @throws ServletException if an error occurred 
     * @throws IOException if an error occurred 
     */  
    public void doPost(HttpServletRequest request,  
            HttpServletResponse response)  
            throws ServletException, IOException {  
  
        this.doGet(request, response);  
          
    }  
  
}  