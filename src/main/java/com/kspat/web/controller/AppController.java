package com.kspat.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.kspat.util.common.DateTimeUtil;
import com.kspat.util.common.SessionUtil;
import com.kspat.web.domain.AvailableReplaceInfo;
import com.kspat.web.domain.BusinessTrip;
import com.kspat.web.domain.CodeData;
import com.kspat.web.domain.DailyRule;
import com.kspat.web.domain.HalfLeave;
import com.kspat.web.domain.Leave;
import com.kspat.web.domain.Replace;
import com.kspat.web.domain.Score;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.domain.SessionInfo;
import com.kspat.web.domain.Workout;
import com.kspat.web.service.BusinessTripService;
import com.kspat.web.service.CodeService;
import com.kspat.web.service.LeaveService;
import com.kspat.web.service.ReplaceService;
import com.kspat.web.service.RuleService;
import com.kspat.web.service.StatService;
import com.kspat.web.service.WorkoutService;

/**
 * 신청 controller (application)
 * @author harry
 *
 */
@RequestMapping(value = "/app/*")
@Controller
public class AppController {
	private static final Logger logger = LoggerFactory.getLogger(AppController.class);

	@Autowired
	private WorkoutService workoutService;

	@Autowired
	private BusinessTripService businessTripService;

	@Autowired
	private LeaveService leaveService;

	@Autowired
	private RuleService ruleService;

	@Autowired
	private StatService statService;

	@Autowired
	private ReplaceService replaceService;
	
	@Autowired
	private CodeService codeService;

	/** 외근공지 화면
	 * @param model
	 * @param searchParam
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/workoutSide")
	public String workoutSide(Model model, SearchParam searchParam,HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		model.addAttribute("info", info);
		logger.debug(info.toString());
		List<CodeData> deptList = codeService.getCommonCodeList("DEPT");
		model.addAttribute("deptList", deptList);
		
		//외근 신청가능시간 (출근가능 시작시간 ~ 출근가능 종료시간+9시간)
		Workout wotm = workoutService.getWorkoutAvailableTime();
		model.addAttribute("wotm",wotm);
		return "app/workoutSide";

	}

	/** 외근공지 등록
	 * @param model
	 * @param workout
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/workoutInsertAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String workoutInsertAjax(Model model, Workout workout,HttpServletRequest request) {
		//logger.debug(workout.toString());
		SessionInfo info =SessionUtil.getSessionInfo(request);
		workout.setCrtdId(Integer.toString(info.getId()));
		workout.setMdfyId(Integer.toString(info.getId()));
		workout.setDeptCd(info.getDeptCd());

		workout = workoutService.insertWorkout(workout);
		//logger.debug("return-->"+workout.toString());

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(workout);
	}


	/** 외근공지 목록
	 * @param model
	 * @param searchParam
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getUserWorkoutListAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String getUserWorkoutListAjax(Model model,SearchParam searchParam,HttpServletRequest request) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
//			if(!"all".equals(searchParam.getSearchUser())) {
//				searchParam.setCrtdId(searchParam.getSearchUser());
//			}
		logger.debug(searchParam.toString());
		
		List<Workout> list = workoutService.getUserWorkoutList(searchParam);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(list);
	}

	/** 외근공지 상세정보 by id
	 * @param model
	 * @param searchParam
	 * @return
	 */
	@RequestMapping(value = "/workoutDetailByIdAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String workoutDetailByIdAjax(Model model,SearchParam searchParam) {

		Workout wo = workoutService.getWorkoutDetailById(searchParam);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(wo);
	}

	/** 외근공지 수정
	 * @param model
	 * @param workout
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/workoutEditAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String workoutEditAjax(Model model,Workout workout,HttpServletRequest request) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		workout.setMdfyId(Integer.toString(info.getId()));

		workout = workoutService.updateWorkout(workout);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(workout);
	}


	/** 외근공지 삭제
	 * @param model
	 * @param searchParam
	 * @return
	 */
	@RequestMapping(value = "/workoutDeleteAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String workoutDeleteAjax(Model model,Workout workout,HttpServletRequest request) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		workout.setCrtdId(Integer.toString(info.getId()));
		workout.setDeptCd(info.getDeptCd());

		int res = workoutService.deleteWorkout(workout);
		logger.debug("삭제 결과:{}",res);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(res);
	}


	@RequestMapping(value = "/businessTrip")
	public String businessTrip(Model model, SearchParam searchParam,HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		model.addAttribute("info", info);
		logger.debug(info.toString());
		
		List<CodeData> deptList = codeService.getCommonCodeList("DEPT");
		model.addAttribute("deptList", deptList);
		return "app/businessTrip";

	}


	@RequestMapping(value="/businessTripInsertAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String businessTripInsertAjax(Model model, BusinessTrip businessTrip,HttpServletRequest request) {
		logger.debug(businessTrip.toString());
		SessionInfo info =SessionUtil.getSessionInfo(request);
		businessTrip.setCrtdId(Integer.toString(info.getId()));
		businessTrip.setMdfyId(Integer.toString(info.getId()));
		businessTrip.setDeptCd(info.getDeptCd());

		businessTrip = businessTripService.insertBusinessTrip(businessTrip);
		//logger.debug("return-->"+workout.toString());

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(businessTrip);
	}


	@RequestMapping(value = "/getUserBusinessTripListAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String getUserBusinessTripListAjax(Model model,SearchParam searchParam,HttpServletRequest request) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		//searchParam.setCrtdId(Integer.toString(info.getId()));

		List<BusinessTrip> list = businessTripService.getUserBusinessTripList(searchParam);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(list);
	}


	@RequestMapping(value = "/businessTripDetailByIdAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String businessTripDetailByIdAjax(Model model,SearchParam searchParam) {

		BusinessTrip bt = businessTripService.getBusinessTripDetailById(searchParam);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(bt);
	}


	@RequestMapping(value = "/businessTripEditAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String businessTripEditAjax(Model model,BusinessTrip businessTrip,HttpServletRequest request) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		businessTrip.setMdfyId(Integer.toString(info.getId()));

		businessTrip = businessTripService.updateBusinessTrip(businessTrip);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(businessTrip);
	}

	@RequestMapping(value = "/businessTripDeleteAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String businessTripDeleteAjax(Model model,BusinessTrip businessTrip,HttpServletRequest request) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		businessTrip.setCrtdId(Integer.toString(info.getId()));
		businessTrip.setDeptCd(info.getDeptCd());

		int res = businessTripService.deleteBusinessTrip(businessTrip);
		logger.debug("삭제 결과:{}",res);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(res);
	}

	/** 통합신청 휴가/반휴/대체근무   ******/

	@RequestMapping(value = "/leave")
	public String leave(Model model, SearchParam searchParam,HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		model.addAttribute("info", info);
		logger.debug(info.toString());
		searchParam.setId(Integer.toString(info.getId()));
		
		List<CodeData> deptList = codeService.getCommonCodeList("DEPT");
		model.addAttribute("deptList", deptList);
		String annualMinusUseYn = leaveService.getAnnualMinusUseYn();
		Score score =  statService.getUserScore(searchParam);


		model.addAttribute("score",score);
		model.addAttribute("annualMinusUseYn",annualMinusUseYn);
		return "app/leave";
	}


	/** 사용가능연차 체크
	 * @param model
	 * @param leave
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/checkAvailableAnnualAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String checkAvailableAnnualCountAjax(Model model,SearchParam searchParam,HttpServletRequest request) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		searchParam.setId(Integer.toString(info.getId()));
		logger.debug("checkAvailableAnnualAjax:"+searchParam.toString());

		Score score =  statService.getUserScore(searchParam);

		Map<String,String> map = new HashMap<String,String>();


		if(score != null){
			map.put("result", "ok");
			map.put("currCount", String.valueOf(score.getCurrCount()));
			if(searchParam.getSearchDt() != null) {//반휴신청만 날짜가넘어온다. 반휴만 대체근무체크
				map.put("hasRe",replaceService.hasSelectDayReplace(searchParam));
			}
			
		}else{
			map.put("result", "fail");
		}

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(map);
	}



	@RequestMapping(value = "/leaveListAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String leaveListAjax(Model model,SearchParam searchParam,HttpServletRequest request) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		searchParam.setCrtdId(Integer.toString(info.getId()));

		List<Leave> list = leaveService.getLeaveList(searchParam);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(list);
	}


	@RequestMapping(value = "/checkLeaveDayCountAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String checkLeaveDayCountAjax(Model model,Leave leave,HttpServletRequest request) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		leave.setCrtdId(Integer.toString(info.getId()));

		int leaveDayCount =  leaveService.checkLeaveDayCount(leave);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(leaveDayCount);
	}


	@RequestMapping(value="/leaveInsertAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String leaveInsertAjax(Model model, Leave leave,HttpServletRequest request) {
		logger.debug(leave.toString());
		SessionInfo info =SessionUtil.getSessionInfo(request);
		leave.setCrtdId(Integer.toString(info.getId()));
		leave.setMdfyId(Integer.toString(info.getId()));
		leave.setDeptCd(info.getDeptCd());

		List<Leave> leaveList = leaveService.insertLeave(leave);
		//logger.debug("return-->"+leave.toString());

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(leaveList);
	}

	@RequestMapping(value = "/leaveDetailAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String leaveDetailAjax(Model model,SearchParam searchParam) {

		Leave leave = leaveService.getLeaveDetail(searchParam);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(leave);
	}

	@RequestMapping(value = "/leaveDeleteAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String leaveDeleteAjax(Model model,Leave leave,HttpServletRequest request) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		leave.setCrtdId(Integer.toString(info.getId()));
		leave.setMdfyId(Integer.toString(info.getId()));
		leave.setDeptCd(info.getDeptCd());
		//logger.debug(leave.toString());

		int res = leaveService.deleteLeave(leave);
		logger.debug("삭제 결과:{}",res);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(res);
	}

	/** 통합신청 반휴   ******/


	@RequestMapping(value = "/halfLeaveListAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String halfLeaveListAjax(Model model,SearchParam searchParam,HttpServletRequest request) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		searchParam.setCrtdId(Integer.toString(info.getId()));

		List<HalfLeave> list = leaveService.getHalfLeaveList(searchParam);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(list);
	}

	@RequestMapping(value="/halfLeaveInsertAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String halfLeaveInsertAjax(Model model, HalfLeave hl,HttpServletRequest request) {
		logger.debug(hl.toString());
		SessionInfo info =SessionUtil.getSessionInfo(request);
		hl.setCrtdId(Integer.toString(info.getId()));
		hl.setMdfyId(Integer.toString(info.getId()));
		hl.setDeptCd(info.getDeptCd());

		hl = leaveService.insertHalfLeave(hl);
		//logger.debug("return-->"+hl.toString());

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(hl);
	}


	@RequestMapping(value = "/halfLeaveDetailAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String halfLeaveDetailAjax(Model model,SearchParam searchParam) {

		HalfLeave hl = leaveService.getHalfLeaveDetail(searchParam);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(hl);
	}

	@RequestMapping(value = "/halfLeaveDeleteAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String halfLeaveDeleteAjax(Model model,HalfLeave hl,HttpServletRequest request) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		hl.setCrtdId(Integer.toString(info.getId()));
		hl.setMdfyId(Integer.toString(info.getId()));
		hl.setDeptCd(info.getDeptCd());
		//logger.debug(hl.toString());

		int res = leaveService.deleteHalfLeave(hl);
		logger.debug("삭제 결과:{}",res);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(res);
	}

	/** 대체근무   ******/
	@RequestMapping(value = "/replace")
	public String replace(Model model, SearchParam searchParam,HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		model.addAttribute("info", info);
		logger.debug(info.toString());
		
		List<CodeData> deptList = codeService.getCommonCodeList("DEPT");
		model.addAttribute("deptList", deptList);
		
		DailyRule dr = ruleService.getCurrentDailyRule(DateTimeUtil.getTodayString());
		Replace replace = replaceService.getReplaceAvailableTime();

		model.addAttribute("dr",dr);
		model.addAttribute("replace",replace);
		return "app/replace";
	}


	@RequestMapping(value = "/checkAvailableReplaceInfoAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String checkAvailableReplaceCountAjax(Model model,SearchParam param,HttpServletRequest request) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		param.setCrtdId(Integer.toString(info.getId()));

		AvailableReplaceInfo repInfo = replaceService.checkAvailableReplaceInfo(param);
		logger.debug(repInfo.toString());

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(repInfo);
	}


	@RequestMapping(value="/replaceInsertAjax",  produces="text/plain;charset=UTF-8", method=RequestMethod.POST)
	public @ResponseBody String replaceInsertAjax(Model model, Replace replace,HttpServletRequest request) {
		logger.debug(replace.toString());
		SessionInfo info =SessionUtil.getSessionInfo(request);
		replace.setCrtdId(Integer.toString(info.getId()));
		replace.setMdfyId(Integer.toString(info.getId()));
		replace.setDeptCd(info.getDeptCd());

		replace = replaceService.insertReplace(replace);
		//logger.debug("return-->"+replace.toString());

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(replace);
	}


	@RequestMapping(value = "/replaceListAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String replaceListAjax(Model model,SearchParam searchParam,HttpServletRequest request) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		//searchParam.setCrtdId(Integer.toString(info.getId()));

		List<Replace> list = replaceService.getReplaceList(searchParam);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(list);
	}


	@RequestMapping(value = "/replaceDeleteAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String replaceDeleteAjax(Model model,Replace replace,HttpServletRequest request) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		replace.setCrtdId(Integer.toString(info.getId()));
		replace.setMdfyId(Integer.toString(info.getId()));
		replace.setDeptCd(info.getDeptCd());
		//logger.debug(hl.toString());

		int res = replaceService.deleteReplace(replace);
		logger.debug("삭제 결과:{}",res);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(res);
	}


	@RequestMapping(value = "/replaceDetailAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String replaceDetailAjax(Model model,SearchParam searchParam) {

		Replace re = replaceService.getReplaceDetail(searchParam);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(re);
	}

	@RequestMapping(value = "/replaceEditAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String replaceEditAjax(Model model,Replace replace,HttpServletRequest request) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		replace.setMdfyId(Integer.toString(info.getId()));
		logger.debug(replace.toString());
		Replace re = replaceService.updateReplace(replace);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(re);
	}


}
