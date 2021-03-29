<%@page import="dto.BoardDTO"%>
<%@page import="dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
request.setCharacterEncoding("utf-8");
String DP = request.getParameter("DP");
int boardId = 0;

BoardDAO boardDAO = new BoardDAO();
BoardDTO boardDetail = new BoardDTO();

if ( DP.equals("U") ) {
	
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
<script>
const urlParams = new URLSearchParams(location.search);

$(function(){
	urlParams.delete('b_Id');
	$('#param').val("?" + urlParams);
	
	$('#modifySubmit').click(function(){

		if ( $('#title').val() == '' ) {
			alert("제목을 입력해주세요.");
			$('#title').focus()
			return false;
		}
		if ( $('#writer').val() == '' ) {
			alert("작성자를 입력해주세요.");
			$('#writer').focus()
			return false;
		}
		if ( $('#content').val() == '' ) {
			alert("내용을 입력해주세요.");
			$('#content').focus()
			return false;
		}
		
		if ( $('#DP').val() == 'C' ){
			var msg = confirm("게시글을 등록하시겠습니까?");
			var alt = alert("등록되었습니다.");
		}
		else if ( $('#DP').val() == 'U' ){
			var msg = confirm("게시글을 수정하시겠습니까?");
			var alt = alert("수정되었습니다.");
		}
		
		if( msg == true ) {
			$('#modifyForm').submit();
			alt;
		}
	});
});
</script>
</head>
<body>

<%@ include file="/include/nav.jsp" %>

<div class="container">
	<div style="margin: 100px 0 50px 0;">
		<h2 style="text-align: center;"><%= DP.equals("C") ? "글 작성" : "글 수정" %></h2>
	</div>
    <form action="./board_modify_action.jsp" id="modifyForm" method="post">
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
      	<button type="button" id="modifySubmit" class="btn btn-primary">등록</button>
      </div>
      	<input type="hidden" name="b_Id" id="b_Id" value="<%= boardId %>">
      	<input type="hidden" name="DP" id="DP" value="<%= DP %>">
      	<input type="hidden" name="param" id="param" value=""/>
    </form>
</div>
</body>
</html>