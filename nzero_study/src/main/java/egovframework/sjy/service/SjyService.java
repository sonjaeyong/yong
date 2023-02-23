package egovframework.sjy.service;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Component;
import org.springframework.ui.ModelMap;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

@Transactional
public interface SjyService {
	List<Map<String, Object>> crossList(Map<String, Object> params);
	
	List<Map<String, Object>> userList(Map<String, Object> params);
	
	int crossCount(Map<String, Object> params);
	
	List<Map<String, Object>> userLogin(Map<String, Object> data);
	
	List<Map<String, Object>> pwdCheck(Map<String, Object> data);
	
	void updateId(Map<String, Object> params);
	
	Integer deleteId(Map<String, Object> params, HttpServletRequest request) throws Exception;
	
	List<Map<String, Object>> clickList(Map<String, Object> data);
	
	void crossInsert(Map<String, Object> params);
	
	void crossFormUpdate(Map<String, Object> params);
	
	Integer crossFormDelete(Map<String, Object> params, HttpServletRequest request) throws Exception;
	
	void registId(Map<String, Object> params);
}
