<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


 
<div class="container">
	<h2>게시판 작성페이지</h2>
    <form action="/insertProc" method="post">
      <div class="form-group">
        <label for="subject">제목</label>
        <input type="text" class="form-control" id="subject" name="subject" placeholder="제목을 입력하세요.">
      </div>
      <div class="form-group">
        <label for="writer">작성자</label>
        <input type="text" class="form-control" id="writer" name="writer" placeholder="내용을 입력하세요.">
      </div>
      <div class="form-group">
        <label for=content">내용</label>
        <textarea class="form-control" id="content" name="content" rows="3"></textarea>
      </div>
      <button type="submit" class="btn btn-primary">등록</button>
    </form>
</div>

<br><br><br><br><br>

<div class="container">
	<h2>게시판 리스트페이지</h2>
	<table class="table table-hover">
		<colgroup>
	    	<col width="5%"/>
	    	<col width="30%"/>
	    	<col width="10%"/>
	    	<col width="10%"/>
	    	<col width="10%"/>
	    	<col width="5%"/>
	  	</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>등록일</th>
				<th>수정일</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>1</td>
				<td>제목입니다.</td>
				<td>한원용</td>
				<td>2021-03-24</td>
				<td>2021-03-25</td>
				<td>33</td>
			</tr>
			<tr>
				<td>1</td>
				<td>제목입니다.</td>
				<td>한원용</td>
				<td>2021-03-24</td>
				<td>2021-03-25</td>
				<td>33</td>
			</tr>
			<tr>
				<td>1</td>
				<td>제목입니다.</td>
				<td>한원용</td>
				<td>2021-03-24</td>
				<td>2021-03-25</td>
				<td>33</td>
			</tr>
			<tr>
				<td>1</td>
				<td>제목입니다.</td>
				<td>한원용</td>
				<td>2021-03-24</td>
				<td>2021-03-25</td>
				<td>33</td>
			</tr>
			<tr>
				<td>1</td>
				<td>제목입니다.</td>
				<td>한원용</td>
				<td>2021-03-24</td>
				<td>2021-03-25</td>
				<td>33</td>
			</tr>
		</tbody>
	</table>
	
	<!-- <hr>
	<a class="btn btn-default pull-right">글쓰기</a> -->
	
	<div class="search row">
		<div class="col-xs-2 col-sm-2">
			<select class="form-control">
				<option>---</option>
				<option>제목</option>
				<option>내용</option>
				<option>제목 + 내용</option>
			</select>
		</div>
		<div class="col-xs-10 col-sm-10">
			<div class="input-group">
				<input type="text" class="form-control"/>
				<span class="input-group-btn">
					<button type="button" class="btn btn-default">검색</button>
				</span>
			</div>
		</div>
	</div>
	<div class="text-center">
	
		<ul class="pagination">
			<li><a href="#none">1</a></li>
			<li><a href="#none">2</a></li>
			<li><a href="#none">3</a></li>
			<li><a href="#none">4</a></li>
			<li><a href="#none">5</a></li>
		</ul>
	</div>
</div>



<div class="container">	
	<h2>게시판 상세페이지</h2>
	<div>
		<table class="table table-bordered">
	        <colgroup>
	            <col width="20%" >
	            <col width="50%">
	        </colgroup>
	         
	        <tbody>
	            <tr>
	                <th class="info">제목</th>
	                <td>11</td>
	            </tr>
	            <tr>
	                <th class="info">작성자</th>
	                <td>11</td>
	            </tr>
	            <tr>
	                <th class="info">내용</th>
	                <td>11</td>
	            </tr>
	        </tbody>
	    </table>
	    <button type="button" class="btn btn-info btn-xs">목록</button>
	    <button type="button" class="btn btn-warning btn-xs">수정</button>
	    <button type="button" class="btn btn-danger btn-xs">삭제</button>
	</div>
</div>

<br><br><br><br><br><br>

</body>
</html>