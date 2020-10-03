package com.hao.controller;

import java.io.IOException;  
import java.util.ArrayList;  
  
import javax.servlet.ServletException;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
  
import com.hao.model.*;  
public class UsersClServlet extends HttpServlet {  
  
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
        //获得标识位  
        String flag=request.getParameter("flag");  
          
        if(flag.equals("cutpage"))  
        {  
            try{  
                int pageNow=Integer.parseInt(request.getParameter("pageNow"));  
                UserBeanCl ubc=new UserBeanCl();  
                  
                ArrayList<UserBean> al=ubc.getUsersByPage(pageNow);  
                int pageCount=ubc.getPageCount();  
                request.setAttribute("result", al);  
                request.setAttribute("pageCount", pageCount);  
                request.setAttribute("pageNow", pageNow);  
                  
                request.getRequestDispatcher("/managerInfo/wel.jsp").forward(request, response);  
                  
            }catch (Exception e){  
                e.printStackTrace();  
            }  
        }  
        else if(flag.equals("deluser"))  
        {  
            //删除用户  
            String userId=request.getParameter("userId");  
            UserBeanCl ubc=new UserBeanCl();  
            if(ubc.delUserById(userId))  
            {  
                //删除成功  
                request.getRequestDispatcher("/managerInfo/suc.jsp").forward(request, response);  
                  
            }  
            else  
            {  
                //删除失败  
                request.getRequestDispatcher("/managerInfo/err.jsp").forward(request, response);  
            }  
              
        }  
        else if(flag.equals("adduser"))  
        {  
            //添加用户  
            //得到用户输入的信息  
            String name=request.getParameter("username");  
            String password=request.getParameter("password");  
            String email=request.getParameter("email");  
            String grade=request.getParameter("grade");  
            UserBeanCl ubc=new UserBeanCl();  
            if( ubc.addUser(name, password, email, grade)  )  
            {  
                //添加成功  
                request.getRequestDispatcher("/managerInfo/suc.jsp").forward(request, response);  
                  
            }  
            else  
            {  
                //添加失败  
                request.getRequestDispatcher("/managerInfo/err.jsp").forward(request, response);  
            }  
              
        }  
        else if(flag.equals("updateuser"))  
        {  
            //修改用户  
            //得到用户输入的信息  
            String userId=request.getParameter("userId");  
            String name=request.getParameter("username");  
            String password=request.getParameter("password");  
            String email=request.getParameter("email");  
            String grade=request.getParameter("grade");  
            UserBeanCl ubc=new UserBeanCl();  
            if( ubc.ubdateUser(userId,name, password, email, grade)  )  
            {  
                //修改成功  
                request.getRequestDispatcher("/managerInfo/suc.jsp").forward(request, response);  
                  
            }  
            else  
            {  
                //修改失败  
                request.getRequestDispatcher("/managerInfo/err.jsp").forward(request, response);  
            }  
              
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