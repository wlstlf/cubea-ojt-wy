<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="dao.CommonDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/login_Check.jsp" %>
<%
CommonDAO commonDao = new CommonDAO();
Map<String,Object> map = new HashMap<String,Object>();

String rId = MyUtil.NullPointerExUtil(request.getParameter("r_Id"), "");
String ud = MyUtil.NullPointerExUtil(request.getParameter("UD"), "");
String lId = MyUtil.NullPointerExUtil(loginId, "");

System.out.println("rId === " + rId);
System.out.println("ud === " + ud);
System.out.println("lId === " + lId);

map.put("replyId", rId);
map.put("loginId", lId);
map.put("ud", ud);

int result = 0;

Map<String,Object> checkMap = commonDao.selectOne("getUpDownCheck", map);

if ( !ud.equals("U") && !ud.equals("D") ) {
	
	out.println(MyUtil.alertAndLocationUtil("잘못된 접근입니다. :(", "back"));

}

if ( checkMap == null ) {
	
	out.println(MyUtil.alertAndLocationUtil("잘못된 접근입니다. :(", "back"));
	
} else if ( checkMap != null ) {
	
	int upDownCount = Integer.parseInt(String.valueOf(checkMap.get("UD_COUNT")));
	
	if ( upDownCount <= 0 ) {
		
		commonDao.insert("getUpDownCreate", map);
		
	} else if ( upDownCount > 0 ) {
		
		result = 1;
		
	}
	
}
%>
<%= result %>