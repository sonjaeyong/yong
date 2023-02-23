/**
  * @Class Name : CommUtil.java
  * @Description : 공통 메소드
  *   수정일           수정자                   수정내용
  *  -------------------------------------------------------------
  *  2013. 6. 4.       woonee             최초 생성
  *  2014.10. 7.       woonee             환경에 맞게 수정
  */
package egovframework.util;

import java.security.MessageDigest;
import java.util.HashMap;

import org.springframework.ui.ModelMap;


public class CommUtil {
    /**
	 * Object를 String 으로 변환
	 * @param obj 문자열로된 Object
	 * @param defaultStr
	 * @return
	 */
	public static boolean isNull(String obj){
		boolean result = true;
		if(obj != null && !"".equals(obj)){
			result = false;
		}
		return result;
	}

    /**
	 * Object를 String 으로 변환
	 * @param obj 문자열로된 Object
	 * @param defaultStr
	 * @return
	 */
	public static boolean isNull(Object obj){
		boolean result = true;
		if(obj != null && !"".equals(obj)){
			if(!"".equals(String.valueOf(obj))){
				result = false;
			}
		}
		return result;
	}

    /**
	 * Object를 String 으로 변환
	 * @param obj 문자열로된 Object
	 * @param defaultStr
	 * @return
	 */
	public static String isNull(String obj, String defaultStr){
		String result = defaultStr;
		if(obj != null && !"".equals(obj)){
			result = String.valueOf(obj);
		}
		return result;
	}

    /**
	 * Object를 String 으로 변환
	 * @param obj 문자열로된 Object
	 * @param defaultStr
	 * @return
	 */
	public static String isNull(Object obj, String defaultStr){
		String result = defaultStr;
		if(obj != null && !"".equals(obj)){
			if(!"".equals(String.valueOf(obj))){
				result = String.valueOf(obj);
			}
		}
		return result.trim();
	}


	/**
	 * 문자열을 SHA-256 방식으로 암호화
	 * @param txt 암호화 하려하는 문자열
	 * @return String
	 * @throws Exception
	 */
	public static String hexSha256(String txt) throws Exception{
	    StringBuffer sbuf = new StringBuffer();

	    MessageDigest mDigest = MessageDigest.getInstance("SHA-256");
	    mDigest.update(txt.getBytes());

	    byte[] msgStr = mDigest.digest() ;

	    for(int i=0; i < msgStr.length; i++){
	        byte tmpStrByte = msgStr[i];
	        String tmpEncTxt = Integer.toString((tmpStrByte & 0xff) + 0x100, 16).substring(1);

	        sbuf.append(tmpEncTxt) ;
	    }

	    return sbuf.toString();
	}

	/**
	 * 처리 완료 후 안내문구 및 이동페이지 설정,
	 * @param model ModelMap
	 * @param title : 페이지 타이틀 제목 (보통 오류또는 안내)
	 * @param msg : alert() 경고 문으로 보여줄 안내문, "" 값이면 경고창 없음
	 * @param script : javascript 처리문장 (보통 location.href='~~~~')
	 * @return /comm/message/message
	 */
	public static String doComplete(ModelMap model, String title, String msg, String script) {
		HashMap<String, String> message = new HashMap<String, String>();
		message.put("title",title);
		message.put("msg",msg);
		message.put("script",script);
		message.put("type","alert");
		model.addAttribute("message", message);
		return "/message/message";
	}

	public static String doCompleteUrl(ModelMap model, String title, String msg, String url) {
		HashMap<String, String> message = new HashMap();
		message.put("title", title);
		message.put("msg", msg);
		message.put("url", url);
		model.addAttribute("message", message);
		return "/message/messageForm";
	}

}
