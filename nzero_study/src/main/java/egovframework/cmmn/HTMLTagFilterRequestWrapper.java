package egovframework.cmmn;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

public class HTMLTagFilterRequestWrapper extends HttpServletRequestWrapper {

	public HTMLTagFilterRequestWrapper(HttpServletRequest request) {
		super(request);
		// TODO Auto-generated constructor stub
	}

	public String[] getParameterValues(String parameter) {

		String[] values = super.getParameterValues(parameter);

		if(values==null){
			return null;
		}

		int count = values.length;
        String[] encodedValues = new String[count];
        for (int i = 0; i < count; i++) {
                   encodedValues[i] = cleanXSS(values[i]);
         }
        return encodedValues;

		/*for (int i = 0; i < values.length; i++) {
			if (values[i] != null) {
				StringBuffer strBuff = new StringBuffer();
				for (int j = 0; j < values[i].length(); j++) {
					char c = values[i].charAt(j);
					switch (c) {
					case '<':
						strBuff.append("&lt;");
						break;
					case '>':
						strBuff.append("&gt;");
						break;
					//case '&':
						//strBuff.append("&amp;");
						//break;
					case '"':
						strBuff.append("&quot;");
						break;
					case '\'':
						strBuff.append("&apos;");
						break;
					default:
						strBuff.append(c);
						break;
					}
				}
				values[i] = strBuff.toString();
			} else {
				values[i] = null;
			}
		}

		return values;*/
	}

	public String getParameter(String parameter) {
		String value = super.getParameter(parameter);
        if (value == null) {
               return null;
                }
        return cleanXSS(value);


		/*String value = super.getParameter(parameter);

		if(value==null){
			return null;
		}

		StringBuffer strBuff = new StringBuffer();

		for (int i = 0; i < value.length(); i++) {
			char c = value.charAt(i);
			switch (c) {
			case '<':
				strBuff.append("&lt;");
				break;
			case '>':
				strBuff.append("&gt;");
				break;
			case '&':
				strBuff.append("&amp;");
				break;
			case '"':
				strBuff.append("&quot;");
				break;
			case '\'':
				strBuff.append("&apos;");
				break;
			default:
				strBuff.append(c);
				break;
			}
		}

		value = strBuff.toString();

		return value;*/
	}

	public String getHeader(String name){
		String value = super.getHeader(name);
		if(value == null) return null;
		return cleanXSS(value);
	}

	private String cleanXSS(String value){
		StringBuffer sb = null;
		String[] checkStr_arr = {
			"<script>","</script>",
			"<javascript>","</javascript>",
			"<iframe","</iframe>",
			"<vbscript>","</vbscript>",
			"<object","</object>",
			"<img","</img>",
			"<marquee","</marquee>",
			"onerror","onclick","onload","onmouseover","onstart"
		};
		for(String checkStr: checkStr_arr){
			while(value.indexOf(checkStr)!=-1){
				value.replaceAll(checkStr, "");
			}
			while(value.toLowerCase().indexOf(checkStr)!=-1){
				sb = new StringBuffer(value);
				sb = sb.replace(value.toLowerCase().indexOf(checkStr), value.toLowerCase().indexOf(checkStr)+checkStr.length(), "");
				value = sb.toString();
			}
		}
		
		value = value.replaceAll("eval\\((.*)\\)", "");
        value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
        return value;
	}

}
