package egovframework.gnpsj.web;

import egovframework.gnpsj.service.GnPsjService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Controller
@RequestMapping("/gnpsj")
public class GnPsjController {

    @Resource(name = "gnPsjService")
    private GnPsjService gnPsjService;

    @RequestMapping(value = "/gn_index.do")
    public String selectEmergencyVeh(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception {
        model.addAttribute("vehList", gnPsjService.selectEmergencyVeh());
        return "psj/gn_index";
    }

    @ResponseBody
    @RequestMapping(value = "/selectEmergencyLocAjax.do")
    public Object selectEmergencyLocAjax(@RequestParam Map<String, Object> params) throws Exception {
        return gnPsjService.selectEmergencyLocAjax(params);
    }

    @ResponseBody
    @RequestMapping(value = "/selectEmergencyRouteAjax.do")
    public Object selectEmergencyRouteAjax(@RequestParam Map<String, Object> params) throws Exception {
        return gnPsjService.selectEmergencyRouteAjax(params);
    }
}