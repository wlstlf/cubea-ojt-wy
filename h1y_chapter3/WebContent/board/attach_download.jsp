<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="dao.CommonDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/login_Check.jsp" %>
<%
request.setCharacterEncoding("utf-8");

CommonDAO commonDao = new CommonDAO();
Map<String, Object> map = new HashMap<String, Object>();

int attachId = MyUtil.NumberFormatExUtil(request.getParameter("attachId"), 0);

map.put("attachId", attachId);

Map<String, Object> attachMap = commonDao.selectOne("getBoardAttachDetail", map);

if ( attachMap == null ) {
	
	out.println(MyUtil.alertAndLocationUtil("잘못된 접근입니다 :(", "back"));
	
} else {
	
	String saveFileName = (String)attachMap.get("ATTACH_SAVE_NAME");
	String saveFileNameEd = new String( saveFileName.getBytes("utf-8"), "ISO-8859-1");
	
	String originFileName = (String)attachMap.get("ATTACH_ORIGINAL_NAME");
	String originFileNameEd = new String( originFileName.getBytes("utf-8"), "ISO-8859-1");
	
	File file = new File(attachMap.get("ATTACH_PATH") + "/" + saveFileName);
	
	System.out.println("file.toString == " +  file.toString());
	
	if ( file.exists() ) {
		
		response.setContentType("application/octet-stream");
		// attachment <- 첨부파일     다운로드되는 파일의 이름은 filename = 에서 결정된다 그러므로 origin파일명을 써줘야한다!
		response.setHeader("Content-Disposition", "attachment; filename=" + originFileNameEd);
		
		/* BufferedInputStream input = new BufferedInputStream(new FileInputStream(file));
		
		out.clear();
		pageContext.pushBody();
		
		BufferedOutputStream output = new BufferedOutputStream(response.getOutputStream());
		
		int read = input.read(data);
		
		while ( read != -1 ) {
			
			output.write(data, 0, read);
			
		}
		
		output.flush();
		output.close();
		input.close(); */
		
		out.clear();
		pageContext.pushBody();
		
		FileInputStream fileInputSteam = new FileInputStream(file); 
		ServletOutputStream servletOutputStream = response.getOutputStream(); 
		// 버퍼 생성 byte[] buffer = new byte[1024];
		byte[] buffer = new byte[1024];
		
		int readData = 0;
		
		while( (readData=(fileInputSteam.read(buffer, 0, buffer.length))) != -1 ) {
			
			servletOutputStream.write(buffer, 0, readData); 
			
		}
		
		servletOutputStream.flush();
		servletOutputStream.close();
		fileInputSteam.close();
		
	} else {
		
		System.out.println(file.toString() + " === 경로에 파일이 존재하지 않습니다.");
		out.println(MyUtil.alertAndLocationUtil("파일을 찾을수 없습니다 :(", "back"));
		return;
		
	}
	
}


%>