<%@page import="java.util.List"%>
<%@page import="dao.CommonDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="util.MyUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/include/login_Check.jsp" %>
<%
request.setCharacterEncoding("utf-8");

if ( loginAuth == null || !loginAuth.equals("admin") ) out.println(MyUtil.alertAndLocationUtil("글작성은 관리자에게만 권한이 있습니다 :(", "back"));

String iud = MyUtil.NullPointerExUtil(request.getParameter("IUD"), "");
String session_param = (String)session.getAttribute("key");

CommonDAO commonDao = new CommonDAO();
Map<String, Object> boardDetail = new HashMap<String, Object>();

int bId = MyUtil.NumberFormatExUtil(request.getParameter("b_Id"), 0);
String bTitle = "";
String bContent = "";
String bWriter = "";

boardDetail.put("boardId", bId);

List<Map<String, Object>> attachList = commonDao.selectList("getBoardAttachList", boardDetail);

if ( iud.equals("U") ) {
	
	boardDetail = commonDao.selectOne("getBoardDetail", boardDetail);
	
	if ( boardDetail != null ) {
		
		bId = Integer.parseInt(String.valueOf(boardDetail.get("BOARD_ID")));
		bTitle = (String)boardDetail.get("BOARD_TITLE");
		bContent = (String)boardDetail.get("BOARD_CONTENT");
		bWriter = (String)boardDetail.get("BOARD_WRITER");
		
		if ( !loginId.equals(bWriter) && !loginAuth.equals("admin") ) {
			
			out.println(MyUtil.alertAndLocationUtil("잘못된 접근입니다 :(", "./board_list.jsp"));
			
		}
			
	} else {
		
		out.println(MyUtil.alertAndLocationUtil("잘못된 접근입니다 :(", "./board_list.jsp"));
		
	}
	
} else if ( !iud.equals("U") && !iud.equals("I") ) {
	
	out.println(MyUtil.alertAndLocationUtil("잘못된 접근입니다 :(", "./board_list.jsp"));
	
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
<script type="text/javascript" src="../resources/js/board/board.js"></script>
<script type="text/javascript" src="../resources/js/board/board_attach.js"></script>
<%@ include file="/include/nav.jsp" %>
<div class="container">
	<div style="margin: 100px 0 50px 0;">
		<h2 style="text-align: center;"><%= iud.equals("I") ? "글 작성" : "글 수정" %></h2>
	</div>
    <form action="./board_action.jsp" enctype="multipart/form-data" id="modifyForm" method="post">
		<div class="form-group">
			<label for="subject">제목</label>
        	<input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력하세요." value="<%= bTitle %>">
      	</div>
      	<div class="form-group">
        	<label for="writer">작성자</label>
        	<input type="text" class="form-control" id="writer" name="writer" placeholder="작성자를 입력하세요." value="<%= bWriter.equals("") ? loginId : bWriter %>">
      	</div>
      	<div class="form-group">
        	<label for="content">내용</label>
        	<textarea class="form-control" id="content" name="content" rows="3" placeholder="내용을 입력하세요."><%= bContent %></textarea>
      	</div>
      	
      	
      	<div class="my-3 p-3 bg-body rounded shadow-sm">
      	<%
      	if ( iud.equals("I") ) {
      	%>
      		<h6 class="border-bottom pb-2 mb-0">
      			파일 업로드
      			<a href="javascript:addAttachInput();" style="float: right;  font-size: 12px;">추가하기</a>
      		</h6>
      	<%
      	}
      	
      	if ( iud.equals("U") ) {
      	%>
      		<%
      		if ( !attachList.isEmpty() ) {
      		%>
      		<h6 class="border-bottom pb-2 mb-0">
      			업로드된 파일 목록 ( <b style="font-size: 12px; color: #FF2424">* 첨부파일은 수정까지 하셔야 최종적으로 삭제처리 됩니다.</b> )
      		</h6>
      		<%
      			for ( Map<String, Object> list : attachList ) {
      		%>
      			<ul style="margin-top: 20px;">
      				<li>
      					<b><a href="./attach_download.jsp?attachId=<%= list.get("ATTACH_ID") %>" id="attachFileName_<%= list.get("ATTACH_ID") %>"><%= list.get("ATTACH_ORIGINAL_NAME") %></a></b>
      					<div style="display: inline-block; width:70%; float: right;">
      						<a class="btn btn-outline-dark btn-sm" href="javascript:attachDelete(<%= list.get("ATTACH_ID") %>);" id="attachDeleteBtn_<%= list.get("ATTACH_ID") %>">
      							삭제
      						</a>
      						<input type="hidden" id="attachArr_<%= list.get("ATTACH_ID") %>" name="attachArr" value="">
      					</div>
      				</li>
      			</ul>
      		<%
      			}
      		}
      		%>
      		<h6 class="border-bottom pb-2 mb-0" style="margin-top: 30px;">
      			파일 추가 업로드
      			<a href="javascript:addAttachInput();" style="float: right;  font-size: 12px;">추가하기</a>
      		</h6>
      	<%
      	}
      	%>
      		<div id="attachInputDiv">
	      		<div class="d-flex text-muted pt-3">
	      			<input type="file" id="upload_1" name="upload_1">
	      		</div>
	      	</div>
      	</div>
      	
      	
      	
      	<div class="d-grid gap-2 d-md-flex justify-content-md-end">
      		<a class="btn btn-dark" style="margin-right: 10px;" href="./board_list.jsp<%= session_param %>">목록</a>
      		<button type="button" onclick="modifySubmit();" class="btn btn-primary"><%= iud.equals("I") ? "작성" : "수정" %></button>
      	</div>
      	<input type="hidden" name="b_Id" id="b_Id" value="<%= bId %>">
      	<input type="hidden" name="IUD" id="IUD" value="<%= iud %>">
      	<input type="hidden" name="param" id="param" value=""/>
    </form>
</div>
<%@ include file="/include/footer.jsp" %>
</body>
</html>