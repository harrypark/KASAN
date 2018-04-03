package com.kspat.web.controller;

import java.sql.SQLException;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kspat.util.common.SessionUtil;
import com.kspat.web.domain.Documents;
import com.kspat.web.domain.Pwd;
import com.kspat.web.domain.SessionInfo;
import com.kspat.web.domain.User;
import com.kspat.web.service.HomeService;
import com.kspat.web.service.UserService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private HomeService homeService;

	@Autowired
	private UserService userService;

	@RequestMapping(value = "/index")
	public String index( Model model, HttpServletRequest request, HttpServletResponse response) throws SQLException {
    	SessionInfo info =SessionUtil.getSessionInfo(request);
    	System.out.println("index info:"+info);
    	if(info == null){
    		return "redirect:/login";
    	}else{
    		if("003".equals(info.getAuthCd())){
    			return "redirect:/stat/aDailyStat";
    		}else{
    			return "redirect:/dashboard";
    		}

    	}
	}



	/**
	 * Simply selects the home view to render by returning its name.
	 * @throws SQLException
	 */
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(Locale locale, Model model) throws SQLException {
		logger.info("Welcome home! The client locale is {}.", locale);
		return "home";
	}

	/** 내정보
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws SQLException
	 */
	@RequestMapping(value = "/user/profile")
	public String profile( Model model, HttpServletRequest request, HttpServletResponse response) throws SQLException {
		logger.debug("[HomeController::profile] enter~!!!!!");
    	SessionInfo info =SessionUtil.getSessionInfo(request);
    	User user = userService.getUserDetailById(Integer.toString(info.getId()));
    	model.addAttribute("user", user);
    	return "user/profile";
	}

	/** 비밀번호변경
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws SQLException
	 */
	@RequestMapping(value = "/user/pwdChange")
	public String pwdChange( Model model, HttpServletRequest request, HttpServletResponse response) throws SQLException {
		logger.debug("[HomeController::pwdChange] enter~!!!!!");
    	HttpSession session = request.getSession(false);
    	return "user/pwdChange";
	}

	@RequestMapping(value = "/user/pwdChangeAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String userPwdInitAjax(Model model,Pwd pwd ,HttpServletRequest request, HttpServletResponse response) {
		String res = userService.userPasswordChange(pwd);
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(res);
	}

}
