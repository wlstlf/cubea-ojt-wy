<%@page import="dto.BoardDTO"%>
<%@page import="dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
request.setCharacterEncoding("utf-8");
String iud = request.getParameter("IUD");
int boardId = 0;

BoardDAO boardDAO = new BoardDAO();
BoardDTO boardDetail = new BoardDTO();

if ( iud.equals("U") ) {
	
	boardId = Integer.parseInt(request.getParameter("b_Id"));
	boardDetail = boardDAO.getBoardDetail(boardId);
	
}
%>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript" src="../resources/js/board/board.js"></script>
<%@ include file="/include/nav.jsp" %>

<div class="container">
	<div style="margin: 100px 0 50px 0;">
		<h2 style="text-align: center;"><%= iud.equals("I") ? "글 작성" : "글 수정" %></h2>
	</div>
    <form action="./board_action.jsp" id="modifyForm" method="post">
      <div class="form-group">
        <label for="subject">제목</label>
        <input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력하세요." value="<%= boardDetail.getBoardTitle() == null ? "":boardDetail.getBoardTitle() %>">
      </div>
      <div class="form-group">
        <label for="writer">작성자</label>
        <input type="text" class="form-control" id="writer" name="writer" placeholder="작성자를 입력하세요." value="<%= boardDetail.getBoardWriter() == null ? "":boardDetail.getBoardWriter() %>">
      </div>
      <div class="form-group">
        <label for="content">내용</label>
        <textarea class="form-control" id="content" name="content" rows="3" placeholder="내용을 입력하세요."><%= boardDetail.getBoardContent() == null ? "":boardDetail.getBoardContent() %></textarea>
      </div>
      <div class="d-grid gap-2 d-md-flex justify-content-md-end">
      	<button type="button" onclick="modifySubmit()" class="btn btn-primary">등록</button>
      </div>
      	<input type="hidden" name="b_Id" id="b_Id" value="<%= boardId %>">
      	<input type="hidden" name="IUD" id="IUD" value="<%= iud %>">
      	<input type="hidden" name="param" id="param" value=""/>
    </form>
</div>
</body>
</html>