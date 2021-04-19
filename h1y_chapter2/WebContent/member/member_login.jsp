<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="dao.BoardMybatisDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
<script type="text/javascript" src="../resources/js/member/member.js"></script>
<%@ include file="/include/nav.jsp" %>
<div class="container" style="margin-top: 110px;">
	<form class="form-signin" id="loginForm">
		<div class="py-5 text-center">
			<h2 class="form-signin-heading">LOG IN</h2>
		</div>	
		<div class="mb-3">
			<label for="username">ID</label>
			<div class="input-group">
				<input type="text" class="form-control" name="loginUserId" id="loginUserId" placeholder="User Id">
			</div>
		</div>
		<div class="mb-3">
    		<label for="username">비밀번호</label>
    			<div class="input-group">
        			<input type="password" class="form-control" name="loginUserPass" id="loginUserPass" placeholder="User Password">
      			</div>
  		</div>
  		<input type="hidden" name="IO" value="I">
		<button class="btn btn-lg btn-primary btn-block" type="button" onclick="memberLogin();" style="margin-top: 40px;">Sign in</button>
	</form>
	<a class="btn btn-lg btn-dark btn-block" href="/member/member_join.jsp" style="margin-top: 20px;">Join</a>
</div>
<%@ include file="/include/footer.jsp" %>
</body>
</html>