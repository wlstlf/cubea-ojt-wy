<%@page import="dto.BoardDTO"%>
<%@page import="dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
request.setCharacterEncoding("utf-8");
int boardId = Integer.parseInt(request.getParameter("b_Id"));
BoardDAO boardDAO = new BoardDAO();
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
<script>
const urlParams = new URLSearchParams(location.search);

function paramMaintain(){
	urlParams.delete('b_Id');
	location.href="./board_list.jsp?" + urlParams;
}

function updateBoard(){
	location.href="./board_modify.jsp?" + urlParams + "&DP=U"
}
	
function deleteBoard(boardId) {
	if( confirm("게시글을 삭제하시겠습니까?")==true ) {
		alert("삭제되었습니다.");
		location.href="./board_delete_action.jsp?" + urlParams;
	}
}
</script>
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
		    <a href="javascript:paramMaintain();" class="btn btn-outline-dark">목록</a>
		    <a href="javascript:updateBoard()" class="btn btn-outline-success">수정</a>
		    <a href="javascript:deleteBoard(<%= boardDetail.getBoardId() %>);" class="btn btn-outline-danger">삭제</a>
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