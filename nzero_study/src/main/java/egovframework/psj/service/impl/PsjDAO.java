package egovframework.psj.service.impl;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository("psjDAO")
public class PsjDAO extends EgovAbstractMapper {

    public List<EgovMap> selectCamListAjax() {
        return selectList("psj.selectCamListAjax");
    }

    public List<EgovMap> selectCamStatListAjax() {
        return selectList("psj.selectCamStatListAjax");
    }

    public List<EgovMap> selectVmsListAjax() {
        return selectList("psj.selectVmsListAjax");
    }

    public List<EgovMap> selectVmsStatListAjax() {
        return selectList("psj.selectVmsStatListAjax");
    }

}
