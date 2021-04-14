package util;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

public class MyUtil {
	
	// DB 작업 수행 후 alert과 location을 통해 페이지 이동을 위한 Util
	public static String alertAndLocationUtil( String alertMessage ,String locationUrl ) {
		
		StringBuffer sb = new StringBuffer();
		
		sb.append("<script type=\"text/javascript\"> \n");
		
		sb.append("alert('" + alertMessage + "'); \n");
		
		sb.append("location.href='" + locationUrl + "';");
		
		sb.append("</script>");
		
		return sb.toString();
		
	}
	
	// 검색조건 유지를 위해 세션에 검색조건을 담아줄 Util
	public static String urlParameterUtil(HttpServletRequest request) {
		
		Enumeration params = request.getParameterNames();
		
		StringBuffer strParam = new StringBuffer();
		while(params.hasMoreElements()) {
		    String name = (String)params.nextElement();
		    String value = request.getParameter(name);
		    strParam.append(name + "=" + value + "&");
		}
		
		
		if(!strParam.toString().equals("")) {
			strParam.insert(0, "?");
			strParam.deleteCharAt(strParam.lastIndexOf("&"));
		}

		System.out.println("Session 저장될 Parameter값 ==== " + strParam.toString());
		
		return strParam.toString();
		
	}
	
	// NumberFormatException 방지를 위한 Util
	public static int NumberFormatExUtil(String str, int defaultNum) {
		
		int parseInt = 0;
		
		try {
			
			parseInt = Integer.parseInt(str);
			
		} catch (NumberFormatException e) {
			
			parseInt = defaultNum;
			System.out.println("NumberFormatExUtil Catch !!!");
			
		}
		
		return parseInt;
		
	}
	
	// NullPointerException 방지를 위한 Util
	public static String NullPointerExUtil(String str, String defaultStr) {
		
		// 넘어온 값이 null인경우 입력한 값으로 return
		if ( str == null ) return defaultStr;
		
		// 넘어온 값이 not null인경우 앞뒤 공백 제거후 return
		if ( str != null ) {
			
			str = str.trim();
			
		}
		
		return str;
	}
	
}
