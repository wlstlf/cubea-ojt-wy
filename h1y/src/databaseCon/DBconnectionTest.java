package databaseCon;

public class DBconnectionTest {

	public static void main(String[] args) {
		
		DBconnection con = DBconnection.getInstance();
		
		con.getConnection();
		
		if( con != null ) System.out.println("연결성공 :D");
		
	}
	
}
