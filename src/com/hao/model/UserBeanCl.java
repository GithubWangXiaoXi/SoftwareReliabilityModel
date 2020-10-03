package com.hao.model;

import java.sql.*;  
import java.util.*;  
public class UserBeanCl {  
    //��֤�û��Ƿ�Ϸ�  
    private Statement sm=null;  
    private ResultSet rs=null;  
    private Connection ct=null;  
    private int pageSize=3;  
    private int rowCount=0;  
    private int pageCount=0;   
    //�޸��û�  
    public boolean ubdateUser(String userId,String name,String passwd,String email,String grade)  
    {  
        boolean b=false;  
        try{  
            ct=new ConnDB().getConn();  
            sm=ct.createStatement();  
              
            int a=sm.executeUpdate("update usermanager set username='"+name+"',password='"+passwd+"',email='"+email+"', grade='"+grade+"' where userId='"+userId+"'");  
            if(a==1)  
                b=true;  
        }catch(Exception e){  
            e.printStackTrace();  
        }finally{  
            this.close();  
        }  
        return b;  
    }  
      
    //����û�  
    /** 
     *  
     * @param name ���û��� 
     * @param passwd������ 
     * @param email������ 
     * @param grade������ 
     * @return boolean: if true ��ӳɹ� else ʧ��  
     */  
    public boolean addUser(String name,String passwd,String email,String grade)  
    {  
        boolean b=false;  
        /*int id=1;
        for(int i = 0;i<10000000;i++){
        	id++;
        }*/
        try{  
            ct=new ConnDB().getConn();  
            sm=ct.createStatement();  
              
            int a=sm.executeUpdate("insert into usermanager(username,password,email,grade) values('"+name+"','"+passwd+"','"+email+"','"+grade+"') ");  
  
            if(a==1)  
                b=true;  
        }catch(Exception e){  
            e.printStackTrace();  
        }finally{  
            this.close();  
        }  
        return b;  
          
    }  
    //ɾ���û�  
    public boolean delUserById(String id)  
    {  
        boolean b=false;  
        try{  
            ct=new ConnDB().getConn();  
            sm=ct.createStatement();  
            int a=sm.executeUpdate("delete from usermanager where userId='"+id+"'");  
            if(a==1)  
                b=true;  
        }catch(Exception e){  
            e.printStackTrace();  
        }finally{  
            this.close();  
        }  
        return b;  
    }  
      
    //������ҳ��  
    public int getPageCount()  
    {  
        try{  
            ct=new ConnDB().getConn();  
            sm=ct.createStatement();  
            rs=sm.executeQuery("select count(*) from usermanager");  
            if(rs.next())  
            {  
                rowCount=rs.getInt(1);  
            }  
          
            pageCount=rowCount%pageSize==0?rowCount/pageSize:rowCount/pageSize+1;  
  
        }catch(Exception e){  
            e.printStackTrace();  
              
        }finally{  
            this.close();  
        }  
          
          
  
        return pageCount;  
    }  
    //�õ���Ҫ��ʾ���û���Ϣ  
    public ArrayList<UserBean>  getUsersByPage(int pageNow)  
    {  
  
        ArrayList<UserBean> al=new ArrayList<UserBean>();  
        try{  
            ct=new ConnDB().getConn();  
            sm=ct.createStatement();  
            //��ѯ����Ҫ��ʾ�ļ�¼  
            rs=sm.executeQuery("select * from usermanager limit "+(pageNow-1)*pageSize+","+pageSize+"");  
            while(rs.next())  
            {  
                UserBean ub=new UserBean();  
                ub.setUserId(rs.getInt(1));  
                ub.setUsername(rs.getString(2));  
                ub.setPasswd(rs.getString(3));  
                ub.setEmail(rs.getString(4));  
                ub.setGrade(rs.getInt(5));  
                al.add(ub);       
            }  
        }catch(Exception  e){  
            e.printStackTrace();  
        }finally{  
            this.close();  
        }  
          
        return al;  
          
    }  
    //�ر���Դ  
    public void close()  
    {  
        //�ر���Դ  
        try{  
            if(rs!=null)  
            {  
                rs.close();  
                rs=null;  
            }  
            if(sm!=null)  
            {  
                sm.close();  
                sm=null;  
            }  
            if(ct!=null)  
            {  
                ct.close();  
                ct=null;  
            }  
              
        }catch(Exception e){  
            e.printStackTrace();  
        }  
    }  
    public boolean checkUser(String u,String p)  
    {  
        boolean b=false;  
        try{  
            ct=new ConnDB().getConn();  
            sm=ct.createStatement();  
            rs=sm.executeQuery("select password from usermanager where username='"+u+"'");  
            if(rs.next())  
            {  
                  
                if(rs.getString(1).equals(p))  
                {  
                    //�Ϸ�  
                    b=true;  
                }  
                  
            }  
              
        }catch(Exception e){  
            e.printStackTrace();  
        }finally{  
            this.close();  
        }  
        return b;  
    }  
  
}