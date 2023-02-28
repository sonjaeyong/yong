package egovframework.sjy.web;

import egovframework.cmmn.web.PaginationDefault;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import egovframework.sjy.service.SjyService;
import org.apache.ibatis.io.Resources;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.sql.SQLException;
import java.util.*;

@Controller
@RequestMapping("/sjy")
public class SjyController {

    @Resource(name = "sjyService")
    private SjyService sjyService;
    
    //로그인페이지
    @RequestMapping(value="/login.do")
    public String login(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception{
        model.addAttribute("params", params);
        return "sjy/login";
    }
    //회원가입페이지
    @RequestMapping(value="/userRegist.do")
    public String userRegist(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception{
    	List<Map<String, Object>> result = sjyService.userList(params);
    	model.addAttribute("params", params);
    	model.addAttribute("result", result);
    	return "/sjy/user_regist";
    }
    //정보수정페이지
    @RequestMapping(value="/updateInfo.do")
    public String updateInfo(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception{
    	
    	return "/sjy/update_info";
    }
    //회원탈퇴페이지
    @RequestMapping(value="/deleteInfo.do")
    public String deleteInfo(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception{
    	
    	return "/sjy/delete_info";
    }
    //메인페이지
    @RequestMapping(value="/index.do")
    public String index(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception{
    	if(params.get("pageNo") == null){
			params.put("pageNo", "1");
		}
    	
    	int resultCnt = sjyService.crossCount(params);
    	PaginationInfo paginationInfo = new PaginationInfo();
    	PaginationDefault pd = new PaginationDefault();
    	
    	paginationInfo.setTotalRecordCount(resultCnt);
		paginationInfo.setCurrentPageNo( Integer.parseInt((String) params.get("pageNo")));
		paginationInfo.setPageSize(pd.getPageSize());
		paginationInfo.setRecordCountPerPage(pd.getRecordCountPerPage());
		
    	List<Map<String, Object>> result = sjyService.crossList(params);
    	
    	model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("params", params);
        model.addAttribute("result", result);
        return "sjy/index";
    }
    //교차로등록페이지
    @RequestMapping(value="/crossRegist.do")
    public String crossRegist(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception{
    	if(params.get("pageNo") == null){
			params.put("pageNo", "1");
		}
    	
    	int resultCnt = sjyService.crossCount(params);
    	PaginationInfo paginationInfo = new PaginationInfo();
    	PaginationDefault pd = new PaginationDefault();
    	
    	paginationInfo.setTotalRecordCount(resultCnt);
		paginationInfo.setCurrentPageNo( Integer.parseInt((String) params.get("pageNo")));
		paginationInfo.setPageSize(pd.getPageSize());
		paginationInfo.setRecordCountPerPage(pd.getRecordCountPerPage());
		
    	List<Map<String, Object>> result = sjyService.crossList(params);
    	
    	model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("params", params);
        model.addAttribute("result", result);
        return "sjy/cross_regist";
    }
    //교차로수정페이지
    @RequestMapping(value="/crossUpdate.do")
    public String crossUpdate(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception{
    	if(params.get("pageNo") == null){
			params.put("pageNo", "1");
		}
    	
    	int resultCnt = sjyService.crossCount(params);
    	PaginationInfo paginationInfo = new PaginationInfo();
    	PaginationDefault pd = new PaginationDefault();
    	
    	paginationInfo.setTotalRecordCount(resultCnt);
		paginationInfo.setCurrentPageNo( Integer.parseInt((String) params.get("pageNo")));
		paginationInfo.setPageSize(pd.getPageSize());
		paginationInfo.setRecordCountPerPage(pd.getRecordCountPerPage());
		
    	List<Map<String, Object>> result = sjyService.crossList(params);
    	
    	model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("params", params);
        model.addAttribute("result", result);
        return "sjy/cross_update";
    }
    //교차로삭제페이지
    @RequestMapping(value="/crossDelete.do")
    public String crossDelete(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception{
    	if(params.get("pageNo") == null){
			params.put("pageNo", "1");
		}
    	
    	int resultCnt = sjyService.crossCount(params);
    	PaginationInfo paginationInfo = new PaginationInfo();
    	PaginationDefault pd = new PaginationDefault();
    	
    	paginationInfo.setTotalRecordCount(resultCnt);
		paginationInfo.setCurrentPageNo( Integer.parseInt((String) params.get("pageNo")));
		paginationInfo.setPageSize(pd.getPageSize());
		paginationInfo.setRecordCountPerPage(pd.getRecordCountPerPage());
		
    	List<Map<String, Object>> result = sjyService.crossList(params);
    	
    	model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("params", params);
        model.addAttribute("result", result);
        return "sjy/cross_delete";
    }
    
    

    //로그인ajax
    @ResponseBody
    @RequestMapping(value = "/userLogin.do", method = RequestMethod.POST)
    public List<Map<String, Object>> userLogin(@RequestBody Map<String, Object> data, ModelMap model,
    		HttpServletRequest request) throws IOException, SQLException, RuntimeException {
    	List<Map<String, Object>> result = sjyService.userLogin(data);
    	return result;
    }
    //교차로목록클릭ajax
    @ResponseBody
    @RequestMapping(value = "/clickList.do", method = RequestMethod.POST)
    public List<Map<String, Object>> clickList(@RequestBody Map<String, Object> data, ModelMap model,
    		HttpServletRequest request) throws IOException, SQLException, RuntimeException {
    	List<Map<String, Object>> result = sjyService.clickList(data);
    	return result;
    }
    //교차로 ID 중복확인
    @ResponseBody
    @RequestMapping(value = "/crossCheck.do", method = RequestMethod.POST)
    public List<Map<String, Object>> crossCheck(@RequestBody Map<String, Object> data, ModelMap model,
    		HttpServletRequest request) throws IOException, SQLException, RuntimeException {
    	List<Map<String, Object>> result = sjyService.crossCheck(data);
    	return result;
    }
    //교차로등록 쿼리실행 후 새로고침
    @RequestMapping(value = "/crossInsert.do")
    public Object crossInsert(@RequestParam Map<String, Object> params,ModelMap model,
    		HttpServletRequest request) throws Exception {
		if(params.get("useYn") == null){
			params.put("useYn", "0");
		}
		sjyService.crossInsert(params);
		return "redirect:/sjy/crossRegist.do";
	}
    //교차로수정 쿼리실행 후 새로고침
    @RequestMapping(value = "/crossFormUpdate.do")
	public Object crossFormUpdate(@RequestParam Map<String, Object> params,ModelMap model, HttpServletRequest request) throws Exception {
		if(params.get("useYn") == null){
			params.put("useYn", "0");
		}
		sjyService.crossFormUpdate(params);
		return "redirect:/sjy/crossUpdate.do";
	}
    //교차로삭제 쿼리실행 후 새로고침
    @RequestMapping(value = "/crossFormDelete.do")
	public Object crossFormDelete(@RequestParam Map<String, Object> params,ModelMap model, HttpServletRequest request) throws Exception {
		sjyService.crossFormDelete(params, request);
		return "redirect:/sjy/crossDelete.do";
	}
    //회원가입쿼리이동
    @RequestMapping(value = "/registId.do")
    public Object registId(@RequestParam Map<String, Object> params,ModelMap model,
    		HttpServletRequest request) throws Exception {
		if(params.get("userEm") == null){
			params.put("userEm", "0");
		}
		sjyService.registId(params);
		return "sjy/login";
	}
    //회원정보조회ajax
    @ResponseBody
    @RequestMapping(value = "/pwdCheck.do", method = RequestMethod.POST)
    public List<Map<String, Object>> pwdCheck(@RequestBody Map<String, Object> data, ModelMap model,
    		HttpServletRequest request) throws IOException, SQLException, RuntimeException {
    	List<Map<String, Object>> result = sjyService.pwdCheck(data);
    	return result;
    }
    //회원정보수정쿼리이동
    @RequestMapping(value = "/updateId.do")
	public Object updateId(@RequestParam Map<String, Object> params,ModelMap model, HttpServletRequest request) throws Exception {
		if(params.get("userEm") == null){
			params.put("userEm", "0");
		}
		sjyService.updateId(params);
		return "sjy/update_info";
	}
    //회원탈퇴쿼리이동
    @RequestMapping(value = "/deleteId.do")
	public Object deleteId(@RequestParam Map<String, Object> params,ModelMap model, HttpServletRequest request) throws Exception {
		sjyService.deleteId(params, request);
		return "sjy/login";
	}
}