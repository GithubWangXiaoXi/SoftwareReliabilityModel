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
		Connection con = null;// ����һ�����ݿ�����
		// PreparedStatement pre = null;// ����Ԥ����������һ�㶼�������������Statement
		// ResultSet result = null;// ����һ�����������
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");// ����Oracle��������
			System.out.println("��ʼ�����������ݿ⣡");
			String url = "jdbc:oracle:" + "thin:@127.0.0.1:1521:ORCL";// 127.0.0.1�Ǳ�����ַ��XE�Ǿ����Oracle��Ĭ�����ݿ���
			con = DriverManager.getConnection(url, this.user, this.password);// ��ȡ����
			System.out.println("���ӳɹ���");
			
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				// // ��һ������ļ�������رգ���Ϊ���رյĻ���Ӱ�����ܡ�����ռ����Դ
				// // ע��رյ�˳�����ʹ�õ����ȹر�
				// if (result != null)
				// result.close();
				// if (pre != null)
				// pre.close();
				if (con != null)
					con.close();
				System.out.println("���ݿ������ѹرգ�");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return false;
	}
}
