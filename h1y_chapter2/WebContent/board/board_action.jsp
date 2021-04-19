<%@page import="dao.BoardMybatisDAO"%>
<%@page import="util.BoardValidationCheck"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="util.MyUtil"%>
<%@ include file="/include/login_Check.jsp" %>
<!DOCTYPE html>
<%
request.setCharacterEncoding("utf-8");

String session_param = (String)session.getAttribute("key") == null ? "" : (String)session.getAttribute("key");

String iud = MyUtil.NullPointerExUtil(request.getParameter("IUD"), "");

Map<String, Object> boardMap = new HashMap<String, Object>();
Map<String, Object> result = new HashMap<String, Object>();

boardMap.put("boardId", MyUtil.NumberFormatExUtil(request.getParameter("b_Id"), 0));
boardMap.put("writer", MyUtil.NullPointerExUtil(request.getParameter("writer"), ""));
boardMap.put("title", MyUtil.NullPointerExUtil(request.getParameter("title"), ""));
boardMap.put("content", MyUtil.NullPointerExUtil(request.getParameter("content"), ""));

int bId = MyUtil.NumberFormatExUtil(request.getParameter("b_Id"), 0);

BoardMybatisDAO boardDao = new BoardMybatisDAO();

// 게시물 등록시
if ( iud.equals("I") ) {
	
	result = BoardValidationCheck.boardValidation(boardMap, iud);
	
	if ( !(boolean)result.get("success") ) {
		out.println(MyUtil.alertAndLocationUtil(result.get("message").toString(), "./board_list.jsp" + session_param));
		return;
	}
	
	int insertNum = boardDao.getBoardCreate(boardMap);
	out.println(MyUtil.alertAndLocationUtil("게시글이 등록되었습니다 :)", "./board_detail.jsp" + (session_param.equals("") ? "?b_Id=" + insertNum : session_param + "&b_Id=" + insertNum)));
	
} 

// 게시물 수정시
else if ( iud.equals("U") ) {
	
	result = BoardValidationCheck.boardValidation(boardMap, iud);
	
	if ( !(boolean)result.get("success") ) {
		out.println(MyUtil.alertAndLocationUtil(result.get("message").toString(), "./board_list.jsp" + session_param));
		return;
	}
	
	boardDao.getBoardUpdate(boardMap);
	out.println(MyUtil.alertAndLocationUtil("게시글이 수정되었습니다 :)", "./board_list.jsp" + session_param));
	
} 

// 게시물 삭제시
else if ( iud.equals("D") ) {
	
	result = BoardValidationCheck.boardValidation(boardMap, iud);
	
	if ( !(boolean)result.get("success") ) {
		out.println(MyUtil.alertAndLocationUtil(result.get("message").toString(), "./board_list.jsp" + session_param));
		return;
	}
	
	String bWriter = "";
	boardMap = boardDao.getBoardDetail(bId);
	
	if( boardMap != null ) {
		
		bWriter = (String)boardMap.get("BOARD_WRITER");
		System.out.println("bWriter === " + bWriter);
		if( loginId.equals(bWriter) ) {
			
			int deleteCol = 1;//boardDao.getBoardDelete(boardMap);
			
			if ( deleteCol == 1 ) out.println(MyUtil.alertAndLocationUtil("게시글이 삭제되었습니다 :)", "./board_list.jsp" + session_param));
			
		} 
		
	} else out.println(MyUtil.alertAndLocationUtil("잘못된 접근입니다 :(", "./board_list.jsp" + session_param));
	
}

else if ( !iud.equals("I") && !iud.equals("U") && !iud.equals("D") ) {
	
	out.println(MyUtil.alertAndLocationUtil("잘못된 접근입니다 :(", "./board_list.jsp" + session_param));
	
}
%>