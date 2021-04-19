package util;

import java.util.HashMap;
import java.util.Map;

import dto.BoardDTO;

public class BoardValidationCheck {
	
	// 백단에서의 유효성 체크 !!
	// 웹의 폼을 통한 정상적인 접근이 아닌 개발자 도구 등의 비정상적인 경로로 접근을 
	// 시도할 경우 프론트단의 유효성 검사를 피해갈수 있기때문에 백단에서의
	// 유효성도 검사를 해주는것이 좋다고 선임님께서 조언해주셨다 :D
	public static Map<String, Object> boardValidation( BoardDTO dto , String iud ) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("success", true);
		
		if ( dto == null ) {
			
			result.put("success", false);
			result.put("message", "dto 객체가 존재하지않습니다.");
			
			return result;
			
		}
		
		if ( iud.equals("I") || iud.equals("U") ) {
			
			if ( dto.getBoardTitle() == null || dto.getBoardTitle().equals("") ) {
				
				result.put("success", false);
				result.put("message", "(Back Validation) 게시판 제목이 존재하지않습니다.");
				
				return result;
				
			} else if ( dto.getBoardContent() == null || dto.getBoardContent().equals("") ) {
				
				result.put("success", false);
				result.put("message", "(Back Validation) 게시판 내용이 존재하지않습니다.");
				
				return result;
				
			} else if ( dto.getBoardWriter() ==null || dto.getBoardWriter().equals("") ) {
				
				result.put("success", false);
				result.put("message", "(Back Validation) 게시판 작성자가 존재하지않습니다.");
				
				return result;
				
			}
			
		}

		if ( iud.equals("D") ) {
			
			if ( dto.getBoardId() == 0 ) {
				
				result.put("success", false);
				result.put("message", "(Back Validation) 삭제를 위한 게시판 번호가 존재하지않습니다.");
				
				return result;
				
			}
			
		}
		
		return result;
		
	}
	

}
