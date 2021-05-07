package validation;

import java.util.HashMap;
import java.util.Map;

public class ReplyValidationCheck {

	public static Map<String, Object> ReplyValidation( Map<String, Object> map, String crud ) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("success", true);
		
		if ( map == null ) {
			
			result.put("success", false);
			result.put("message", "객체가 존재하지 않습니다.");
			
			return result;
			
		}
		
		if ( crud.equals("C") ) {
			System.out.println("gasdgsdg" + map.get("content"));
			if( map.get("boardId") == null || map.get("boardId").equals("") ) {
				
				result.put("success", false);
				result.put("message", "(Back Validation) 게시판 번호가 존재하지않습니다.");
				
				return result;
				
			} else if( map.get("replyLevel") == null || map.get("replyLevel").equals("") ) {
				
				result.put("success", false);
				result.put("message", "(Back Validation) 댓글 계층레벨이 존재하지않습니다.");
				
				return result;
				
			} else if( map.get("writer") == null || map.get("writer").equals("") ) {
				
				result.put("success", false);
				result.put("message", "(Back Validation) 댓글 작성자가 존재하지않습니다.");
				
				return result;
				
			} if( map.get("content") == null || map.get("content").equals("") ) {
				System.out.println("zxczxczxczxc");
				result.put("success", false);
				result.put("message", "(Back Validation) 댓글 내용이 존재하지않습니다.");
				
				return result;
				
			} else if( map.get("parentId") == null || map.get("parentId").equals("") ) {
				
				result.put("success", false);
				result.put("message", "(Back Validation) 부모 댓글번호가 존재하지않습니다.");
				
				return result;
				
			}
			
		} else if ( crud.equals("U") ) {
			
			if( map.get("content") == null || map.get("content").equals("") ) {
				
				result.put("success", false);
				result.put("message", "(Back Validation) 댓글 내용이 존재하지않습니다.");
				
				return result;
				
			} else if( map.get("replyId") == null || map.get("replyId").equals("") ) {
				
				result.put("success", false);
				result.put("message", "(Back Validation) 댓글 번호가 존재하지않습니다.");
				
				return result;
				
			}
			
		} else if ( crud.equals("D") ) {
			
			if( map.get("replyId") == null || map.get("replyId").equals("") ) {
				
				result.put("success", false);
				result.put("message", "(Back Validation) 댓글 번호가 존재하지않습니다.");
				
				return result;
				
			}
			
		}
		
		return result;
		
	}
	
}
