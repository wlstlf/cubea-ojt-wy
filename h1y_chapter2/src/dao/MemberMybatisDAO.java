package dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import databaseCon.SqlSessionManager;

public class MemberMybatisDAO {

	private SqlSessionFactory sqlMapper = SqlSessionManager.getSqlSession();
	private SqlSession sqlSession = sqlMapper.openSession(true);
	
	public Map<String , Object> getMemberLoginCheck(Map<String, Object> loginMap) {
		
		Map<String , Object> loginCheck = sqlSession.selectOne("getMemberLoginCheck", loginMap);
		
		return loginCheck;
		
	}
	
	public Map<String , Object> getMember(Map<String, Object> memberMap) {
		
		Map<String, Object> map = sqlSession.selectOne("getMember", memberMap);
		
		return map;
		
	}
	
	public int getIdOverCheck(Map<String, Object> memberMap) {
		
		int IdCheck = sqlSession.selectOne("getIdOverCheck", memberMap);
		
		return IdCheck;
		
	}
	
	public void getMemberCreate(Map<String, Object> memberMap) {
		
		sqlSession.insert("getMemberCreate", memberMap);
		
	}
	
}
