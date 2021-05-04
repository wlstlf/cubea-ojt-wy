package util;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.CommonDAO;

public class AttachUtil {
	
	public static int addAttach(MultipartRequest multi, int insertNum, String loginId, String realPath) {
		
		CommonDAO commonDao = new CommonDAO();
		
		int insertCount = 0;
		
		List<String> saveFile = new ArrayList<String>();
		List<String> originFile = new ArrayList<String>();

		Enumeration<?> e = multi.getFileNames();
		
		while ( e.hasMoreElements() ) {
			
			String n = (String)e.nextElement();
			System.out.println("n == " + n);
			saveFile.add(multi.getFilesystemName(n));
			System.out.println("multi.getFilesystemName(n) == " + multi.getFilesystemName(n));
			originFile.add(multi.getOriginalFileName(n));
			
		}
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		for( int i=saveFile.size()-1; i >= 0; i-- ) {
			
			if( originFile.get(i) != null ) {
				
				map.put("originName", originFile.get(i));
				map.put("saveName", saveFile.get(i));
				map.put("path", realPath);
				map.put("type", saveFile.get(i).substring(saveFile.get(i).lastIndexOf(".") + 1));
				map.put("boardId", insertNum);
				
				System.out.println("---------------------------------------------------");
				System.out.println("오리지널 파일명 : " + map.get("originName"));
				System.out.println("저장된 파일명 : " + map.get("saveName"));
				System.out.println("저장 경로 : " + map.get("path"));
				System.out.println("파일 확장자 : " + map.get("type"));
				System.out.println("게시글 번호 : " + map.get("boardId"));
				System.out.println("---------------------------------------------------");
				
				insertCount += commonDao.insert("getAttachCreate", map);
				//insertCount += 1;
				
			}
			
		}
		
		return insertCount;
		
	}

}
