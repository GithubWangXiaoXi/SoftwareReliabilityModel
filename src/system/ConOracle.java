package system;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConOracle {
	private String user;
	private String password;

	
	public String getUser() {
		return user;
	}


	public void setUser(String user) {
		this.user = user;
	}


	public String getPassword() {
		return password;
	}



	public void setPassword(String password) {
		this.password = password;
	}


	public Boolean testOracle(String user, String password) {
		this.setUser(user);
		this.setPassword(password);
		Connection con = null;// 创建一个数据库连接
		// PreparedStatement pre = null;// 创建预编译语句对象，一般都是用这个而不用Statement
		// ResultSet result = null;// 创建一个结果集对象
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");// 加载Oracle驱动程序
			System.out.println("开始尝试连接数据库！");
			String url = "jdbc:oracle:" + "thin:@127.0.0.1:1521:ORCL";// 127.0.0.1是本机地址，XE是精简版Oracle的默认数据库名
			con = DriverManager.getConnection(url, this.user, this.password);// 获取连接
			System.out.println("连接成功！");
			
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				// // 逐一将上面的几个对象关闭，因为不关闭的话会影响性能、并且占用资源
				// // 注意关闭的顺序，最后使用的最先关闭
				// if (result != null)
				// result.close();
				// if (pre != null)
				// pre.close();
				if (con != null)
					con.close();
				System.out.println("数据库连接已关闭！");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return false;
	}
}
