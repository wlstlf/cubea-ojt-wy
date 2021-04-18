package util;

import java.security.MessageDigest;

public class SHA256Util {

	public String encryptSHA256( String password ) {
		
		String sha = "";
		
		try {
			
			MessageDigest sh = MessageDigest.getInstance("SHA-256");
			
			sh.update(password.getBytes());
			
			byte byteData[] = sh.digest();
			
			StringBuffer strb = new StringBuffer();
			
			for ( int i = 0; i < byteData.length; i++ ) {
				strb.append(Integer.toString( (byteData[i] & 0xff ) + 0x100, 16 ).substring(1));
			}
			
			sha = strb.toString();
			
		} catch (Exception e) {
			
			System.out.println("encryptSHA256 Encrypt Error !!!!!!");
			sha = null;
			
		}
		
		return sha;
		
	}
	
	
	
}
