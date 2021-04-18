<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="dao.MemberMybatisDAO"%>
<%@page import="util.MyUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
Map<String, Object> memberMap = new HashMap<String, Object>();

memberMap.put("userId", MyUtil.NullPointerExUtil(request.getParameter("userId"), ""));

MemberMybatisDAO memberDao = new MemberMybatisDAO();

int idCheck = memberDao.getIdOverCheck(memberMap);
%>
<%= idCheck %>