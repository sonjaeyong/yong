package egovframework.psj.web;

import egovframework.psj.service.PsjService;
import org.apache.ibatis.io.Resources;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.util.*;

@Controller
@RequestMapping("/psj")
public class PsjController {

    @Resource(name = "psjService")
    private PsjService psjService;

    @RequestMapping(value="/index.do")
    public String index(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception{
        model.addAttribute("params", params);
//        VMS
//        V_VMS_STATUS_CUR
//        CROSS_CAMERA
//        V_CROSS_CAMERA_STATUS_CUR

        return "psj/index";
    }

    @ResponseBody
    @RequestMapping(value = "/selectCamListAjax.do")
    public Object selectCamListAjax() throws Exception {
        return psjService.selectCamListAjax();
    }

    @ResponseBody
    @RequestMapping(value = "/selectCamStatListAjax.do")
    public Object selectCamStatListAjax() throws Exception {
        return psjService.selectCamStatListAjax();
    }

    @ResponseBody
    @RequestMapping(value = "/selectVmsListAjax.do")
    public Object selectVmsListAjax() throws Exception {
        return psjService.selectVmsListAjax();
    }

    @ResponseBody
    @RequestMapping(value = "/selectVmsStatListAjax.do")
    public Object selectVmsStatListAjax() throws Exception {
        return psjService.selectVmsStatListAjax();
    }

}