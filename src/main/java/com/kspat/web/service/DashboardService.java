package com.kspat.web.service;

import java.util.List;

import com.kspat.web.domain.DayEvent;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.domain.UserState;

public interface DashboardService {

	List<DayEvent> getDayEventList(SearchParam searchParam);

	List<UserState> dashUserStateList(SearchParam searchParam);

	List<DayEvent> getAllUserEventList(SearchParam searchParam);

}
