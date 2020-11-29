package com.kspat.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kspat.util.common.SessionUtil;
import com.kspat.web.domain.CodeData;
import com.kspat.web.domain.CodeGroup;
import com.kspat.web.domain.Reservation;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.domain.SessionInfo;
import com.kspat.web.service.CodeService;
import com.kspat.web.service.ReservationService;

@RequestMapping(value = "/reservation/*")
@Controller
public class ReservationController {
	private static final Logger logger = LoggerFactory.getLogger(ReservationController.class);

	@Autowired
	private CodeService codeService;

	@Autowired
	private ReservationService reservationService;


	@RequestMapping(value = "/{type}/{code}/list")
	public String deptDepts(@PathVariable String type,@PathVariable String code, Model model, HttpServletRequest request) {
		//SessionInfo info =SessionUtil.getSessionInfo(request);

		CodeGroup group = codeService.getCodeGroupDetailByGroupKey(type.toUpperCase());
		if(group == null) return "redirect:/";


		List<CodeData> codeList = codeService.getCommonCodeList(type.toUpperCase());
		model.addAttribute("codeList", codeList);

		model.addAttribute("group", group);
		model.addAttribute("type", type);
		model.addAttribute("code", code);

//		logger.debug("type:{}",type);


		return "reservation/list";
	}


	/** event list
	 * @param model
	 * @param searchParam
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/reservation/getListAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String getListAjax(Model model,SearchParam searchParam,HttpServletRequest request) {
		//SessionInfo info =SessionUtil.getSessionInfo(request);

		List<Reservation> list = reservationService.getReservationList(searchParam);
		logger.debug("list:{}",list.size());

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(list);
	}


	/** 선택일의 최대가능 종료시간 체크
	 * @param model
	 * @param reservation
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/reservation/getSeletDayTimeLimitAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String getSeletDayTimeLimitAjax(Model model,Reservation reservation,HttpServletRequest request) {
		//SessionInfo info =SessionUtil.getSessionInfo(request);

		Reservation res = reservationService.getSeletDayTimeLimit(reservation);
		logger.debug("Reservation:{}",res);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(res);
	}


	/** 등록
	 * @param model
	 * @param reservation
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/reservation/insertAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String insertAjax(Model model,Reservation reservation,HttpServletRequest request) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		reservation.setCrtdId(Integer.toString(info.getId()));

		Reservation res = reservationService.insertReservation(reservation);
		logger.debug("Reservation:{}",res);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(res);
	}

	/** 수정
	 * @param model
	 * @param reservation
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/reservation/updateAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String updateAjax(Model model,Reservation reservation,HttpServletRequest request) {
		SessionInfo info =SessionUtil.getSessionInfo(request);
		reservation.setCrtdId(Integer.toString(info.getId()));

		Reservation res = reservationService.updateReservation(reservation);
		logger.debug("Reservation:{}",res);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(res);
	}


	/** 삭제
	 * @param model
	 * @param reservation
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/reservation/deleteAjax",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String deleteAjax(Model model,Reservation reservation,HttpServletRequest request) {

		int res = reservationService.deleteReservation(reservation);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(res);
	}
}
