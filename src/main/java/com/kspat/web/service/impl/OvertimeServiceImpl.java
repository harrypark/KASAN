package com.kspat.web.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kspat.web.domain.DayInfo;
import com.kspat.web.domain.Overtime;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.mapper.CalendarMapper;
import com.kspat.web.mapper.OvertimeMapper;
import com.kspat.web.service.OvertimeService;

@Service
public class OvertimeServiceImpl implements OvertimeService {

	@Autowired
	private OvertimeMapper overtimeMapper;

	@Autowired
	private CalendarMapper calendarMapper;


	@Override
	public Overtime getReqDateOvertimeInfo(SearchParam searchParam) {

		Overtime overtime = overtimeMapper.getReqDateOvertimeInfo(searchParam);
		if(overtime == null){
			DayInfo dayInfo = calendarMapper.getDayInfo(searchParam.getSearchDt());
			//System.out.println(dayInfo);
			overtime = new Overtime();
			overtime.setResult("nodata");
			overtime.setHolidayYn("Y".equals(dayInfo.getIsHoliday())?true:false);
		}
		//중복신청 체크
		int chk = overtimeMapper.checkDuplicateReq(searchParam);
		overtime.setDuplicateReq(chk>0?true:false);

		return overtime;
	}


	@Override
	public Overtime insertOvertime(Overtime overtime) {
		overtimeMapper.insertOvertime(overtime);

		Overtime ot = overtimeMapper.getOvertimeDetail(overtime.getId());


		return ot;
	}


	@Override
	public List<Overtime> getOvertimeListById(SearchParam searchParam) {
		return overtimeMapper.getOvertimeListById(searchParam);
	}


	@Override
	public List<Overtime> getOvertimeAdminList(SearchParam searchParam) {
		return overtimeMapper.getOvertimeAdminList(searchParam);
	}

}
