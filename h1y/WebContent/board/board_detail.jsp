<%@page import="dto.BoardDTO"%>
<%@page import="dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
request.setCharacterEncoding("utf-8");
int boardId = Integer.parseInt(request.getParameter("b_Id"));
BoardDAO boardDAO = new BoardDAO();

String session_param = (String)session.getAttribute("key");

//조회수 새로고침 중복 방지를 위한 쿠키 생성
Cookie[] cookies = request.getCookies();
boolean hit = true;
		
for ( Cookie cookie : cookies ) {
			
	System.out.println("쿠키이름 : " + cookie.getName());
	
	// hit <- 쿠키가 존재하면 boolean hit false
	if ( cookie.getName().equals("hit") ) {
				
		hit = false;
		// 해당 번호의 게시글 조회수 증가 기록이 있다면
		if ( cookie.getValue().contains(request.getParameter("b_Id")) ) {
			System.out.println(boardId + " 게시글 조회수 증가 쿠키 존재");
		} 
		// hit쿠키에 boardId 번호가 존재하지 않다면 조회수 증가 로직수행
		else {		
			cookie.setValue(cookie.getValue() + "_" + request.getParameter("b_Id"));
			response.addCookie(cookie);
			boardDAO.getUpHit(boardId);
		}
				
	}
			
}
// 생성된 쿠키가 없으면 쿠키생성후 조회수 증가 로직수행 
if( hit ) {
	Cookie cookie1 = new Cookie("hit", request.getParameter("b_Id"));
	response.addCookie(cookie1);
	boardDAO.getUpHit(boardId);
}

// 페이지에 조회수 반영을 위해 맨 아래로
BoardDTO boardDetail = boardDAO.getBoardDetail(boardId);
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

<%@ include file="/include/nav.jsp" %>
<div class="container">	
	<div style="margin: 100px 0 50px 0;">
		<h2 style="text-align: center;">게시판 상세</h2>
	</div>
	<div>
		<table class="table table-hover">
	        <colgroup>
	            <col width="20%" >
	            <col width="50%">
	        </colgroup>
	         
	        <tbody>
	        	<tr>
	                <th>글번호</th>
	                <td><%= boardDetail.getBoardId() %></td>
	            </tr>
	            <tr>
	                <th>작성자</th>
	                <td><%= boardDetail.getBoardWriter() %></td>
	            </tr>
	            <tr>
	                <th>제목</th>
	                <td><%= boardDetail.getBoardTitle() %></td>
	            </tr>
	            <tr>
	                <th>내용</th>
	                <td><%= boardDetail.getBoardContent() %></td>
	            </tr>
	            <tr>
	                <th>등록일</th>
	                <td><%= boardDetail.getBoardCreateDate() %></td>
	            </tr>
	            <tr>
	                <th>수정일</th>
	                <td><%= boardDetail.getBoardUpdateDate() %></td>
	            </tr>
	            <tr>
	                <th>조회수</th>
	                <td><%= boardDetail.getBoardHit() %></td>
	            </tr>
	        </tbody>
	    </table>
	    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
		    <!-- <a href="./board_list.jsp" class="btn btn-outline-dark">목록</a> -->
		    <a href="./board_list.jsp<%=session_param %>" class="btn btn-outline-dark">목록</a>
		    <a href="./board_modify.jsp?b_Id=<%= boardId %>&IUD=U" class="btn btn-outline-success">수정</a>
		    <a href="./board_action.jsp?b_Id=<%= boardId %>&IUD=D" class="btn btn-outline-danger">삭제</a>
		</div>
	</div>
	
	
	<div class="container">
	    <form id="commentForm" name="commentForm" method="post">
	    <br><br>
	        <div>
	            <div>
	                <span><strong>Comments</strong></span> <span id="cCnt"></span>
	            </div>
	            <div>
	                <table class="table">                    
	                    <tr>
	                        <td>
	                            <textarea style="width: 1100px" rows="3" cols="30" id="comment" name="comment" placeholder="댓글을 입력하세요"></textarea>
	                            <br>
	                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
	                                <a href='#' onClick="fn_comment('${result.code }')" class="btn btn-outline-primary">등록</a>
	                            </div>
	                        </td>
	                    </tr>
	                </table>
	            </div>
	        </div>
	        <input type="hidden" id="b_code" name="b_code" value="${result.code }" />        
	    </form>
	</div>
	<div class="container">
	    <form id="commentListForm" name="commentListForm" method="post">
	        <div id="commentList">
	        </div>
	    </form>
	</div>
</div>


</body>
</html>