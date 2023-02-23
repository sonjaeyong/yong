package egovframework.psj.service.impl;

import egovframework.psj.service.PsjService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import javax.annotation.Resource;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Service("psjService")
public class PsjServiceImpl extends EgovAbstractServiceImpl implements PsjService {
	@Resource(name="psjDAO")
	private PsjDAO psjDAO;

	@Override
	public List<EgovMap> selectCamListAjax() throws SQLException {
		return psjDAO.selectCamListAjax();
	}

	@Override
	public List<EgovMap> selectCamStatListAjax() throws SQLException {
		return psjDAO.selectCamStatListAjax();
	}

	@Override
	public List<EgovMap> selectVmsListAjax() throws SQLException {
		return psjDAO.selectVmsListAjax();
	}

	@Override
	public List<EgovMap> selectVmsStatListAjax() throws SQLException {
		return psjDAO.selectVmsStatListAjax();
	}


}
