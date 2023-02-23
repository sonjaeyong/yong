package egovframework.bjw.service.impl;

import egovframework.bjw.service.BjwDAO;
import egovframework.bjw.service.BjwService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("bjwService")
public class BjwServiceImpl implements BjwService {

    @Resource(name = "bjwDAO")
    BjwDAO bjwDAO;

    @Override
    public List<EgovMap> selectVMS() {
        return bjwDAO.selectVMS();
    }

    @Override
    public List<EgovMap> selectCCTV() {
        return bjwDAO.selectCCTV();
    }
}
