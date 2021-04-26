<%@page import="dao.CommonDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="util.MyUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
CommonDAO commonDao = new CommonDAO();
Map<String, Object> memberMap = new HashMap<String, Object>();

memberMap.put("userId", MyUtil.NullPointerExUtil(request.getParameter("userId"), ""));

memberMap = commonDao.selectOne("getIdOverCheck", memberMap);
%>
<%= memberMap.get("COUNT") %>