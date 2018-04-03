package com.kspat.web.controller;

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
import com.kspat.web.domain.CodeData;
import com.kspat.web.domain.Overtime;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.domain.SessionInfo;
import com.kspat.web.service.CalendarService;
import com.kspat.web.service.CodeService;
import com.kspat.web.service.OvertimeService;


@RequestMapping(value = "/overtime/*")
@Controller
public class OvertimeController {
	private static final Logger logger = LoggerFactory.getLogger(OvertimeController.class);

	@Autowired
	private OvertimeService overtimeService;

	@Autowired
	private CalendarService calendarService;

	@Autowired
	private CodeService codeService;



	/** 야근신청 사용자화면
	 * @param model
	 * @param searchParam
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/ulist")
	public String userList(Model model, SearchParam searchParam,HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		List<CodeData> otList = codeService.getCommonCodeList("OVERTIME");

		model.addAttribute("otList", otList);
		return "overtime/ulist";

	}

	/** 야근신청 사용자 목록
	 * @param model
	 * @param searchParam
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/ulistAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String ulistAjax(Model model, SearchParam searchParam,HttpServletRequest request, HttpServletResponse response, HttpSession session){
		SessionInfo info =SessionUtil.getSessionInfo(request);
		searchParam.setCrtdId(Integer.toString(info.getId()));
		List<Overtime>  list = overtimeService.getOvertimeListById(searchParam);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(list);
	}

	/** 야근신청일 가능여부체크
	 * @param model
	 * @param searchParam
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/reqDateCheckAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String reqDateCheckAjax(Model model, SearchParam searchParam,HttpServletRequest request, HttpServletResponse response, HttpSession session){
		SessionInfo info =SessionUtil.getSessionInfo(request);
		searchParam.setCrtdId(Integer.toString(info.getId()));
		Overtime  ot = overtimeService.getReqDateOvertimeInfo(searchParam);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(ot);
	}


	/** 야근신청등록
	 * @param model
	 * @param overtime
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/insertAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String insertAjax(Model model, Overtime overtime,HttpServletRequest request, HttpServletResponse response, HttpSession session){
		SessionInfo info =SessionUtil.getSessionInfo(request);
		overtime.setCrtdId(Integer.toString(info.getId()));
		overtime.setMdfyId(Integer.toString(info.getId()));
		logger.debug("overtime:"+overtime);

		Overtime  ot = overtimeService.insertOvertime(overtime);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(ot);
		//return (new Gson().toJson(list));
	}

	/*
	 * 야근신청 관리자
	 */

	/** 야근신청 목록 (관리자)
	 * @param model
	 * @param searchParam
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/alist")
	public String adminUserList(Model model, SearchParam searchParam,HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		if(!"003".equals(info.getAuthCd())) return "redirect:/";

		List<CodeData> otList = codeService.getCommonCodeList("OVERTIME");
		model.addAttribute("otList", otList);
		List<CodeData> deptList = codeService.getCommonCodeList("DEPT");
		model.addAttribute("deptList", deptList);

		return "overtime/alist";

	}

	/** 야근신청 관리자 목록
	 * @param model
	 * @param searchParam
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/alistAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String alistAjax(Model model, SearchParam searchParam,HttpServletRequest request, HttpServletResponse response, HttpSession session){


		List<Overtime>  list = overtimeService.getOvertimeAdminList(searchParam);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(list);
	}



}
