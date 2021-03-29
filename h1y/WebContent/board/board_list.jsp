<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dto.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
request.setCharacterEncoding("utf-8");
String category = request.getParameter("category") == null ? "" : request.getParameter("category");
String text = request.getParameter("text") == null ? "" : request.getParameter("text");
int pageNum = Integer.parseInt(request.getParameter("pageNum") == null ? "1" : request.getParameter("pageNum"));
BoardDAO boardDAO = new BoardDAO();
int count = boardDAO.getBoardListCount(category,text);
List<BoardDTO> boardList = boardDAO.getBoardList(pageNum, category, text);
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
var url_param = window.location.search;

function paramMaintain(boardId){
		
	boardId = url_param == '' ? "?b_Id=" + boardId : "&b_Id=" + boardId;
		
	location.href="./board_detail.jsp" + url_param + boardId;
		
	}
	
function createBoard(){
	location.href="./board_modify.jsp" + url_param + "&DP=C";
}
</script>
<body>
<%@ include file="/include/nav.jsp" %>
<div class="container">
	<div style="margin: 100px 0 50px 0;">
		<h2 style="text-align: center;">게시판 리스트</h2>
	</div>
	<p style="font-size: 15px; margin-bottom: 20px;">
		<b>총 : <%= count %></b>
		<a href="javascript:createBoard();" class="btn btn-primary" style="float: right;">등록</a>
	</p>
	<table class="table table-hover">
		<colgroup>
	    	<col width="10%"/>
	    	<col width="20%"/>
	    	<col width="10%"/>
	    	<col width="10%"/>
	    	<col width="10%"/>
	    	<col width="5%"/>
	  	</colgroup>
		<thead>
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>등록일</th>
				<th>수정일</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
			<% 
			for(int i=0; i < boardList.size(); i++) {
				BoardDTO board = boardList.get(i);
			%>
			<tr>
				<td><%=board.getBoardId() %></td>
				<%-- <td><a href="./board_detail.jsp?b_Id=<%=board.getBoardId() %>"><%=board.getBoardTitle() %></a></td> --%>
				<td><a href="javascript:paramMaintain(<%=board.getBoardId()%>)"><%=board.getBoardTitle() %></a></td>
				<td><%=board.getBoardWriter() %></td>
				<td><%=board.getBoardCreateDate() %></td>
				<td><%=board.getBoardUpdateDate() %></td>
				<td><%=board.getBoardHit() %></td>
			
			</tr>
			<%
			}
			%>
		</tbody>
	</table>
	
	<!-- <hr>
	<a class="btn btn-default pull-right">글쓰기</a> -->
	<form action="./board_list.jsp" method="get">
	<div class="search row">
		<div class="col-xs-2 col-sm-2">
			<select class="form-control" name="category">
				<option value="T">제목</option>
				<option value="C">내용</option>
				<option value="A">제목 + 내용</option>
			</select>
		</div>
		<div class="col-xs-10 col-sm-10">
			<div class="input-group">
				<input type="text" class="form-control" name="text"/>
				<span class="input-group-btn">
					<button type="submit" class="btn btn-primary">검색</button>
				</span>
			</div>
		</div>
	</div>
	</form>
	<div class="text-center" style="margin-top: 20px;">
  			<ul class="pagination justify-content-center">
    			<!-- <li class="page-item disabled">
      				<a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>
    			</li> -->
    		<%
				int totalPage = 0;
				
				if ( count % 10 == 0 ) totalPage = count / 10;
				else totalPage = (count / 10) + 1;
				
				for(int i=1; i<=totalPage; i++){ 
			%>
    			<li class="page-item">
    				<a class="page-link" href="./board_list.jsp?pageNum=<%=i %>&category=<%= category %>&text=<%= text %>"><%=i %></a>
    			</li>
    		<%
				} 
			%>
    			<!-- <li class="page-item active" aria-current="page">
      				<a class="page-link" href="#">2 <span class="sr-only">(current)</span></a>
    			</li>
    			<li class="page-item">
    				<a class="page-link" href="#">3</a>
    			</li> -->
    			<!-- <li class="page-item">
      				<a class="page-link" href="#">Next</a>
    			</li> -->
  			</ul>
	</div>
</div>
</body>
</html>