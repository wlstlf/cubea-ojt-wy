<%@page import="util.BoardValidationCheck"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="util.MyUtil"%>
<%@page import="dto.BoardDTO"%>
<%@page import="dao.BoardDAO"%>
<!DOCTYPE html>
<%
request.setCharacterEncoding("utf-8");

String session_param = (String)session.getAttribute("key") == null ? "" : (String)session.getAttribute("key");

int boardId = MyUtil.NumberFormatExUtil(request.getParameter("b_Id"), 0);
String iud = MyUtil.NullPointerExUtil(request.getParameter("IUD"), "");

BoardDAO boardDAO = new BoardDAO();
BoardDTO boardDTO = new BoardDTO();

boardDTO.setBoardWriter(MyUtil.NullPointerExUtil(request.getParameter("writer"), ""));
boardDTO.setBoardTitle(MyUtil.NullPointerExUtil(request.getParameter("title"), ""));
boardDTO.setBoardContent(MyUtil.NullPointerExUtil(request.getParameter("content"), ""));
boardDTO.setBoardId(boardId);

// 게시물 등록시
if ( iud.equals("I") ) {
	
	Map<String,Object> result = BoardValidationCheck.boardValidation(boardDTO, iud);
	
	if ( !(boolean)result.get("success") ) {
		out.println(MyUtil.alertAndLocationUtil(result.get("message").toString(), "./board_list.jsp" + session_param));
		return;
	}
	
	int insertNum = boardDAO.getBoardCreate(boardDTO);
	out.println(MyUtil.alertAndLocationUtil("게시글이 등록되었습니다 :)", "./board_detail.jsp" + (session_param.equals("") ? "?b_Id=" + insertNum : session_param + "&b_Id=" + insertNum)));
	
} 

// 게시물 수정시
else if ( iud.equals("U") ) {
	
	Map<String,Object> result = BoardValidationCheck.boardValidation(boardDTO, iud);
	
	if ( !(boolean)result.get("success") ) {
		out.println(MyUtil.alertAndLocationUtil(result.get("message").toString(), "./board_list.jsp" + session_param));
		return;
	}
	
	boardDAO.getBoardUpdate(boardDTO);
	out.println(MyUtil.alertAndLocationUtil("게시글이 수정되었습니다 :)", "./board_list.jsp" + session_param));
	
} 

// 게시물 삭제시
else if ( iud.equals("D") ) {
	
	Map<String,Object> result = BoardValidationCheck.boardValidation(boardDTO, iud);
	
	if ( !(boolean)result.get("success") ) {
		out.println(MyUtil.alertAndLocationUtil(result.get("message").toString(), "./board_list.jsp" + session_param));
		return;
	}
	
	boardDAO.getBoardDelete(boardId);
	
	out.println(MyUtil.alertAndLocationUtil("게시글이 삭제되었습니다 :)", "./board_list.jsp" + session_param));
	
}

else if ( !iud.equals("I") || !iud.equals("U") || !iud.equals("D") ) {
	
	out.println(MyUtil.alertAndLocationUtil("잘못된 접근입니다 :(", "./board_list.jsp" + session_param));
	
}
%>