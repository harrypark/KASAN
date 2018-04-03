package com.kspat.web.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kspat.web.domain.Calendar;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.domain.DayInfo;
import com.kspat.web.mapper.CalendarMapper;
import com.kspat.web.service.CalendarService;

@Service
public class CalendarServiceImpl implements CalendarService {

	@Autowired
	private CalendarMapper calendarMapper;

	@Override
	public List<Calendar> getHolidayList(SearchParam searchParam) {
		return calendarMapper.getHolidayList(searchParam);
	}

	@Override
	public Calendar getHolidayDetail(Calendar calendar) {
		return calendarMapper.getHolidayDetail(calendar);
	}

	@Override
	public Calendar updateHoliday(Calendar calendar) {
		if("N".equals(calendar.getCalHolidayYn())){
			calendar.setCalHolidayName(null);
		}

		calendarMapper.updateHoliday(calendar);
		Calendar cg = calendarMapper.getHolidayDetail(calendar);
		return cg;
	}

	@Override
	public DayInfo getDayInfo(String day) {
		return calendarMapper.getDayInfo(day);
	}

	@Override
	public void updateDataError(Calendar cal) {
		calendarMapper.updateDataError(cal);
	}

	@Override
	public String checkCalendarDataError(SearchParam searchParam) {
		return calendarMapper.checkCalendarDataError(searchParam);
	}
}
