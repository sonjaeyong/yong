package egovframework.main.web;

import java.awt.geom.Point2D;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.io.Resources;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/*import com.jhlabs.map.proj.Projection;
import com.jhlabs.map.proj.ProjectionFactory;*/

@Controller
public class MainController {
	String propPath = "egovframework/properties/globals.properties";
	Properties prop = new Properties();

	
	@RequestMapping(value="/main/index.do")
	public String index(@RequestParam Map<String, Object> params,HttpServletRequest request, ModelMap model) throws Exception{
		model.addAttribute("params", params);
		Reader reader = Resources.getResourceAsReader(propPath);
		prop.load(reader);
		String path = prop.getProperty("uploadPath");
		
		File dir = new File(path);
		String[] files = dir.list();
			
		model.addAttribute("files", files);	

		return "main/index";

	}
	
	/*@RequestMapping(value="/main/index.do")
	public String index(@RequestParam Map<String, Object> params,HttpServletRequest request, ModelMap model) throws Exception{
		model.addAttribute("params", params);
		if(params.get("searchCombo") != null){
			Reader reader = Resources.getResourceAsReader(propPath);
			prop.load(reader);
			String path = prop.getProperty("uploadPath");
			String csvName = "";
			if("1".equals(params.get("searchCombo"))){
				csvName = prop.getProperty("fileName1");
			}else if("2".equals(params.get("searchCombo"))){
				csvName = prop.getProperty("fileName2");
			}else if("3".equals(params.get("searchCombo"))){
				csvName = prop.getProperty("fileName3");
			}else if("4".equals(params.get("searchCombo"))){
				csvName = prop.getProperty("fileName4");
			}else if("5".equals(params.get("searchCombo"))){
				csvName = prop.getProperty("fileName5");
			}
			List<List<String>> csvList = new ArrayList<List<String>>();
			File csv = new File(path+csvName);
			
			BufferedReader br = null;
			String line = "";
			
			try{
				br = new BufferedReader(new FileReader(csv));
				while((line = br.readLine()) != null){
					List<String> aLine = new ArrayList<String>();
					String [] lineArr = line.split(",");
					aLine = Arrays.asList(lineArr);
					csvList.add(aLine);
				}
				
			}catch(FileNotFoundException e){
				e.printStackTrace();
			}catch(IOException e){
				e.printStackTrace();
			}finally{
				try{
					if(br != null){
						br.close();
					}
				}catch(IOException e){
					e.printStackTrace();
				}
			}
			model.addAttribute("result", csvList);
		}

		return "main/index";

	}*/
	
	@RequestMapping(value = "/main/detail.do")
	public String detail(ModelMap model, HttpServletRequest request,@RequestParam Map<String, Object> params) throws IOException, SQLException, RuntimeException {
		Reader reader = Resources.getResourceAsReader(propPath);
		prop.load(reader);
		String path = prop.getProperty("uploadPath");
		String csvName = (String)params.get("fileNm");
		String [] csvType = csvName.split("_");
		model.addAttribute("csvType", csvType[1]);
		List<List<String>> csvList = new ArrayList<List<String>>();
		File csv = new File(path+csvName);
		
		BufferedReader br = null;
		String line = "";
		
		try{
			br = new BufferedReader(new FileReader(csv));
			while((line = br.readLine()) != null){
				List<String> aLine = new ArrayList<String>();
				String [] lineArr = line.split(",");
				aLine = Arrays.asList(lineArr);
				csvList.add(aLine);
			}
			
		}catch(FileNotFoundException e){
			e.printStackTrace();
		}catch(IOException e){
			e.printStackTrace();
		}finally{
			try{
				if(br != null){
					br.close();
				}
			}catch(IOException e){
				e.printStackTrace();
			}
		}
		model.addAttribute("result", csvList);
		model.addAttribute("params", params);
		
		return "main/detail_map";
	}
}
