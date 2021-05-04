<%@page import="java.util.HashMap"%>
<%@page import="dao.CommonDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Map"%>
<%@page import="util.PagingUtil"%>
<%@page import="util.MyUtil"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/login_Check.jsp" %>
<!DOCTYPE html>
<%
request.setCharacterEncoding("utf-8");

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

String session_param = MyUtil.urlParameterUtil(request);
session.setAttribute("key", session_param);

String category = MyUtil.NullPointerExUtil(request.getParameter("category"), "");
String text = MyUtil.NullPointerExUtil(request.getParameter("text"), "");
int pageNum = MyUtil.NumberFormatExUtil(request.getParameter("pageNum"), 1);
int limit = 6;
int startRow = ( pageNum - 1 ) * 6 + 1;
int endRow = startRow + limit -1;
int count = 0;

CommonDAO commonDao = new CommonDAO();

Map<String, Object> map = new HashMap<String, Object>();

map.put("category", category);
map.put("text", text);
map.put("pageNum", pageNum);
map.put("startRow", startRow);
map.put("endRow", endRow);

Map<String,Object> countMap = commonDao.selectOne("getBoardListCount", map);
List<Map<String, Object>> boardList = commonDao.selectList("getBoardList", map);

count = Integer.parseInt(String.valueOf(countMap.get("COUNT")));

PagingUtil paging = new PagingUtil( count, 6 );
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
		<h2 style="text-align: center;">게시판 리스트</h2>
	</div>
	<p style="font-size: 15px; margin-bottom: 20px;">
		<b>총 : <%= count %></b>
		<a href="./board_modify.jsp?IUD=I" class="btn btn-primary" style="float: right;">등록</a>
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
			if( boardList != null ) {
				for( Map<String, Object> list : boardList) {
			%>
			<tr>
				<td><%= list.get("BOARD_ID") %></td>
				<%-- <td><a href="./board_detail.jsp?b_Id=<%=board.getBoardId() %>"><%=board.getBoardTitle() %></a></td> --%>
				<td><a href="./board_detail.jsp?b_Id=<%= list.get("BOARD_ID") %>"><%= list.get("BOARD_TITLE") %></a></td>
				<td><%= list.get("BOARD_WRITER") %></td>
				<td><%= sdf.format(list.get("BOARD_CREATE_DATE")) %></td>
				<td><%= sdf.format(list.get("BOARD_UPDATE_DATE")) %></td>
				<td><%= list.get("BOARD_HIT") %></td>
			
			</tr>
			<%
				}
			} else {
			%>	
				<tr>
					<td colspan="6" style="text-align: center;">등록된 게시글이 없습니다.</td>
				</tr>
			<%	
			}
			%>
		</tbody>
	</table>
	
	<!-- <hr>
	<a class="btn btn-default pull-right">글쓰기</a> -->
	<form action="./board_list.jsp" id="searchForm" method="get">
	<div class="search row">
		<div class="col-xs-2 col-sm-2">
			<select class="form-control" name="category">
				<option value="T" <%= category.equals("T") ? "selected" : "" %>>제목</option>
				<option value="C" <%= category.equals("C") ? "selected" : "" %>>내용</option>
				<option value="A" <%= category.equals("A") ? "selected" : "" %>>제목 + 내용</option>
			</select>
		</div>
		<div class="col-xs-10 col-sm-10">
			<div class="input-group">
				<input type="text" class="form-control" name="text" value="<%= text %>"/>
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
				for(int i=1; i<=paging.getList().size(); i++){ 
			%>
    			<li class="page-item <%= i == pageNum ? "active" : "" %>">
    				<a class="page-link" href="./board_list.jsp?pageNum=<%=i %>&category=<%= category %>&text=<%= text %>"><%=i %></a>
    			</li>
    		<%
				} 
			%>
    		<%-- <%
				int totalPage = 0;
				
				if ( count % 5 == 0 ) totalPage = count / 5;
				else totalPage = (count / 5) + 1;
				
				for(int i=1; i<=totalPage; i++){ 
			%>
    			<li class="page-item">
    				<a class="page-link" href="./board_list.jsp?pageNum=<%=i %>&category=<%= category %>&text=<%= text %>"><%=i %></a>
    			</li>
    		<%
				} 
			%> --%>
			
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
<%@ include file="/include/footer.jsp" %>
</body>
</html>