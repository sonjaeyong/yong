package egovframework.bjw.service;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Service;

import java.util.List;

public interface BjwService {

    List<EgovMap> selectVMS();

    List<EgovMap> selectCCTV();

}
