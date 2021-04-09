<%@page import="java.util.Enumeration"%>
<%@page import="dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
request.setCharacterEncoding("utf-8");
int boardId = Integer.parseInt(request.getParameter("b_Id"));

BoardDAO boardDAO = new BoardDAO();
boardDAO.getBoardDelete(boardId);

response.sendRedirect("./board_list.jsp");
%>