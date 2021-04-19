package databaseCon;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

// Mybatis를 이용하여 sql을 실행 시키는 객체를 생성하는 코드!
public class SqlSessionManager {

	public static SqlSessionFactory sqlSession;
	
	static {
		
		String resource = "MybatisConfig.xml";
		
		Reader reader;
		
		try {
		
			reader = Resources.getResourceAsReader(resource);
			sqlSession = new SqlSessionFactoryBuilder().build(reader);
			
		} catch (IOException e) {
			
			e.printStackTrace();
			
		}
		
	}
	
	public static SqlSessionFactory getSqlSession() {
		return sqlSession;
	}
	
}
