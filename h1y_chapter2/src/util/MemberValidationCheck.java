package util;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

public class MemberValidationCheck {
	
	public static Map<String, Object> memberValidation(Map<String, Object> map) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		SHA256Util sha = new SHA256Util();
		StringBuffer email = new StringBuffer();
		
		result.put("success", true);
		
		if ( map == null ) {
			
			result.put("success", false);
			result.put("message", "객체가 존재하지않습니다.");
			
			return result;
			
		}
		
		if ( map.get("userAuth") == null || map.get("userAuth").equals("") ) {
			
			result.put("success", false);
			result.put("message", "(Back Validation) 회원권한 객체가 존재하지않습니다.");
			
			return result;
			
		}
		
		if ( map.get("userId") == null || map.get("userId").equals("") ) {
			
			result.put("success", false);
			result.put("message", "(Back Validation) 회원아이디 객체가 존재하지않습니다.");
			
			return result;
			
		}
		
		if ( map.get("userId") != null ) {
			
			String idReg = "^[a-z0-9]{5,20}$";
			boolean regex = Pattern.matches(idReg, (String)map.get("userId"));
			
			if ( !regex ) {
				
				result.put("success", false);
				result.put("message", "(Back Validation) 회원아이디 정규표현식이 조건에 일치하지않습니다.");
				
				return result;
				
			}
			
		}

		if ( map.get("userPass") == null || map.get("userPass").equals("") ) {
			
			result.put("success", false);
			result.put("message", "(Back Validation) 회원비밀번호 객체가 존재하지않습니다.");
			
			return result;
			
		}
		
		if ( map.get("userPass") != null ) {
			
			String idReg = "^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\\\(\\\\)\\-_=+]).{8,16}$";
			boolean regex = Pattern.matches(idReg, (String)map.get("userPass"));
			
			if ( !regex ) {
				
				result.put("success", false);
				result.put("message", "(Back Validation) 회원비밀번호 정규표현식이 조건에 일치하지않습니다.");
				
				return result;
				
			}
			// 비밀번호 검증후 암호화
			map.put("userPass", sha.encryptSHA256((String)map.get("userPass")));
			
		}
		
		if( map.get("userPassCheck") == null || map.get("userPassCheck").equals("") ) {
			
			result.put("success", false);
			result.put("message", "(Back Validation) 회원비밀번호 확인 객체가 존재하지않습니다.");
			
			return result;
			
		}

		if ( map.get("userName") == null || map.get("userName").equals("") ) {
			
			result.put("success", false);
			result.put("message", "(Back Validation) 회원이름 객체가 존재하지않습니다.");
			
			return result;
			
		}

		if ( map.get("eMailF") == null || map.get("eMailF").equals("") ) {
			
			result.put("success", false);
			result.put("message", "(Back Validation) 회원이메일 객체가 존재하지않습니다.");
			
			return result;
			
		}
		
		if ( map.get("eMailSelect").equals("self") ) {
			
			if ( map.get("eMailB") == null || map.get("eMailB").equals("") ) {
				
				result.put("success", false);
				result.put("message", "(Back Validation) 회원이메일 객체가 존재하지않습니다.");
				
				return result;
				
			}
			
		}
		
		if ( map.get("eMailF") != null ) {
			
			email.append(map.get("eMailF"));
			email.append("@");
			
			if ( map.get("eMailB").equals("") && !map.get("eMailSelect").equals("") ) {
				email.append(map.get("eMailSelect"));	
			} else if ( !map.get("eMailB").equals("") && map.get("eMailSelect").equals("self") ) {
				email.append(map.get("eMailB"));
			}
			
			map.put("userEmail", email.toString());
			
		}
		
		return result;
		
	}
	
	public static Map<String, Object> memberLoginValidation(Map<String, Object> map) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		SHA256Util sha = new SHA256Util();
		
		result.put("success", true);
		
		if ( map.get("userId") == null || map.get("userId").equals("") ) {
			
			result.put("success", false);
			result.put("message", "(Back Validation) 회원아이디 객체가 존재하지않습니다.");
			
			return result;
			
		}
		
		if ( map.get("userPass") == null || map.get("userPass").equals("") ) {
			
			result.put("success", false);
			result.put("message", "(Back Validation) 회원비밀번호 객체가 존재하지않습니다.");
			
			return result;
			
		}
		
		if ( map.get("userPass") != null ) {
			
			map.put("userPass", sha.encryptSHA256((String)map.get("userPass")));
			
		}
		
		return result;
		
	}

}
