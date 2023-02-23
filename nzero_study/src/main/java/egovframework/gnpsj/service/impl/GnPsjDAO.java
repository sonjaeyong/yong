package egovframework.gnpsj.service.impl;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository("gnPsjDAO")
public class GnPsjDAO extends EgovAbstractMapper {

    public List<EgovMap> selectEmergencyVeh() {
        return selectList("gnpsj.selectEmergencyVeh");
    }

    public List<EgovMap> selectEmergencyLocAjax(Map<String, Object> params) {
        return selectList("gnpsj.selectEmergencyLocAjax", params);
    }

    public List<EgovMap> selectEmergencyRouteAjax(Map<String, Object> params) {
        return selectList("gnpsj.selectEmergencyRouteAjax", params);
    }

}
