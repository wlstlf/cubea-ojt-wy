<%@page import="validation.ReplyValidationCheck"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="util.MyUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="dao.CommonDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/login_Check.jsp" %>
<%
CommonDAO commonDao = new CommonDAO();

Map<String, Object> map = new HashMap<String, Object>();
Map<String, Object> result = new HashMap<String, Object>();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

String bId = MyUtil.NullPointerExUtil(request.getParameter("b_Id"), "");
String crud = MyUtil.NullPointerExUtil(request.getParameter("CRUD"), "");
String content = MyUtil.NullPointerExUtil(request.getParameter("content"), "");
String replyLevel = MyUtil.NullPointerExUtil(request.getParameter("rLv"), "0");
String parentId = MyUtil.NullPointerExUtil(request.getParameter("pId"), "0");

map.put("boardId", bId);

if( crud.equals("R") ) {
	
	List<Map<String, Object>> replyList = commonDao.selectList("getReplyList", map);
	
	if( !replyList.isEmpty() ) {
		for( Map<String, Object> list : replyList ) {
			if(String.valueOf(list.get("REPLY_PARENT_ID")).equals("0")){
%>
<div class="replyDiv">
	<div class="replyDivUp">
		<div class="replyDivUpIn">
<%
if ( String.valueOf(list.get("REPLY_WRITER")).equals(loginId) && list.get("REPLY_DELETE_YN").equals("N") ) {
%>
			<a href="javascript:replyUpdateBtn(<%=list.get("REPLY_ID")%>);"> 수정 </a>| 
		    <a href="javascript:getReplyDelete(<%=list.get("REPLY_ID")%>);"> 삭제 </a>| 
<%
}
%>
            <a href="#none" onclick="showReplyBtn(<%=list.get("REPLY_ID")%>);"> 대댓글 </a>
		</div>
		<span><strong>reply_num : <%=list.get("REPLY_ID")%></strong></span><br>
		<span><strong>writer : <%=list.get("REPLY_WRITER")%></strong></span>
		<span class="replyDate"><strong>Date : <%=list.get("REPLY_UPDATE_DATE") != null ? sdf.format(list.get("REPLY_UPDATE_DATE")) + "(수정됨)" : sdf.format(list.get("REPLY_CREATE_DATE")) %></strong></span>
	</div>
	<div class="commentContent">
        <div>
        	<!-- <button class="btn btn-success btn-sm">찬성 ( 0 )</button>
           	<button class="btn btn-danger btn-sm">반대 ( 0 )</button> -->
           	<a href="javascript:upDownSubmit(<%=list.get("REPLY_ID")%>,'U','<%=loginId%>')" style="color:#2F9D27; text-decoration:underline;"><b>찬성 (<%= list.get("UP") %>)</b></a> | 
			<a href="javascript:upDownSubmit(<%=list.get("REPLY_ID")%>,'D','<%=loginId%>')" style="color:#F15F5F; text-decoration:underline;"><b>반대 (<%= list.get("DOWN") %>)</b></a>
        </div>
        <p>
        	<b> Content : </b>
        <% if ( list.get("REPLY_DELETE_YN").equals("N") ) { %>
        	<b id="replyContent_<%=list.get("REPLY_ID")%>"><%=list.get("REPLY_CONTENT")%></b>
        	<span id="replyUpdateInput_<%=list.get("REPLY_ID")%>">
	        	<input class="form-control test" id="replyUpdate_<%=list.get("REPLY_ID")%>" type="text" value="<%=list.get("REPLY_CONTENT")%>">
	        	<a class="btn btn-outline-primary btn-sm" onclick="getReplyUpdate(<%=list.get("REPLY_ID")%>);" href="#none">수정</a>
	        </span>
        <%} else if ( list.get("REPLY_DELETE_YN").equals("Y") ) { %>
        	<b class="deleteReply" style="">작성자에 의해 삭제된 댓글입니다.</b>
        <%} %>
        </p>
	</div>
	<div id="hiddenReply_<%=list.get("REPLY_ID")%>">
		<div>
            <span><strong>Reply to comment #<%=list.get("REPLY_ID")%></strong></span> <span id="cCnt"></span>
        </div>
		<input class="form-control" type="text" id="reComment_<%=list.get("REPLY_ID")%>" name="reComment">
		<a class="btn btn-outline-primary btn-sm" onclick="getReplyCreate(<%=list.get("REPLY_ID")%>)" href="#none">등록</a>
		<input type="hidden" id="replyLevel_<%=list.get("REPLY_ID")%>" name="replyLevel_<%=list.get("REPLY_ID")%>" value="1">
		<input type="hidden" id="parentId_<%=list.get("REPLY_ID")%>" name="parentId_<%=list.get("REPLY_ID")%>" value="<%=list.get("REPLY_ID")%>">
	</div>

<% 
			} else {
%>
	<div class="recommentDiv">
<%
	if ( String.valueOf(list.get("REPLY_WRITER")).equals(loginId) && list.get("REPLY_DELETE_YN").equals("N") ) {
%>
		<div class="replyDivUpIn">
			<a href="javascript:replyUpdateBtn(<%=list.get("REPLY_ID")%>);"> 수정 </a>| 
			<a href="javascript:getReplyDelete(<%=list.get("REPLY_ID")%>);"> 삭제 </a>
		</div><br>
<%
	}
%>
		<span style="float : right; display: inline-block;"><%=list.get("REPLY_UPDATE_DATE") != null ? sdf.format(list.get("REPLY_UPDATE_DATE")) + "(수정됨)" : sdf.format(list.get("REPLY_CREATE_DATE")) %> </span>
		<p>
		　┖  Writer : <%=list.get("REPLY_WRITER")%> / 
			Content : 
			<% if ( list.get("REPLY_DELETE_YN").equals("N") ) { %>
        		<span id="recommentContent_<%=list.get("REPLY_ID")%>"><%=list.get("REPLY_CONTENT")%></span>
        		<span id="recommentUpdateInput_<%=list.get("REPLY_ID")%>">
					<input class="form-control" id="replyUpdate_<%=list.get("REPLY_ID")%>" type="text" value="<%=list.get("REPLY_CONTENT")%>">
					<a class="btn btn-outline-primary btn-sm" onclick="getReplyUpdate(<%=list.get("REPLY_ID")%>);" href="#none">수정</a>
				</span>
        	<%} else if ( list.get("REPLY_DELETE_YN").equals("Y") ) { %>
        		<span class="deleteReply" id="recommentContent_<%=list.get("REPLY_ID")%>">작성자에 의해 삭제된 댓글입니다.</span>
        	<%} %>
			
			
		</p>
		<hr class="replyHr">
	</div>
<%	
			}
%>
</div>
<%
		}
	} else if ( replyList.isEmpty() && crud.equals("R") ) {
%>
<div class="nonReply" style="text-align: center;">
	<hr class="replyHr">
	<b>등록된 댓글이 없습니다!</b>
	<hr class="replyHr">
</div>
<%
	}
	// 댓글 작성일경우
} else if ( crud.equals("C") ) {
	
	map.put("content", content);
	map.put("writer", loginId);
	map.put("replyLevel", replyLevel);
	map.put("parentId", parentId);
	
	result = ReplyValidationCheck.ReplyValidation(map, crud);
	
	if ( !(boolean)result.get("success") ) {
		out.println(MyUtil.alertAndLocationUtil(result.get("message").toString(), "back"));
		return;
	}
	
	commonDao.insert("getReplyCreate", map);
	// 댓글 수정 또는 삭제일 경우
} else if ( crud.equals("U") || crud.equals("D") ) {

	String replyId = MyUtil.NullPointerExUtil(request.getParameter("r_Id"), "0");
	
	map.put("replyId", replyId);
	
	Map<String,Object> checkMap = commonDao.selectOne("getReplyCheck", map);
	
	if ( checkMap == null ){
		
		out.println(MyUtil.alertAndLocationUtil("잘못된 접근입니다 :(", "back"));
		
	} else if ( checkMap != null ) {
		
		if ( checkMap.get("REPLY_WRITER").equals(loginId) ) {
			
			if ( crud.equals("U") ) {
				
				map.put("content", content);
				result = ReplyValidationCheck.ReplyValidation(map, crud);
				
				if ( !(boolean)result.get("success") ) {
					out.println(MyUtil.alertAndLocationUtil(result.get("message").toString(), "back"));
					return;
				}
				
				commonDao.update("getReplyUpdate", map);
				
			} else if ( crud.equals("D") ) {
				
				result = ReplyValidationCheck.ReplyValidation(map, crud);
				
				if ( !(boolean)result.get("success") ) {
					out.println(MyUtil.alertAndLocationUtil(result.get("message").toString(), "back"));
					return;
				}
				
				commonDao.update("getReplyDeleteYN", map);
				
			}
			
		} else {
			
			out.println(MyUtil.alertAndLocationUtil("잘못된 접근입니다 :(", "back"));
			
		}
		
	}
	
} else if ( !crud.equals("C") && !crud.equals("R") && !crud.equals("U") && !crud.equals("D")) {
	
	out.println(MyUtil.alertAndLocationUtil("잘못된 접근입니다 :(", "back"));
	
}
%>