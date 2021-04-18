<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="util.MyUtil"%>
<%
String loginId = (String)session.getAttribute("login_Id");
String loginAuth = (String)session.getAttribute("login_auth");

if( loginId == null ) {
	
	out.println(MyUtil.alertAndLocationUtil("로그인 하셔야 접근가능합니다 :(", "../member/member_login.jsp"));
	
}
%>