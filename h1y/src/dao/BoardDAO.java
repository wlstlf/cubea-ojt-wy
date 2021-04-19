package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import databaseCon.DBconnection;
import dto.BoardDTO;
import util.MyUtil;

public class BoardDAO {

	// 게시판 갯수 DAO
	public int getBoardListCount(String category, String text) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int count = 0;
		/*String sql;
		
		if(category.equals("T")) category = "BOARD_TITLE";
		else if(category.equals("C")) category = "BOARD_CONTENT";
		
		if( category==null || text.trim().length()==0 ) sql = "select count(*) from BOARD";
		else if(category.equals("A")) sql = "select count(*) from BOARD where BOARD_TITLE like '%" + text + "%' OR BOARD_CONTENT like '%" + text + "%'";
		else sql = "select count(*) from BOARD where " + category + " like '%" + text + "%'";*/
		
		StringBuffer sql = new StringBuffer();
		
		category = MyUtil.NullPointerExUtil(category, "");
		text = MyUtil.NullPointerExUtil(text, "");
		
		if(category.equals("T")) category = "BOARD_TITLE";
		else if(category.equals("C")) category = "BOARD_CONTENT";
		
		sql.append("select count(*) from BOARD ");
		
		if ( category.equals("A") ) 
			sql.append("where BOARD_TITLE like '%" + text + "%' OR BOARD_CONTENT like '%" + text + "%'");
		
		else if ( category.equals("BOARD_TITLE") || category.equals("BOARD_CONTENT") ) 
			sql.append("where " + category + " like '%" + text + "%'");
		
		try {
			
			con = DBconnection.getInstance().getConnection();
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			
			if( rs.next() ) count = rs.getInt(1);
			
		} catch (Exception e) {
			
			System.out.println("getBoardListCount() Error ==== " + e);
			
		} finally {
			
			try {
				
				DBconnection.getInstance().Close(con, pstmt, rs);
				
			} catch (Exception e) {
				
				throw new RuntimeException(e.getMessage());
				
			}
			
		}
		
		return count;
		
	}
	
	// 게시판 리스트 DAO
	public List<BoardDTO> getBoardList(int pageNum, String category, String text){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		category = MyUtil.NullPointerExUtil(category, "");
		text = MyUtil.NullPointerExUtil(text, "");
		
		if(category.equals("T")) category = "BOARD_TITLE";
		else if(category.equals("C")) category = "BOARD_CONTENT";
		
		// 페이지당 조회되는 게시글 개수
		final int limit = 6;
		// 현재 입력된 페이지 번호의 시작 글번호
		int startRow = (pageNum - 1) * 6 + 1;
		// 현재 입력된 페이지 번호의 끝 글번호
		int endRow = startRow + limit - 1;

		/*String sql;
		
		if(category == null || text.trim().length()==0) 
			sql = "select * from ( select a.*, rownum as rn from ( select * from board " +
				  "order by board_id desc ) a ) where rn >= ? and rn <= ?";
		
		else if(category.equals("A")) 
			sql = "select * from ( select a.*, rownum as rn from ( select * from board " +
				  "where BOARD_TITLE like '%" + text + "%' OR BOARD_CONTENT like '%" + text + "%' " +
				  "order by board_id desc ) a ) where rn >= ? and rn <= ?";
		else 
			sql = "select * from ( select a.*, rownum as rn from ( select * from board " +
				  "where " + category + " like '%" + text + "%' order by board_id desc ) a ) " + 
				  "where rn >= ? and rn <= ?";*/
		StringBuffer sql = new StringBuffer();
		
		sql.append("select * from ( select a.*, rownum as rn from ( select * from board ");
		// 검색 조건이 제목 + 내용일 경우
		if ( category.equals("A") ) 
			sql.append("where BOARD_TITLE like '%" + text + "%' OR BOARD_CONTETN like '%" + text + "%' ");
		// 검색 조건이 제목 OR 내용 중 하나일 경우
		else if ( category.equals("BOARD_TITLE") || category.equals("BOARD_CONTENT") )
			sql.append("where " + category + " like '%" + text + "%' ");
		
		sql.append("order by board_id desc ) a ) where rn >= ? and rn <= ?");
		
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		
		try {
			con = DBconnection.getInstance().getConnection();
			pstmt = con.prepareStatement(sql.toString());
			
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rs = pstmt.executeQuery();
			
			while( rs.next() ) {
				
				BoardDTO board = new BoardDTO();
				
				board.setBoardId(rs.getInt("BOARD_ID"));
				board.setBoardWriter(rs.getString("BOARD_WRITER"));
				board.setBoardTitle(rs.getString("BOARD_TITLE"));
				board.setBoardContent(rs.getString("BOARD_CONTENT"));
				board.setBoardCreateDate(rs.getString("BOARD_CREATE_DATE"));
				board.setBoardUpdateDate(rs.getString("BOARD_UPDATE_DATE"));
				board.setBoardHit(rs.getInt("BOARD_HIT"));
				
				list.add(board);
				
			}
			
			
		} catch (Exception e) {
			
			System.out.println("getBoardList() Error == " + e);
			
		} finally {
			try {
				
				DBconnection.getInstance().Close(con, pstmt, rs);
				
			} catch (Exception e) {
				
				throw new RuntimeException(e.getMessage());
				
			}
		}
		
		return list;
		
	}
	
	
	public BoardDTO getBoardDetail(int boardId) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from Board where BOARD_ID = " + boardId;
		
		BoardDTO board = new BoardDTO();
		
		try {
			
			con = DBconnection.getInstance().getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if( rs.next() ) {
				
				board.setBoardId(rs.getInt(1));
				board.setBoardWriter(rs.getString(2));
				board.setBoardTitle(rs.getString(3));
				board.setBoardContent(rs.getString(4));
				board.setBoardCreateDate(rs.getString(5));
				board.setBoardUpdateDate(rs.getString(6));
				board.setBoardHit(rs.getInt(7));
				
			}
			
		} catch (Exception e) {
			
			System.out.println("getBoardDetail() Error == " + e);
			
		} finally {
			try {
				
				DBconnection.getInstance().Close(con, pstmt, rs);
				
			} catch (Exception e) {
				
				throw new RuntimeException(e.getMessage());
				
			}
		}
		
		return board;
		
	}
	
	
	public int getBoardCreate(BoardDTO board) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int insertNum = 0; // 생성된 행의 키를 받을 변수
		String[] colName = {"BOARD_ID"}; // 키값이 생성되는 칼럼 명
		
		String sql = "insert into BOARD (BOARD_ID, BOARD_WRITER, BOARD_TITLE, BOARD_CONTENT, BOARD_CREATE_DATE) values (SEQ_BOARD_ID.NEXTVAL,?,?,?,sysdate)";
		
		try {
			
			con = DBconnection.getInstance().getConnection();
			pstmt = con.prepareStatement(sql, colName);
			
			pstmt.setString(1, board.getBoardWriter());
			pstmt.setString(2, board.getBoardTitle());
			pstmt.setString(3, board.getBoardContent());
			
			pstmt.executeUpdate();
			
			rs = pstmt.getGeneratedKeys();
			
			if ( rs.next() ) insertNum = rs.getInt(1);
			System.out.println("방금 Insert된 데이터의 BOARD_ID 값 ==== " + insertNum);
			
		} catch (Exception e) {

			System.out.println("getBoardCreate() Error == " + e);
			
		} finally {
			try {
				
				DBconnection.getInstance().Close(con, pstmt);
				
			} catch (Exception e) {
				
				throw new RuntimeException(e.getMessage());
				
			}
		}
		
		return insertNum;
		
	}
	
	
	public void getBoardUpdate(BoardDTO board) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		String sql = "update BOARD set BOARD_WRITER = ?, BOARD_TITLE = ?, BOARD_CONTENT = ?, BOARD_UPDATE_DATE = SYSDATE WHERE BOARD_ID = ?";
		
		try {
			
			con = DBconnection.getInstance().getConnection();
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, board.getBoardWriter());
			pstmt.setString(2, board.getBoardTitle());
			pstmt.setString(3, board.getBoardContent());
			pstmt.setInt(4, board.getBoardId());
			pstmt.executeUpdate();
			
		} catch (Exception e) {

			System.out.println("getBoardUpdate() Error == " + e);
			
		} finally {
			try {
				
				DBconnection.getInstance().Close(con, pstmt);
				
			} catch (Exception e) {
				
				throw new RuntimeException(e.getMessage());
				
			}
		}
		
	}
	
	
	public void getBoardDelete(int boardId) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		String sql = "delete from BOARD where BOARD_ID = ?";
		
		try {
			
			con = DBconnection.getInstance().getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardId);
			pstmt.executeUpdate();
			
		} catch (Exception e) {

			System.out.println("getDeleteBoard() Error == " + e);
			
		} finally {
			try {
				
				DBconnection.getInstance().Close(con, pstmt);
				
			} catch (Exception e) {
				
				throw new RuntimeException(e.getMessage());
				
			}
		}
		
	}
	
	public void getUpHit(int boardId) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		String sql = "update BOARD set BOARD_HIT = NVL(BOARD_HIT,0) + 1 WHERE BOARD_ID = ?";
		
		try {
			
			con = DBconnection.getInstance().getConnection();
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, boardId);
			pstmt.executeUpdate();
			
		} catch (Exception e) {

			System.out.println("getUpHit() Error == " + e);
			
		} finally {
			try {
				
				DBconnection.getInstance().Close(con, pstmt);
				
			} catch (Exception e) {
				
				throw new RuntimeException(e.getMessage());
				
			}
		}
		
	}
	
}
