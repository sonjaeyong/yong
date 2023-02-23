package egovframework.bjw.web;

import egovframework.bjw.service.BjwService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/bjw")
public class BjwController {

    @Resource(name = "bjwService")
    BjwService bjwService;

    @RequestMapping(value = "/index.do")
    public ModelAndView crossCompare(@RequestParam Map<String, Object> params, ModelAndView model, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

        model.setViewName("bjw/index");
        return model;
    }

    @RequestMapping(value = "/vms.do", method = RequestMethod.GET)
    public List<EgovMap> getVMS() throws SQLException {
        return bjwService.selectVMS();
    }

    @RequestMapping(value = "/cctv.do")
    public List<EgovMap> getCCTV() throws SQLException {
        return bjwService.selectCCTV();
    }

}
