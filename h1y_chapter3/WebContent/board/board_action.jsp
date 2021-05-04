<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="validation.BoardValidationCheck"%>
<%@page import="util.AttachUtil"%>
<%@page import="dao.CommonDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/login_Check.jsp" %>
<!DOCTYPE html>
<%
request.setCharacterEncoding("utf-8");

CommonDAO commonDao = new CommonDAO();

// 검색조건 유지하기위해 session에 담아둔 Parameter
String session_param = (String)session.getAttribute("key") == null ? "" : (String)session.getAttribute("key");

// DB 보낼 MAP
Map<String, Object> boardMap = new HashMap<String, Object>();
// Validation Check MAP
Map<String, Object> result = new HashMap<String, Object>();
// UPDATE 권한을 체크하기 위한 MAP
Map<String, Object> boardDetail = new HashMap<String, Object>();

//파일 사이즈 설정
int fileSize = 10 * 1024 * 1024;
// 파일 경로 설정
String realPath = "D:\\board_upload_file\\";

// enctype="multipart/form-data" 타입은 무조건! POST로 넘겨야한다. 
// BUT!! 누군가 GET으로 넘어왔을때를 방지하기 위해 서칭하다 찾은 방법인데 괜찮을지 모르겠다.
if ( request.getMethod().equals("POST") ) {
	//이 시점에 업로드
	MultipartRequest multi = new MultipartRequest( request, realPath, fileSize, "utf-8", new DefaultFileRenamePolicy() );
	
	String iud = MyUtil.NullPointerExUtil(multi.getParameter("IUD"), "");
	
	if ( iud.equals("I") ) {
		
		boardMap.put("writer", MyUtil.NullPointerExUtil(multi.getParameter("writer"), ""));
		boardMap.put("title", MyUtil.NullPointerExUtil(multi.getParameter("title"), ""));
		boardMap.put("content", MyUtil.NullPointerExUtil(multi.getParameter("content"), ""));
		
		result = BoardValidationCheck.boardValidation(boardMap, iud);
		
		if ( !(boolean)result.get("success") ) {
			out.println(MyUtil.alertAndLocationUtil(result.get("message").toString(), "./board_list.jsp" + session_param));
			return;
		} else {
			
			int insertNum = commonDao.insert("getBoardCreate", boardMap);
			int att = AttachUtil.addAttach(multi, insertNum, loginId, realPath);
			
			System.out.println("INSERT된 ATTACH 개수 : " + att);
			
			out.println(MyUtil.alertAndLocationUtil("게시글이 등록되었습니다 :)", "./board_detail.jsp" + (session_param.equals("") ? "?b_Id=" + insertNum : session_param + "&b_Id=" + insertNum)));
			
		}
	
	} else if ( iud.equals("U") ) {
		
		// 수정시 받아오는 여러개의 동일한 input태그의 name값 배열형태로 받기
		String[] attachParam = multi.getParameterValues("attachArr");
		// 첨부파일을 지우고 넘겨주면 배열에선 공백을 담게 되고, 인덱스를 지워줄수 없어 ArrayList로 변환해주고 array에서 remove로 공백 인덱스를 지워준다
		// Arrays.asList( String[] ) <- 일반 배열을 Array배열로 변환해준다
		ArrayList<String> attachArr = new ArrayList<>(Arrays.asList(attachParam));
		
		// 공백의 인덱스를 지우기 위해 반복문을 반대로 돌림
		// 정상적으로 돌리면 인덱스가 지워졌을때 인덱스 번호가 지워진 만큼 순번이 앞당겨지기때문에 array의 index와 for문의 반복 사이클을 맞출수 없다.
		for ( int i = attachArr.size()-1; i >= 0; i--) {
			
			if ( attachArr.get(i).equals("") ) {
				attachArr.remove(i);
			}
			
		}
		
		boardMap.put("writer", MyUtil.NullPointerExUtil(multi.getParameter("writer"), ""));
		boardMap.put("title", MyUtil.NullPointerExUtil(multi.getParameter("title"), ""));
		boardMap.put("content", MyUtil.NullPointerExUtil(multi.getParameter("content"), ""));
		boardMap.put("boardId", MyUtil.NumberFormatExUtil(multi.getParameter("b_Id"), 0));
		
		result = BoardValidationCheck.boardValidation(boardMap, iud);
		
		if ( !(boolean)result.get("success") ) {
			out.println(MyUtil.alertAndLocationUtil(result.get("message").toString(), "./board_list.jsp" + session_param));
			return;
		} else {
			
			String bWriter = "";
			boardDetail = commonDao.selectOne("getBoardDetail", boardMap);
			
			if( boardDetail != null ) {
				
				bWriter = (String)boardDetail.get("BOARD_WRITER");
				int bId = Integer.parseInt(String.valueOf(boardDetail.get("BOARD_ID")));
				System.out.println("bWriter === " + bWriter);
				
				if ( loginId.equals(bWriter) || loginAuth.equals("admin") ) {
					
					int updateCol = commonDao.update("getBoardUpdate", boardMap);
					int att = AttachUtil.addAttach(multi, bId, loginId, realPath);
					// 삭제할 첨부파일 번호 배열이 존재하면
					if ( attachArr.size() != 0 ) {
						
						System.out.println("삭제할 첨부파일 인덱스가 존재합니다!! : " + attachArr.size() + "개!");
						boardMap.put("attachArr", attachArr);
						commonDao.delete("getAttachDelete", boardMap);
						
					}
					
					if ( updateCol == 1 ) out.println(MyUtil.alertAndLocationUtil("게시글이 수정되었습니다 :)", "./board_list.jsp" + session_param));
					
				} else out.println(MyUtil.alertAndLocationUtil("잘못된 접근입니다 :(", "./board_list.jsp" + session_param));
				
			} else out.println(MyUtil.alertAndLocationUtil("잘못된 접근입니다 :(", "./board_list.jsp" + session_param));
			
		}
		
	}

} else if ( request.getMethod().equals("GET") ) {
	
	String iud = MyUtil.NullPointerExUtil(request.getParameter("IUD"), "");
	
	if( iud.equals("D") ) {
		
		boardMap.put("boardId", MyUtil.NumberFormatExUtil(request.getParameter("b_Id"), 0));
		
		result = BoardValidationCheck.boardValidation(boardMap, iud);
		
		if ( !(boolean)result.get("success") ) {
			out.println(MyUtil.alertAndLocationUtil(result.get("message").toString(), "./board_list.jsp" + session_param));
			return;
		}
		String bWriter = "";
		boardDetail = commonDao.selectOne("getBoardDetail", boardMap);
		
		if( boardDetail != null ) {
			
			bWriter = (String)boardDetail.get("BOARD_WRITER");
			System.out.println("bWriter === " + bWriter);
			if( loginId.equals(bWriter) || loginAuth.equals("admin") ) {
				
				int deleteCol = commonDao.delete("getBoardDelete", boardMap);
				
				if ( deleteCol == 1 ) out.println(MyUtil.alertAndLocationUtil("게시글이 삭제되었습니다 :)", "./board_list.jsp" + session_param));
				
			} else out.println(MyUtil.alertAndLocationUtil("잘못된 접근입니다 :(", "./board_list.jsp" + session_param));
			
		} else out.println(MyUtil.alertAndLocationUtil("잘못된 접근입니다 :(", "./board_list.jsp" + session_param));
		
	} else {
		
		out.println(MyUtil.alertAndLocationUtil("잘못된 접근입니다 :(", "./board_list.jsp" + session_param));
		
	}
	
}
%>
