package egovframework.gnpsj.service.impl;
import egovframework.gnpsj.service.GnPsjService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Service("gnPsjService")
public class GnPsjServiceImpl extends EgovAbstractServiceImpl implements GnPsjService {
	@Resource(name="gnPsjDAO")
	private GnPsjDAO gnPsjDAO;

	@Override
	public List<EgovMap> selectEmergencyVeh() throws SQLException {
		return gnPsjDAO.selectEmergencyVeh();
	}

	@Override
	public List<EgovMap> selectEmergencyLocAjax(Map<String, Object> params) throws SQLException {
		return gnPsjDAO.selectEmergencyLocAjax(params);
	}

	@Override
	public List<EgovMap> selectEmergencyRouteAjax(Map<String, Object> params) throws SQLException {
		return gnPsjDAO.selectEmergencyRouteAjax(params);
	}


}
