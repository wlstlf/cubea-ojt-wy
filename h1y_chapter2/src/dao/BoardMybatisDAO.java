package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import databaseCon.SqlSessionManager;

public class BoardMybatisDAO {
	
	private SqlSessionFactory sqlMapper = SqlSessionManager.getSqlSession();
	private SqlSession sqlSession = sqlMapper.openSession(true);

	public int getBoardListCount(String category, String text) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("category", category);
		map.put("text", text);
		
		int result = sqlSession.selectOne("getBoardListCount", map);
		
		return result;
		
	}
	
	public List<Map<String, Object>> getBoardList(int pageNum, String category, String text) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 페이지당 조회되는 게시글 개수
		final int limit = 6;
		// 현재 입력된 페이지 번호의 시작 글번호
		int startRow = (pageNum - 1) * 6 + 1;
		// 현재 입력된 페이지 번호의 끝 글번호
		int endRow = startRow + limit - 1;
		
		map.put("pageNum", pageNum);
		map.put("category", category);
		map.put("text", text);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		
		List<Map<String, Object>> resultList = sqlSession.selectList("getBoardList", map);
		
		return resultList;
		
	}
	
	public int getMaxBoardId() {
		
		int maxId = sqlSession.selectOne("getMaxBoardId");
		
		return maxId;
		
	}
	
	public Map<String, Object> getBoardDetail(int boardId) {
		
		Map<String, Object> result = sqlSession.selectOne("getBoardDetail", boardId);
		
		return result;
		
	}
	
	public int getBoardCreate(Map<String, Object> boardMap) {
		
		sqlSession.insert("getBoardCreate", boardMap);
		
		// 문제있었음 알아보기 ㄱㄱ (int)boardMap.get("boardId") <- 이거
		int boardId = Integer.parseInt(String.valueOf(boardMap.get("boardId")));
		
		return boardId;
		
	}
	
	public void getBoardUpdate(Map<String, Object> boardMap) {
		
		sqlSession.update("getBoardUpdate", boardMap);
		
	}
	
	public int getBoardDelete(Map<String, Object> boardMap) {
		
		int deleteCol = sqlSession.delete("getBoardDelete", boardMap);
		
		return deleteCol;
		
	}
	
	public void getUpHit(int boardId) {
		
		sqlSession.update("getUpHit", boardId);
		
	}
	
	
}
