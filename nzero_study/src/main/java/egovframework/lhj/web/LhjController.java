package egovframework.lhj.web;

import egovframework.lhj.service.LhjService;
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
@RequestMapping("/lhj")
public class LhjController {

    @Resource(name = "lhjService")
    private LhjService lhjService;

    @RequestMapping(value="/index.do")
    public String index(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception{
        model.addAttribute("params", params);


        return "lhj/index";
    }

   
}