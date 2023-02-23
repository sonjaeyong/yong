package egovframework.sjy.service.impl;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository("sjyDAO")
public class SjyDAO extends EgovAbstractMapper {
	public List<Map<String, Object>> userList(Map<String, Object> params) {
		return selectList("sjy.userList", params);
	}
	
	public List<Map<String, Object>> crossList(Map<String, Object> params) {
		return selectList("sjy.crossList", params);
	}
	
	public int crossCount(Map<String, Object> params) {
		return selectOne("sjy.crossCount", params);
	}

	public List<Map<String, Object>> userLogin(Map<String, Object> data) {
		return selectList("sjy.userLogin", data);
	}
	
	public List<Map<String, Object>> pwdCheck(Map<String, Object> data) {
		return selectList("sjy.pwdCheck", data);
	}
	
	public void updateId(Map<String, Object> params) {
		update("sjy.updateId", params);
	}
	
	public Integer deleteId(Map<String, Object> params) {
		return delete("sjy.deleteId", params);
	}
	
	public List<Map<String, Object>> clickList(Map<String, Object> data) {
		return selectList("sjy.clickList", data);
	}
	
	public void crossInsert(Map<String, Object> params) {
		insert("sjy.crossInsert", params);
	}
	
	public void crossFormUpdate(Map<String, Object> params) {
		update("sjy.crossFormUpdate", params);
	}
	
	public Integer crossFormDelete(Map<String, Object> params) {
		return delete("sjy.crossFormDelete", params);
	}
	
	public void registId(Map<String, Object> params) {
		insert("sjy.registId", params);
	}
}
