package com.hao.model;

import java.sql.*;  
public class ConnDB {  
    private Connection ct=null;  
    public Connection getConn()  
    {  
        try{  
            Class.forName("com.mysql.jdbc.Driver");  
            ct=DriverManager.getConnection("jdbc:mysql://localhost/failuredata/user?user=root&password=zl33210");  
        }catch(Exception e){  
            e.printStackTrace();  
        }  
        return ct;  
          
    }  
  
}  
