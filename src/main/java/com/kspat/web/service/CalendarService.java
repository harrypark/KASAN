package com.kspat.web.service;

import java.util.List;

import com.kspat.web.domain.Calendar;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.domain.DayInfo;

public interface CalendarService {

	List<Calendar> getHolidayList(SearchParam searchParam);

	Calendar getHolidayDetail(Calendar calendar);

	Calendar updateHoliday(Calendar calendar);

	DayInfo getDayInfo(String today);

	void updateDataError(Calendar cal);

	String checkCalendarDataError(SearchParam searchParam);

}
