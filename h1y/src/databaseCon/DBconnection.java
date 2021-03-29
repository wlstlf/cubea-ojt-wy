package databaseCon;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DBconnection {
	
	private static DBconnection instance = new DBconnection();

	private DBconnection() {}
	
	public static DBconnection getInstance() {
		return instance;
	}
	
	public Connection getConnection() {
		
		Connection con = null;
		
		String url = "jdbc:oracle:thin:@106.240.249.42:1521:orcl";
		String user = "PRIVATE_WY";
		String password = "amho";
		
		try {
			
			// JDBC 드라이버 로딩
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			// 접속
			con = DriverManager.getConnection(url, user, password);
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
		}
		
		return con;
		
	}
	
	public void Close(Connection con, PreparedStatement pstmt) {
		
		if ( pstmt != null ) {
			try {
				pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if ( con != null ) {
			try {
				con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	}
	
	public void Close(Connection con, PreparedStatement pstmt, ResultSet rs) {
		
		if ( rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if ( pstmt != null ) {
			try {
				pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if ( con != null ) {
			try {
				con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	}
	
}
