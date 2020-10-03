package system;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class ReadTable {
	private String[][] readdata;
	int columnCount = 0;// 鍒楁暟
	int sumCount = 0;// 鏉℃暟
	StringBuffer columnName = new StringBuffer("");// 鍒楀悕鏁扮粍
	private String tablename="";
	// 杩炴帴鏁版嵁搴�
	private static final String dbName="failuredata";
	private static final String dbuserName="root";
	private static final String dbpassword="123456";
	public Connection getConnection(String user, String password,
			String choseDataBase) {
		Connection con = null;
		String url = "";
		String classforName = "";// 鍔犺浇椹卞姩
		if ("mysql".equals(choseDataBase)) {
			classforName = "com.mysql.jdbc.Driver";
			url = "jdbc:mysql://127.0.0.1/failuredata";
		} else if ("oracle".equals(choseDataBase)) {
			classforName = "oracle.jdbc.driver.OracleDriver";
			url = "jdbc:oracle:thin:@127.0.0.1:1521:ORCL";
		}else if("sqlserver".equals(choseDataBase)){
			classforName="com.microsoft.jdbc.sqlserver.SQLServerDriver";
			url="jdbc:microsoft:sqlserver://127.0.0.1/failuretime";
		}

		try {
			Class.forName(classforName);// 鍔犺浇Oracle椹卞姩绋嬪簭
			System.out.println("寮�濮嬪皾璇曡繛鎺ユ暟鎹簱锛�");
			con = DriverManager.getConnection(url, user, password);// 鑾峰彇杩炴帴
			System.out.println("杩炴帴鎴愬姛锛�");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return con;
	}
	public Connection getConnection2(String user, String password,
			String choseDataBase,String database) {
		Connection con = null;
		String url = "";
		String classforName = "";// 鍔犺浇椹卞姩
		if ("mysql".equals(choseDataBase)) {
			classforName = "com.mysql.jdbc.Driver";
			url = "jdbc:mysql://127.0.0.1/"+database;
		} else if ("oracle".equals(choseDataBase)) {
			classforName = "oracle.jdbc.driver.OracleDriver";
			url = "jdbc:oracle:thin:@127.0.0.1:1521:ORCL";
		}else if("sqlserver".equals(choseDataBase)){
			classforName="com.microsoft.jdbc.sqlserver.SQLServerDriver";
			url="jdbc:microsoft:sqlserver://127.0.0.1/failuretime";
		}

		try {
			Class.forName(classforName);// 鍔犺浇Oracle椹卞姩绋嬪簭
			//System.out.println("寮�濮嬪皾璇曡繛鎺ユ暟鎹簱锛�");
			con = DriverManager.getConnection(url, user, password);// 鑾峰彇杩炴帴
			//System.out.println("杩炴帴鎴愬姛锛�");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return con;
	}
	public  Connection getconnection(String user, String password,String databaseName) {
		Connection connection=null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url="jdbc:mysql://127.0.0.1/"+databaseName;
			connection=DriverManager.getConnection(url, user, password);
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		
		return connection;
	}
	public void updateDefaultSet(String setName,int percent) throws SQLException {
		Connection con=getconnection(dbuserName, dbpassword, dbName);
		con.setAutoCommit(false);
		Statement statement=con.createStatement();
		String sql="select * from dataset where setname='"+setName+"';";
		//System.out.println(sql);
		ResultSet rs=statement.executeQuery(sql);
		String tablename="",desc="";
		while(rs.next()) {
			 tablename=rs.getString(2);
			 desc=rs.getString(3);
		}
		//System.out.println(tablename+"____"+desc);
		sql="delete from dataset where setname='"+setName+"';";
		statement.executeUpdate(sql);
		
		sql="insert into dataset values('"+setName+"','"+tablename+"','"+desc+"',"+percent+",null,1);";
		statement.executeUpdate(sql);
		con.commit();
		rs.close();
		statement.close();
		con.close();
	}
	public void updateDefaultSet2(String setName,int percent) throws SQLException {
		Connection con=getconnection(dbuserName, dbpassword, dbName);
		con.setAutoCommit(false);
		Statement statement=con.createStatement();
		String sql="select * from dataset where setname='"+setName+"';";
		//System.out.println(sql);
		ResultSet rs=statement.executeQuery(sql);
		String tablename="",desc="";
		while(rs.next()) {
			 tablename=rs.getString(2);
			 desc=rs.getString(3);
		}
		//System.out.println(tablename+"____"+desc);
		sql="delete from dataset where setname='"+setName+"';";
		statement.executeUpdate(sql);
		
		sql="insert into dataset values('"+setName+"','"+tablename+"','"+desc+"',"+percent+",null,0);";
		statement.executeUpdate(sql);
		con.commit();
		rs.close();
		statement.close();
		con.close();
	}
	public void setData(String setname,String setdesc,int percentage,int datatype) throws SQLException {
		Connection con=getconnection(dbuserName, dbpassword, dbName);
		Statement statement=con.createStatement();
		String sql="insert into dataset value('"+setname+"','"+getCurrTableName()+"','"+setdesc+"',"+percentage+",null,"+datatype+");";
		// System.out.println("#####"+sql);
		statement.executeUpdate(sql);
		con.close();
		statement.close();
	}
	public ArrayList<DataSet> getDataSet(int datatype) throws SQLException {
		Connection con=getconnection(dbuserName, dbpassword, dbName);
		
		Statement statement=con.createStatement();
		
		ResultSet rs=statement.executeQuery("select * from dataset where datatype = "+datatype);
		ArrayList<DataSet> setList=new ArrayList<>();
		
		while(rs.next()) {
			DataSet ds=new DataSet();
			ds.setSetname(rs.getString(1));
			String tname=rs.getString(2);
			ds.setSetinfo(rs.getString(3));
			ds.setPercent(rs.getInt(4));
			Statement statement2=con.createStatement();
			ResultSet rs2=statement2.executeQuery("select count(*) count from "+tname+";");
			int total=0;
			while(rs2.next()) {
				total=rs2.getInt("count");//鑾峰緱鎬绘潯鏁�				
			}
			Statement statement3=con.createStatement();
			rs2=statement3.executeQuery("select * from "+tname);
			int column = rs2.getMetaData().getColumnCount();
			String[] colnames=new String[column];
			for(int i=0;i<column;i++) {
				String colname=rs2.getMetaData().getColumnName(i+1);
				colnames[i]=colname;
			}
			ds.setColname(colnames);
			double[][] data=new double[total][column];
			int index=0;
			while(rs2.next()) {
				for(int i=0;i<column;i++) {
					data[index][i]= Double.parseDouble(rs2.getString(i+1));
				}
				index++;
			}
			double[][] newdata=new double[column][total];
			for(int i=0;i<column;i++) {
				for(int j=0;j<total;j++) {
					newdata[i][j]=data[j][i];
				}
			}
			ds.setData(newdata);
			setList.add(ds);
			rs2.close();
			statement2.close();
		}	
		rs.close();
		statement.close();
		return setList;
	}
	public void WriteData(Connection con,String tablename) {
		//System.out.println("####鍑嗗鍐欏叆鏁版嵁####");
		Connection newcon=getconnection(dbuserName, dbpassword, dbName);
		setCurrTableName(tablename);
		String cretableSql="show create table "+tablename;
		Statement statement = null,statement2=null;
		ResultSet resultSet = null;
		try {
			statement=con.createStatement();
			resultSet=statement.executeQuery(cretableSql);
			while(resultSet.next()) {
				cretableSql=resultSet.getString(2);
				// System.out.println("###"+cretableSql);
			}
			//鎵ц寤鸿〃璇彞
			statement2=newcon.createStatement();
			statement2.executeUpdate("drop table if exists  "+tablename+";");
			statement2.executeUpdate(cretableSql);
			//鏌ヨ婧愯〃鏁版嵁
			resultSet=statement.executeQuery("select * from "+tablename);
			int column = resultSet.getMetaData().getColumnCount();// 鑾峰緱鍒楁暟
			while(resultSet.next()) {
				String insql="insert into "+tablename+" value(";
				for(int i=1;i<column;i++) {
					 insql+=resultSet.getString(i)+",";
				}
				insql+=resultSet.getString(column)+");";
				
				//System.out.println("###"+insql);
				statement2.executeUpdate(insql);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			//System.out.println("###鍐欏叆鏁版嵁瀹屾瘯");
			try {
				statement.close();
				resultSet.close();
				newcon.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
	}
	// 杩斿洖鍒楁暟
	public int readtable(String tablename, String user, String password,
			String choseDataBase) {
		Connection con = getConnection(user, password, choseDataBase);
		WriteData(con, tablename);
		setCurrTableName(tablename);
		Statement statement = null;
		ResultSet resultSet = null;
		
		String sql = "select * from " + tablename;//
		String sqlCount = "select count(*) count from " + tablename;// 鏌ヨ鏉℃暟
		try {
			statement = con.createStatement();
			resultSet = statement.executeQuery(sqlCount);
			while (resultSet.next()) {
				sumCount = resultSet.getInt("count");
			}
			readdata = new String[sumCount][];

			resultSet = statement.executeQuery(sql);
			columnCount = resultSet.getMetaData().getColumnCount();// 鑾峰緱鍒楁暟
			for (int j = 1; j <= columnCount; j++) {
				// 鑾峰緱鍒楀悕
				String name = resultSet.getMetaData().getColumnName(j);
				if ("".equals(columnName.toString())) {
					columnName.append(name);
				} else {
					columnName.append("," + name);
				}
			}
			int i = 0;
			while (resultSet.next()) {
				String a = null;
				for (int j = 1; j <= columnCount; j++) {
					// 鑾峰緱鍒楀悕
					if (a == null) {
						a = resultSet.getString(j);
					} else {
						a = a + "," + resultSet.getString(j);
					}

				}
				readdata[i++] = a.split(",");
			}

			while (resultSet.next()) {
				sumCount = resultSet.getInt("count");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (resultSet != null) {
					resultSet.close();
				}
				if (statement != null) {
					statement.close();
				}
				if (con != null) {
					con.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return columnCount;
	}
	public int readtable2(String tablename, String user, String password,
			String choseDataBase,String database) {
		Connection con = getConnection2(user, password, choseDataBase,database);
		WriteData(con, tablename);
		setCurrTableName(tablename);
		Statement statement = null;
		ResultSet resultSet = null;
		
		String sql = "select * from " + tablename;//
		String sqlCount = "select count(*) count from " + tablename;// 鏌ヨ鏉℃暟
		try {
			statement = con.createStatement();
			resultSet = statement.executeQuery(sqlCount);
			while (resultSet.next()) {
				sumCount = resultSet.getInt("count");
			}
			readdata = new String[sumCount][];

			resultSet = statement.executeQuery(sql);
			columnCount = resultSet.getMetaData().getColumnCount();// 鑾峰緱鍒楁暟
			for (int j = 1; j <= columnCount; j++) {
				// 鑾峰緱鍒楀悕
				String name = resultSet.getMetaData().getColumnName(j);
				if ("".equals(columnName.toString())) {
					columnName.append(name);
				} else {
					columnName.append("," + name);
				}
			}
			int i = 0;
			while (resultSet.next()) {
				String a = null;
				for (int j = 1; j <= columnCount; j++) {
					// 鑾峰緱鍒楀悕
					if (a == null) {
						a = resultSet.getString(j);
					} else {
						a = a + "," + resultSet.getString(j);
					}

				}
				readdata[i++] = a.split(",");
			}

			while (resultSet.next()) {
				sumCount = resultSet.getInt("count");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (resultSet != null) {
					resultSet.close();
				}
				if (statement != null) {
					statement.close();
				}
				if (con != null) {
					con.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return columnCount;
	}

	// 杩斿洖鏁版嵁浜屼綅鏁扮粍
	public String[][] getreaddata() {
		int length;
		
			length = readdata.length;
		String[][] data = new String[length][columnCount];
		for (int i = 0; i < readdata.length; i++) {
			for (int j = 0; j < readdata[i].length; j++) {
				data[i][j] = readdata[i][j];
			}
		}
		return data;
	}

	// 杩斿洖鍒楀悕
	public String[] getColumnName() {
		String[] columnNameList = columnName.toString().split(",");
		return columnNameList;
	}

	// 杩斿洖琛ㄥ悕
	public String[] getTableName(String user, String password,
			String choseDataBase) {
		Connection con = null;
		try {
			con = getConnection(user, password, choseDataBase);
		} catch (Exception e) {
			return null;
		}
		Statement statement = null;
		ResultSet resultSet = null;
		String getTableName_sql = "";
		StringBuffer tableName = new StringBuffer("");// 琛ㄥ悕鏁扮粍

		if ("mysql".equals(choseDataBase)) {
			getTableName_sql = "show databases;";
		} else if ("oracle".equals(choseDataBase)) {
			getTableName_sql = "select TABLE_NAME from  user_tables;";
		}
		
		try {
			statement = con.createStatement();
			resultSet = statement.executeQuery(getTableName_sql);
			while (resultSet.next()) {
				String name = resultSet.getString(1);
				//System.out.println("@@__@@"+name);
				if ("".equals(tableName.toString())) {
					tableName.append(name);
				} else {
					tableName.append("," + name);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (resultSet != null)
					resultSet.close();
				if (statement != null)
					statement.close();
				if (con != null)
					con.close();
				System.out.println("鏁版嵁搴撹繛鎺ュ凡鍏抽棴锛�");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return tableName.toString().split(",");

	}
	public String[] getRealTableName(String user, String password,
			String choseDataBase,String databasename) {
		Connection con = null;
		try {
			con = getConnection(user, password, choseDataBase);
		} catch (Exception e) {
			return null;
		}
		Statement statement = null;
		ResultSet resultSet = null;
		String getTableName_sql = "";
		StringBuffer tableName = new StringBuffer("");// 琛ㄥ悕鏁扮粍

		if ("mysql".equals(choseDataBase)) {
			getTableName_sql = "show tables;";
		} else if ("oracle".equals(choseDataBase)) {
			getTableName_sql = "select TABLE_NAME from  user_tables;";
		}
		
		try {
			statement = con.createStatement();
			statement.execute("use "+databasename);
			resultSet = statement.executeQuery(getTableName_sql);
			while (resultSet.next()) {
				String name = resultSet.getString(1);
				//System.out.println("@@__@@"+name);
				if ("".equals(tableName.toString())) {
					tableName.append(name);
				} else {
					tableName.append("," + name);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (resultSet != null)
					resultSet.close();
				if (statement != null)
					statement.close();
				if (con != null)
					con.close();
				System.out.println("鏁版嵁搴撹繛鎺ュ凡鍏抽棴锛�");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return tableName.toString().split(",");

	}
	public void setCurrTableName(String name) {
		this.tablename=name;
	}
	public String getCurrTableName() {
		return this.tablename;
	}
}
