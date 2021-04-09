package util;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

public class MyUtil {
	
	// alert 노출 후 이동
	public String alertAndLocationUtil( String alertMessage ,String locationUrl ) {
		
		StringBuffer sb = new StringBuffer();
		
		sb.append("<script type=\"text/javascript\"> \n");
		
		sb.append("alert('" + alertMessage + "'); \n");
		
		sb.append("location.href='" + locationUrl + "';");
		
		sb.append("</script>");
		
		return sb.toString();
		
	}
	
	public String urlParameterUtil(HttpServletRequest request) {
		
		
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
	
}
