<%@page import="java.util.HashMap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Map"%>
<%@page import="dao.BoardMybatisDAO"%>
<%@page import="util.MyUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/include/login_Check.jsp" %>
<%
request.setCharacterEncoding("utf-8");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd ( hh:mm )");
BoardMybatisDAO boardDao = new BoardMybatisDAO();
String session_param = (String)session.getAttribute("key");

int bId = MyUtil.NumberFormatExUtil(request.getParameter("b_Id"), 0);
String bTitle = "";
String bContent = "";
String bWriter = "";
String bCDate = "";
String bUDate = "";
int bHit = 0;

//조회수 새로고침 중복 방지를 위한 쿠키 생성
Cookie[] cookies = request.getCookies();
boolean hit = true;
		
for ( Cookie cookie : cookies ) {
	
	// hit <- 쿠키가 존재하면 boolean hit false
	if ( cookie.getName().equals(loginId + "_hit") ) {
				
		hit = false;
		// 해당 번호의 게시글 조회수 증가 기록이 있다면
		if ( cookie.getValue().contains( MyUtil.NullPointerExUtil(request.getParameter("b_Id"), "")) ) {
			System.out.println(bId + " 게시글 조회수 증가 쿠키 존재");
		} 
		// hit쿠키에 boardId 번호가 존재하지 않다면 조회수 증가 로직수행
		else {		
			cookie.setValue(cookie.getValue() + "_" + request.getParameter("b_Id"));
			response.addCookie(cookie);
			boardDao.getUpHit(bId);
		}
				
	}
			
}
// 생성된 쿠키가 없으면 쿠키생성후 조회수 증가 로직수행 
if( hit ) {
	Cookie cookie1 = new Cookie(loginId + "_hit", request.getParameter("b_Id"));
	response.addCookie(cookie1);
	boardDao.getUpHit(bId);
}

Map<String, Object> boardDetail = boardDao.getBoardDetail(bId);

// 페이지에 조회수 반영을 위해 맨 아래로
if ( boardDetail != null ) {
	
	bId = Integer.parseInt(String.valueOf(boardDetail.get("BOARD_ID")));
	bTitle = (String)boardDetail.get("BOARD_TITLE");
	bContent = (String)boardDetail.get("BOARD_CONTENT");
	bContent = bContent.replace("\r\n", "<br>");
	bWriter = (String)boardDetail.get("BOARD_WRITER");
	bCDate = sdf.format(boardDetail.get("BOARD_CREATE_DATE"));
	bUDate = sdf.format(boardDetail.get("BOARD_UPDATE_DATE"));
	bHit = Integer.parseInt(String.valueOf(boardDetail.get("BOARD_HIT")));
	
} else {
	
	out.println(MyUtil.alertAndLocationUtil("잘못된 접근입니다 :(", "./board_list.jsp"));
	
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
	                <td><%= bId %></td>
	            </tr>
	            <tr>
	                <th>작성자</th>
	                <td><%= bTitle %></td>
	            </tr>
	            <tr>
	                <th>제목</th>
	                <td><%= bWriter %></td>
	            </tr>
	            <tr>
	                <th>내용</th>
	                <td><%= bContent %></td>
	            </tr>
	            <tr>
	                <th>등록일</th>
	                <td><%= bCDate %></td>
	            </tr>
	            <tr>
	                <th>수정일</th>
	                <td><%= bUDate %></td>
	            </tr>
	            <tr>
	                <th>조회수</th>
	                <td><%= bHit %></td>
	            </tr>
	        </tbody>
	    </table>
	    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
		    <!-- <a href="./board_list.jsp" class="btn btn-outline-dark">목록</a> -->
		    <a href="./board_list.jsp<%=session_param %>" class="btn btn-outline-dark">목록</a>
		<% 
		if( loginId != null && loginAuth != null ) {
			if ( loginId.equals(bWriter) || loginAuth.equals("admin") ) { %>
		    <a href="./board_modify.jsp?b_Id=<%= bId %>&IUD=U" class="btn btn-outline-success">수정</a>
		<%
	 		}
		%>
		<% if ( loginId.equals(bWriter) || loginAuth.equals("admin") ) { %>
		    <a href="./board_action.jsp?b_Id=<%= bId %>&IUD=D" class="btn btn-outline-danger">삭제</a>
		<%
	 		}
		}
		%>
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
<%@ include file="/include/footer.jsp" %>

</body>
</html>