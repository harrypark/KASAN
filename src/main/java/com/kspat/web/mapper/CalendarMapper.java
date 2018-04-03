package com.kspat.web.mapper;

import java.util.List;

import com.kspat.web.domain.Calendar;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.domain.DayInfo;

public interface CalendarMapper {

	List<Calendar> getHolidayList(SearchParam searchParam);

	Calendar getHolidayDetail(Calendar calendar);

	void updateHoliday(Calendar calendar);

	DayInfo getDayInfo(String day);

	void updateDataError(Calendar cal);

	String checkCalendarDataError(SearchParam searchParam);

}
