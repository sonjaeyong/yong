package egovframework.sjy.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.sjy.service.SjyService;

@Service("sjyService")
public class SjyServiceImpl extends EgovAbstractServiceImpl implements SjyService {
	@Resource(name="sjyDAO")
	private SjyDAO sjyDAO;
	
	@Override
	public List<Map<String, Object>> userList(Map<String, Object> params) {
		return sjyDAO.userList(params);
	}
	
	@Override
	public List<Map<String, Object>> crossList(Map<String, Object> params) {
		return sjyDAO.crossList(params);
	}
	
	@Override
	public int crossCount(Map<String, Object> params) {
		return sjyDAO.crossCount(params);
	}
	
	@Override
	public List<Map<String, Object>> userLogin(Map<String, Object> data) {
		return sjyDAO.userLogin(data);
	}
	
	@Override
	public List<Map<String, Object>> pwdCheck(Map<String, Object> data) {
		return sjyDAO.pwdCheck(data);
	}
	
	@Override
	public void updateId(Map<String, Object> params) {
		sjyDAO.updateId(params);
	}
	
	@Override
	@Transactional
	public Integer deleteId(Map<String, Object> params, HttpServletRequest request) throws Exception {
		String id = request.getParameter("id");
			params.put("id", id);
			if (sjyDAO.deleteId(params) > 1) {
				throw new Exception("delete error");
			}
		return 1;
	}
	
	@Override
	public List<Map<String, Object>> clickList(Map<String, Object> data) {
		return sjyDAO.clickList(data);
	}
	
	@Override
	public List<Map<String, Object>> crossCheck(Map<String, Object> data) {
		return sjyDAO.crossCheck(data);
	}
	
	@Override
	public void crossInsert(Map<String, Object> params) {
		sjyDAO.crossInsert(params);
	}
	
	@Override
	public void crossFormUpdate(Map<String, Object> params) {
		sjyDAO.crossFormUpdate(params);
	}
	
	@Override
	@Transactional
	public Integer crossFormDelete(Map<String, Object> params, HttpServletRequest request) throws Exception {
		String [] idArr = request.getParameterValues("chkYn");
		for(int i=0; i<idArr.length; i++) {
			params.put("chkYn", idArr[i]);
			if (sjyDAO.crossFormDelete(params) > 1) {
				throw new Exception("delete error");
			}
		}
		return 1;
	}
	
	@Override
	public void registId(Map<String, Object> params) {
		sjyDAO.registId(params);
	}
}
