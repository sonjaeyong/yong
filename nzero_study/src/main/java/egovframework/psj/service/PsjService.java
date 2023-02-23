package egovframework.psj.service;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Component;
import org.springframework.ui.ModelMap;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Component
public interface PsjService {
    List<EgovMap> selectCamListAjax() throws SQLException;
    List<EgovMap> selectCamStatListAjax() throws SQLException;
    List<EgovMap> selectVmsListAjax() throws SQLException;
    List<EgovMap> selectVmsStatListAjax() throws SQLException;
}
