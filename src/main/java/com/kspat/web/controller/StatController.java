package com.kspat.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kspat.util.common.DateTimeUtil;
import com.kspat.util.common.SessionUtil;
import com.kspat.web.domain.Calendar;
import com.kspat.web.domain.CodeData;
import com.kspat.web.domain.DailyStat;
import com.kspat.web.domain.DayEvent;
import com.kspat.web.domain.Score;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.domain.SessionInfo;
import com.kspat.web.domain.LatePoint;
import com.kspat.web.service.CalendarService;
import com.kspat.web.service.CodeService;
import com.kspat.web.service.DashboardService;
import com.kspat.web.service.StatService;
import com.kspat.web.service.UserService;

@RequestMapping(value = "/stat/*")
@Controller
public class StatController {
	private static final Logger logger = LoggerFactory.getLogger(StatController.class);

	@Autowired
	private StatService statService;

	@Autowired
	private UserService userService;

	@Autowired
	private CalendarService calendarService;

	@Autowired
	private CodeService codeService;

	@Autowired
	private DashboardService dashboardService;

	DateTimeFormatter fmt_yyyy = DateTimeFormat.forPattern("yyyy");

	/** 관리자 근태확인 화면 호출
	 * @param model
	 * @param searchParam
	 * @return
	 */
	@RequestMapping(value = "/aDailyStat")
	public String aDailyStat(Model model, SearchParam searchParam, HttpServletRequest request) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		if(!"003".equals(info.getAuthCd())) return "redirect:/";

		List<CodeData> deptList = codeService.getCommonCodeList("DEPT");
		model.addAttribute("deptList", deptList);
		return "stat/aDailyStat";
	}

	/** 통계 수동 생성
	 * @param model
	 * @param searchParam
	 * @return
	 */
	@RequestMapping(value = "/manualCreateAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String manualCreateAjax(Model model,SearchParam searchParam,HttpServletRequest request) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		searchParam.setCrtdId(Integer.toString(info.getId()));

		//dataError여부 update
		Calendar cal = new Calendar(searchParam.getSearchDt(),searchParam.getDataError(), Integer.toString(info.getId()));
		calendarService.updateDataError(cal);

		List<DailyStat> list = statService.manualCreateDailyStat(searchParam);


		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(null);
	}


	/** dataError check
	 * @param model
	 * @param searchParam
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/checkCalendarDataErrorAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String checkCalendarDataErrorAjax(Model model,SearchParam searchParam,HttpServletRequest request) {

		String res = calendarService.checkCalendarDataError(searchParam);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(res);
	}


	/** user 통게 목록
	 * @param model
	 * @param searchParam
	 * @return
	 */
	@RequestMapping(value = "/getDailyStatListAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String getDailyStatListAjax(Model model,SearchParam searchParam, HttpServletRequest request) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		if("001".equals(info.getAuthCd())){
			searchParam.setSearchUser(Integer.toString(info.getId()));
			searchParam.setSearchDept("all");
		}

		List<DailyStat> list = statService.getDailyStatList(searchParam);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(list);
	}


	/** 개인 근태 상세정보
	 * @param model
	 * @param searchParam
	 * @return
	 */
	@RequestMapping(value = "/getUserStatDetailAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String getUserStatDetailAjax(Model model,SearchParam searchParam) {
		logger.debug(searchParam.toString());
		DailyStat stat = statService.getUserStatDetail(searchParam);
		searchParam.setCrtdId(searchParam.getSearchUser());
		List<DayEvent> events = dashboardService.getDayEventList(searchParam);

		Map<String,Object> map = new HashMap<String,Object>();
		map.put("stat", stat);
		map.put("events", events);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(map);
	}

	/** 사후보상
	 * @param model
	 * @param searchParam
	 * @return
	 */
	@RequestMapping(value = "/adjustAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String adjustAjax(Model model, DailyStat ds,HttpServletRequest request) {
		//logger.debug(ds.toString());
		SessionInfo info =SessionUtil.getSessionInfo(request);
		ds.setMdfyId(Integer.toString(info.getId()));
		DailyStat stat = statService.updateAdjust(ds);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(stat);
	}

	/** 매니져 근태점수 화면 호출
	 * @param model
	 * @param searchParam
	 * @return
	 */
	@RequestMapping(value = "/mScoreStat")
	public String mScoreStat(Model model, SearchParam searchParam, HttpServletRequest request) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		if(!"002".equals(info.getAuthCd())) return "redirect:/";

		List<CodeData> deptList = userService.getManagerDeptList(info.getId());
		model.addAttribute("deptList", deptList);
		return "stat/aScoreStat";
	}

	@RequestMapping(value = "/aScoreStat")
	public String aScoreStat(Model model, SearchParam searchParam, HttpServletRequest request) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		if(!"003".equals(info.getAuthCd())) return "redirect:/";

		List<CodeData> deptList = codeService.getCommonCodeList("DEPT");
		model.addAttribute("deptList", deptList);
		return "stat/aScoreStat";
	}


	/** 근태점수
	 * @param model
	 * @param param
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getScoreListAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String getScoreListAjax(Model model, SearchParam param,HttpServletRequest request) {
		//logger.debug(ds.toString());
		SessionInfo info =SessionUtil.getSessionInfo(request);

		//logger.debug(param.toString());

		List<Score> list = statService.getScoreList(param);


		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(list);
	}


	/**
	 * @param model
	 * @param searchParam
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/mDailyStat")
	public String mDailyStat(Model model, SearchParam searchParam, HttpServletRequest request) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		if(!"002".equals(info.getAuthCd())) return "redirect:/";

		List<CodeData> deptList = userService.getManagerDeptList(info.getId());
		model.addAttribute("deptList", deptList);
		return "stat/aDailyStat";
	}



	/** 일반 user 근태확인 호출
	 * @param model
	 * @param searchParam
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/uDailyStat")
	public String uDailyStat(Model model, SearchParam searchParam, HttpServletRequest request) {
		return "stat/uDailyStat";
	}


	@RequestMapping(value = "/scoreAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String scoreAjax(Model model, DailyStat ds,HttpServletRequest request) {
		//logger.debug(ds.toString());
		SessionInfo info =SessionUtil.getSessionInfo(request);
		SearchParam param = new SearchParam();

		param.setId(Integer.toString(info.getId()));
		param.setSearchYear(DateTimeUtil.getTodayYearString());

		logger.debug(param.toString());

		Score score = statService.getUserScore(param);


		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(score);
	}

	/** 지각점수화면
	 * @param model
	 * @param searchParam
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/lateStat")
	public String lateStat(Model model, SearchParam searchParam, HttpServletRequest request) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		if(!"003".equals(info.getAuthCd())) return "redirect:/";

		List<CodeData> deptList = codeService.getCommonCodeList("DEPT");
		model.addAttribute("deptList", deptList);
		return "stat/lateStat";
	}


	/** 지각점수목록
	 * @param model
	 * @param param
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getLatePointListAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String getLatePointListAjax(Model model, SearchParam param,HttpServletRequest request) {
		//logger.debug(ds.toString());
		//SessionInfo info =SessionUtil.getSessionInfo(request);
		logger.debug(param.toString());

		List<LatePoint> list = statService.getLatePointList(param);
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(list);
	}


	/** 지각 통계 수동 생성
	 * @param model
	 * @param searchParam
	 * @return
	 */
	@RequestMapping(value = "/lateStatUpdateAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String lateStatUpdateAjax(Model model,SearchParam searchParam,HttpServletRequest request) {
		DateTime dateTime = new DateTime();
		String targetYear = dateTime.minusDays(1).toString(fmt_yyyy);
		//targetYear="2016";
	    logger.debug("Late stat update year - " + targetYear);

	    int[] result = statService.updateLateStat(targetYear);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(result);
	}



}
