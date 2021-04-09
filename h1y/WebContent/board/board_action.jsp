<%@page import="util.MyUtil"%>
<%@page import="dto.BoardDTO"%>
<%@page import="dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
request.setCharacterEncoding("utf-8");

String session_param = (String)session.getAttribute("key");

MyUtil js = new MyUtil();

int boardId = Integer.parseInt(request.getParameter("b_Id"));
String iud = request.getParameter("IUD");

BoardDAO boardDAO = new BoardDAO();
BoardDTO boardDTO = new BoardDTO();

boardDTO.setBoardWriter(request.getParameter("writer"));
boardDTO.setBoardTitle(request.getParameter("title"));
boardDTO.setBoardContent(request.getParameter("content"));
boardDTO.setBoardId(Integer.parseInt(request.getParameter("b_Id")));

if ( iud.equals("I") ) {
	
	boardDAO.getBoardCreate(boardDTO);
	
	out.println(js.alertAndLocationUtil("게시글이 등록되었습니다 :)", "./board_list.jsp" + session_param));
	
} 

else if ( iud.equals("U") ) {
	
	boardDAO.getBoardUpdate(boardDTO);
	session.setAttribute("test", "test");
	out.println(js.alertAndLocationUtil("게시글이 수정되었습니다 :)", "./board_list.jsp" + session_param));
	
} 

else if ( iud.equals("D") ) {
	
	boardDAO.getBoardDelete(boardId);
	
	out.println(js.alertAndLocationUtil("게시글이 삭제되었습니다 :)", "./board_list.jsp" + session_param));
	
}

//response.sendRedirect("./board_list.jsp");
%>