<%@page import="java.io.PrintWriter"%>
<%@page import="dao.BoardDAO"%>
<%@page import="dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
request.setCharacterEncoding("utf-8");
BoardDTO board = new BoardDTO();
BoardDAO boardDAO = new BoardDAO();
String param = request.getParameter("param");
board.setBoardWriter(request.getParameter("writer"));
board.setBoardTitle(request.getParameter("title"));
board.setBoardContent(request.getParameter("content"));
if( request.getParameter("b_Id") != null )board.setBoardId(Integer.parseInt(request.getParameter("b_Id")));

String DP = request.getParameter("DP");

if ( DP.equals("C") ) {

	boardDAO.getBoardCreate(board);
	
} else if ( DP.equals("U") ) {
	
	boardDAO.getBoardUpdate(board);
	
}

response.sendRedirect("./board_list.jsp" + param);
%>