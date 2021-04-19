<%@page import="util.MyUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
String loginId = (String)session.getAttribute("login_Id");
String loginAuth = (String)session.getAttribute("login_auth");

if( loginId != null ) {
	
	out.println(MyUtil.alertAndLocationUtil("잘못된 접근입니다 :(", "../board/board_list.jsp"));
	
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
<script type="text/javascript" src="../resources/js/member/member.js"></script>
<%@ include file="/include/nav.jsp" %>

<div class="container">
    <div class="py-5 text-center">
        <h2>회원가입</h2>
    </div>
	<form class="needs-validation" id="memberForm">
    	<h4 class="mb-3">회원 권한</h4>
        <hr class="mb-4">
      	<div class="row">
          	<div class="col-md-5 mb-3">
              	<div class="custom-control custom-radio">
               	<input id="admin" name="userAuth" type="radio" class="custom-control-input" value="admin">
                   <label class="custom-control-label" for="admin">관리자</label>
                  </div>
              </div>
              <div class="col-md-5 mb-3">
                  <div class="custom-control custom-radio">
                   <input id="normal" name="userAuth" type="radio" class="custom-control-input" checked value="normal">
                   <label class="custom-control-label" for="normal">일반회원</label>
                  </div>
              </div>
          </div>
          <hr class="mb-4">
          <h4 class="mb-3" style="margin-top: 30px;">회원 정보</h4>
          <hr class="mb-4">
          <div class="mb-3">
              <label for="username">ID</label>
              <div class="input-group">
                  <input type="text" class="form-control" name="userId" id="userId" placeholder="User Id">
                  <div class="idCheck" style="width: 100%; margin-top: 10px; font-size: 15px;">
                  	<b class="idCheckBold"></b>
                  </div>
              </div>
          </div>
          <div class="mb-3">
              <label>비밀번호</label>
              <div class="input-group">
                  <input type="password" class="form-control" name="userPass" id="userPass" placeholder="User Password" autocomplete="new-password">
              </div>
          </div>
          <div class="mb-3">
              <label>비밀번호 확인</label>
              <div class="input-group">
                  <input type="password" class="form-control" name="userPassCheck" id="userPassCheck" placeholder="User Password Check" autocomplete="new-password">
              </div>
          </div>
          <div class="mb-3">
          	<label>이름</label>
              <div class="input-group">
                  <input type="text" class="form-control" name="userName" id="userName" placeholder="User Name">
              </div>
          </div>
          <div class="row">
              <div class="col-md-5 mb-1">
                  <label for="cc-expiration">E-MAIL</label>
                  <input type="text" class="form-control" name="eMailF" id="eMailF" placeholder="E-Mail">
              </div>
              <div class="mb-3">
               <label for="username">　</label>
               <div class="input-group">
                   <div class="input-group-prepend">
                       <span class="input-group-text">@</span>
                   </div>
                   <input type="text" class="form-control" id="eMailB" name="eMailB" style="width: 244px;">
               </div>
          	</div>
              <div class="col-md-4 mb-1">
                  <label for="state">　</label>
                  <select class="custom-select d-block w-100" name="eMailSelect" id="eMailSelectBox">
                      <option value="self">직접입력</option>
                      <option value="cubea.co.kr">cubea.co.kr</option>
                      <option value="daum.net">daum.net</option>
                      <option value="naver.com">naver.com</option>
                  </select>
                  <div class="invalid-feedback"> Please provide a valid state. </div>
              </div>
          </div>
          <button class="btn btn-primary btn-lg btn-block" id="joinButton" type="button" onclick="memberFormSubmit();" style="margin-top: 10px;">회원가입</button>
    </form>
    <a class="btn btn-danger btn-lg btn-block" href="/login.jsp" style="margin-top: 10px;">회원가입 취소</a>
</div>
<%@ include file="/include/footer.jsp" %>
</body>
</html>