<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="dao.BoardMybatisDAO"%>
<%@page import="util.MyUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
request.setCharacterEncoding("utf-8");
String iud = MyUtil.NullPointerExUtil(request.getParameter("IUD"), "");

BoardMybatisDAO boardDao = new BoardMybatisDAO();
Map<String, Object> boardDetail = new HashMap<String, Object>();

boardDetail.put("boardId", MyUtil.NumberFormatExUtil(request.getParameter("b_Id"), 0));

if ( iud.equals("U") ) {
	
	if ( boardDetail.get("boardId").equals("0") ) out.println(MyUtil.alertAndLocationUtil("잘못된 접근입니다 :(", "./board_list.jsp"));
	
	boardDetail = boardDao.getBoardDetail(boardDetail);
	
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
<%@ include file="/include/login_Check.jsp" %>
<div class="container">
	<div style="margin: 100px 0 50px 0;">
		<h2 style="text-align: center;"><%= iud.equals("I") ? "글 작성" : "글 수정" %></h2>
	</div>
    <form action="./board_action.jsp" id="modifyForm" method="post">
      <div class="form-group">
        <label for="subject">제목</label>
        <input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력하세요." value="<%= boardDetail.get("BOARD_TITLE") == null ? "":boardDetail.get("BOARD_TITLE") %>">
      </div>
      <div class="form-group">
        <label for="writer">작성자</label>
        <input type="text" class="form-control" id="writer" name="writer" placeholder="작성자를 입력하세요." value="<%= boardDetail.get("BOARD_WRITER") == null ? loginId : boardDetail.get("BOARD_WRITER") %>">
      </div>
      <div class="form-group">
        <label for="content">내용</label>
        <textarea class="form-control" id="content" name="content" rows="3" placeholder="내용을 입력하세요."><%= boardDetail.get("BOARD_CONTENT") == null ? "":boardDetail.get("BOARD_CONTENT") %></textarea>
      </div>
      <div class="d-grid gap-2 d-md-flex justify-content-md-end">
      	<button type="submit" class="btn btn-primary">등록</button>
      </div>
      	<input type="hidden" name="b_Id" id="b_Id" value="<%= boardDetail.get("BOARD_ID") %>">
      	<input type="hidden" name="IUD" id="IUD" value="<%= iud %>">
      	<input type="hidden" name="param" id="param" value=""/>
    </form>
</div>
<%@ include file="/include/footer.jsp" %>
</body>
</html>