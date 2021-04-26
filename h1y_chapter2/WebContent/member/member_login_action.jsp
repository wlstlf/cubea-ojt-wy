<%@page import="dao.CommonDAO"%>
<%@page import="util.MemberValidationCheck"%>
<%@page import="util.MyUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

CommonDAO commonDao = new CommonDAO();

Map<String, Object> loginMap = new HashMap<String, Object>();
Map<String, Object> result = new HashMap<String, Object>();

loginMap.put("userId", MyUtil.NullPointerExUtil(request.getParameter("loginUserId"), ""));
loginMap.put("userPass", MyUtil.NullPointerExUtil(request.getParameter("loginUserPass"), ""));

String logType = MyUtil.NullPointerExUtil(request.getParameter("IO"), "");

if ( logType.equals("I") ) {
	
	result = MemberValidationCheck.memberLoginValidation(loginMap);
	
	if ( !(boolean)result.get("success") ) {
		
		out.println(MyUtil.alertAndLocationUtil(result.get("message").toString(), "./member_login.jsp"));
		return;
		
	} else if ( (boolean)result.get("success") ) {
		
		Map<String, Object> map = commonDao.selectOne("getMemberLoginCheck",loginMap);

		if ( map != null ) {
			
			session.setAttribute("login_Id", loginMap.get("userId"));
			session.setAttribute("login_auth", map.get("MEMBER_AUTH"));
			out.println(MyUtil.alertAndLocationUtil("", "../board/board_list.jsp"));
			
		} else {
			
			out.println(MyUtil.alertAndLocationUtil("아이디 또는 비밀번호가 틀렸습니다 :(", "./member_login.jsp"));
			
		}
		
	}
	
} else if ( logType.equals("O") ) {
	
	session.invalidate();
	out.println(MyUtil.alertAndLocationUtil("로그아웃 되었습니다 :)", "./member_login.jsp"));
	
} else {
	
	out.println(MyUtil.alertAndLocationUtil("잘못된 접근입니다 :(", "./member_login.jsp"));
	
}
%>