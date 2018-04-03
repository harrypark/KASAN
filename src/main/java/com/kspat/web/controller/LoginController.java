package com.kspat.web.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kspat.util.common.SessionUtil;
import com.kspat.web.domain.LoginInfo;
import com.kspat.web.domain.RawData;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.domain.SessionInfo;
import com.kspat.web.domain.User;
import com.kspat.web.service.LoginService;


@Controller
public class LoginController {
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	@Autowired
	private LoginService loginService;



	@RequestMapping(value = "/login")
	public String login(Model model) throws SQLException {
		return "login/login";
	}

	@RequestMapping(value="/loginCheckAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String loginCheckAjax(Model model, LoginInfo loginInfo,HttpServletRequest request, HttpServletResponse response){
		logger.debug(loginInfo.toString());
		User user = loginService.getLoginCheck(loginInfo);

		if(user.isLogin() == true){
		//session 정보 저장
		HttpSession session = request.getSession(true);
    		session.setAttribute("id", user.getId());
    		session.setAttribute("capsId", user.getCapsId());
    		session.setAttribute("capsName", user.getCapsName());
    		session.setAttribute("authCd", user.getAuthCd());
    		session.setAttribute("authName", user.getAuthName());
    		session.setAttribute("deptCd", user.getDeptCd());
    		session.setAttribute("deptName", user.getDeptName());
//    		logger.debug("===============>session info (id):"+session.getAttribute("id"));
//    		logger.debug("===============>session info (capsId):"+session.getAttribute("capsId"));
//    		logger.debug("===============>session info (capsName):"+session.getAttribute("capsName"));
//    		logger.debug("===============>session info (authCd):"+session.getAttribute("authCd"));
//    		logger.debug("===============>session info (authName):"+session.getAttribute("authName"));

    		SessionInfo info =SessionUtil.getSessionInfo(request);
    		logger.debug(info.toString());

		}

		LoginInfo info = new LoginInfo(user.isLogin(),user.isFirstLogin());


		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(info);
	}

	@RequestMapping(value = "/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		logger.debug("[LoginController::signout] enter~!!!!!");
    	HttpSession session = request.getSession(false);
    	session.invalidate();
    	logger.debug(request.getContextPath()+"/login");
		return "redirect:/login";
	}
}
