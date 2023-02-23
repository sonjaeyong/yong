package egovframework.bjw.service;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("bjwDAO")
public class BjwDAO extends EgovAbstractMapper {

    public List<EgovMap> selectVMS() {
        return selectList("bjw.selectVMS");
    }

    public List<EgovMap> selectCCTV() {
        return selectList("bjw.selectCCTV");
    }
}
