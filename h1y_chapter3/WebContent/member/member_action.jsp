<%@page import="dao.CommonDAO"%>
<%@page import="validation.MemberValidationCheck"%>
<%@page import="util.SHA256Util"%>
<%@page import="util.MyUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

CommonDAO commonDao = new CommonDAO();
Map<String, Object> memberMap = new HashMap<String, Object>();
Map<String, Object> result = new HashMap<String, Object>();

memberMap.put("userAuth", MyUtil.NullPointerExUtil(request.getParameter("userAuth"), ""));
memberMap.put("userId", MyUtil.NullPointerExUtil(request.getParameter("userId"), ""));
memberMap.put("userPass", MyUtil.NullPointerExUtil(request.getParameter("userPass"), ""));
memberMap.put("userPassCheck", MyUtil.NullPointerExUtil(request.getParameter("userPassCheck"), ""));
memberMap.put("userName", MyUtil.NullPointerExUtil(request.getParameter("userName"), ""));
memberMap.put("eMailF", MyUtil.NullPointerExUtil(request.getParameter("eMailF"), ""));
memberMap.put("eMailB", MyUtil.NullPointerExUtil(request.getParameter("eMailB"), ""));
memberMap.put("eMailSelect", MyUtil.NullPointerExUtil(request.getParameter("eMailSelect"), ""));

result = MemberValidationCheck.memberValidation(memberMap);

if ( !(boolean)result.get("success") ) {
	
	out.println(MyUtil.alertAndLocationUtil(result.get("message").toString(), "./member_join.jsp"));
	return;
	
} else if ( (boolean)result.get("success") ) {
	
	memberMap = commonDao.selectOne("getIdOverCheck", memberMap);
	
	int idCheck = Integer.parseInt(String.valueOf(memberMap.get("COUNT")));  
	
	if ( idCheck != 0 ) {
		
		out.println(MyUtil.alertAndLocationUtil("아이디가 중복됩니다. 중복체크를 진행해주세요 :(", "./member_join.jsp"));
		return;
		
	}
	
	commonDao.insert("getMemberCreate", memberMap);
	out.println(MyUtil.alertAndLocationUtil("회원가입 되었습니다 :)", "./member_login.jsp"));
	
}

%>