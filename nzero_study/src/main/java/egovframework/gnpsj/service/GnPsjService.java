package egovframework.gnpsj.service;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Component;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Component
public interface GnPsjService {
    List<EgovMap> selectEmergencyVeh() throws SQLException;
    List<EgovMap> selectEmergencyLocAjax(Map<String, Object> params) throws SQLException;
    List<EgovMap> selectEmergencyRouteAjax(Map<String, Object> params) throws SQLException;
}
