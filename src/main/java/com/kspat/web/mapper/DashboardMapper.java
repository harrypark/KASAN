package com.kspat.web.mapper;

import java.util.List;

import com.kspat.web.domain.DayEvent;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.domain.UserState;

public interface DashboardMapper {

	List<DayEvent> getDayEventList(SearchParam searchParam);

	List<UserState> dashUserStateList(SearchParam searchParam);

	List<DayEvent> getAllUserEventList(SearchParam searchParam);

}
