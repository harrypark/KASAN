package com.kspat.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import com.kspat.web.domain.CodeData;
import com.kspat.web.domain.DashCalendar;
import com.kspat.web.domain.DashPrivate;
import com.kspat.web.domain.DayEvent;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.domain.SessionInfo;
import com.kspat.web.domain.DayInfo;
import com.kspat.web.domain.UserState;
import com.kspat.web.service.CalendarService;
import com.kspat.web.service.CodeService;
import com.kspat.web.service.DashboardService;
import com.kspat.web.service.UserService;

@Controller
public class DashboardController {
	private static final Logger logger = LoggerFactory.getLogger(DashboardController.class);

	DateTimeFormatter fmt_ymd = DateTimeFormat.forPattern("yyyy-MM-dd");

	@Autowired
	private DashboardService dashboardService;

	@Autowired
	private CalendarService calendarService;

	@Autowired
	private CodeService codeService;
	
	@Autowired
	private UserService userService;

	@RequestMapping(value = "/dashboard")
	public String dashboard(Model model,HttpServletRequest request){
		SessionInfo info =SessionUtil.getSessionInfo(request);
		SearchParam searchParam = new SearchParam();
		//test
		//info.setId(109);
		
		
		
		searchParam.setCrtdId(Integer.toString(info.getId()));
		searchParam.setSearchDt(DateTimeUtil.getTodayString());

		DayInfo todayInfo = calendarService.getDayInfo(DateTimeUtil.getTodayString());
		List<DayEvent> todayEvent = dashboardService.getDayEventList(searchParam);


		searchParam.setSearchDt(DateTimeUtil.getTomorrowString());
		List<DayEvent> tomorrowEvent = dashboardService.getDayEventList(searchParam);


		List<CodeData> deptList = codeService.getCommonCodeList("DEPT");

		model.addAttribute("deptList",deptList);
		model.addAttribute("todayInfo",todayInfo);
		model.addAttribute("todayEvent",todayEvent);
		model.addAttribute("tomorrowEvent",tomorrowEvent);
		return "dashboard";
	}

	/** Dashboard 부서정보
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/dashDeptListAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String dashDeptListAjax(Model model, HttpServletRequest request) {

		List<CodeData> deptList = codeService.getCommonCodeList("DEPT");
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(deptList);
	}


	@RequestMapping(value="/dashUserStateAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String dashUserStateAjax(Model model, HttpServletRequest request) {
		SessionInfo info =SessionUtil.getSessionInfo(request);

		SearchParam searchParam = new SearchParam();
		searchParam.setCrtdId(Integer.toString(info.getId()));

		searchParam.setSearchDt(DateTimeUtil.getTodayString());

		List<UserState> userList = dashboardService.dashUserStateList(searchParam);
//		for(UserState us: userList){
//			logger.debug(us.toString());
//		}

		List<DayEvent> eventList = dashboardService.getAllUserEventList(searchParam);


		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userList", userList);
		map.put("eventList", eventList);



		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(map);
	}
	
	/** 대시보드 캘린더
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/dashboard/calendar")
	public String calendar(Model model,HttpServletRequest request){
		SessionInfo info =SessionUtil.getSessionInfo(request);
		List<CodeData> deptList = null;
		deptList = codeService.getCommonCodeList("DEPT");
		model.addAttribute("deptList", deptList);
		model.addAttribute("userDept", info.getDeptCd());
		return "dashboard/calendar";
	}
	
	/** 대시보드 캘린더 불러오기
	 * @param model
	 * @param searchParam
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/dashboard/getCalendarAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String getCalendarAjax(Model model,SearchParam searchParam,HttpServletRequest request) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		if(searchParam.getSearchUser() == null) {
			searchParam.setSearchUser(String.valueOf(info.getId()));
		}
			
		//logger.debug(searchParam.toString());
		List<DashCalendar> list = dashboardService.getCalendarList(searchParam);
		//logger.debug("list:{}",list.size());

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(list);
	}
	
	/** 개인일정 검색
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/dashboard/private")
	public String privateSrarch(Model model,HttpServletRequest request){
		SessionInfo info =SessionUtil.getSessionInfo(request);
		
		List<CodeData> deptList = null;
		deptList = codeService.getCommonCodeList("DEPT");
		model.addAttribute("deptList", deptList);
		model.addAttribute("userDept", info.getDeptCd());
		model.addAttribute("userId", info.getId());
		
		
		return "dashboard/private";
	}

	@RequestMapping(value = "/dashboard/getPrivateAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String getPrivateAjax(Model model,SearchParam searchParam,HttpServletRequest request) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
//		if(searchParam.getSearchUser() == null) {
//			searchParam.setSearchUser(String.valueOf(info.getId()));
//		}
			
		//logger.debug(searchParam.toString());
		List<DashPrivate> list = dashboardService.getPrivateList(searchParam);
		//logger.debug("list:{}",list.size());

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(list);
	}
}
