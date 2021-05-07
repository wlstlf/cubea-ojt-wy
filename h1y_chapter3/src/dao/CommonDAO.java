package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import databaseCon.SqlSessionManager;

public class CommonDAO {
	
	private SqlSessionFactory sqlFactory = SqlSessionManager.getSqlSession();
	// openSession(true) <- true 설정시 autoCommit
	private SqlSession sqlSession = sqlFactory.openSession(true);
	
	public Map<String, Object> selectOne(String namespace, Map<String, Object> map) {
		
		Map<String, Object> result = sqlSession.selectOne(namespace, map);
		
		return result;
		
	}
	
	public List<Map<String, Object>> selectList(String namespace, Map<String, Object> map) {
		
		List<Map<String, Object>> result = sqlSession.selectList(namespace, map);
		
		return result;
		
	}
	
	public int insert(String namespace, Map<String, Object> map) {
		
		int result = sqlSession.insert(namespace, map);
		
		// 게시글 등록 후 등록한 게시글 상세페이지로 가기위해 namespace가 "getBoardCreate"로 넘어온 경우 등록된 게시글 번호 return
		if ( namespace.equals("getBoardCreate") ) {
			
			int boardId = Integer.parseInt(String.valueOf(map.get("boardId")));
			return boardId;
			
		}
		
		return result;
		
	}
	
	public int update(String namespace, Map<String, Object> map) {
		
		int result = sqlSession.update(namespace, map);
		
		return result;
		
	}
	
	public int delete(String namespace, Map<String, Object> map) {
		
		int result = sqlSession.delete(namespace, map);
		
		return result;
		
	}

}
