package com.kspat.web.service.impl;

import java.util.List;

import org.joda.time.DateTime;
import org.joda.time.Minutes;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ch.qos.logback.classic.Logger;

import com.kspat.util.common.DailyStatUtil;
import com.kspat.util.common.DateTimeUtil;
import com.kspat.web.domain.DailyRule;
import com.kspat.web.domain.DayEvent;
import com.kspat.web.domain.DayInfo;
import com.kspat.web.domain.Replace;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.domain.UserState;
import com.kspat.web.domain.Workout;
import com.kspat.web.mapper.CalendarMapper;
import com.kspat.web.mapper.CodeMapper;
import com.kspat.web.mapper.DashboardMapper;
import com.kspat.web.mapper.RuleMapper;
import com.kspat.web.service.DashboardService;

@Service
public class DashboardServiceImpl implements DashboardService {
	private static final Logger logger = (Logger) LoggerFactory.getLogger(DashboardServiceImpl.class);


	@Autowired
	private DashboardMapper dashboardMapper;

	@Autowired
	private CalendarMapper calendarMapper;

	@Autowired
	private CodeMapper codeMapper;

	@Autowired
	private RuleMapper ruleMapper;

	@Override
	public List<DayEvent> getDayEventList(SearchParam searchParam) {
		return dashboardMapper.getDayEventList(searchParam);
	}


	@Override
	public List<UserState> dashUserStateList(SearchParam searchParam) {

		String calDt = searchParam.getSearchDt();
		if(calDt == null){
			calDt = DateTimeUtil.getTodayString();
		}
		DayInfo dayInfo = calendarMapper.getDayInfo(calDt);
		DailyRule dailyRule = ruleMapper.getCurrentDailyRule(calDt);

		List<UserState> list =  dashboardMapper.dashUserStateList(searchParam);
		if(list.size()>0){
			list = DailyStatUtil.getNowWorking(list,calDt, dayInfo,dailyRule);

			list = DailyStatUtil.getDailyStat(list,calDt, dayInfo,dailyRule);

		}

		return list;
	}


	@Override
	public List<DayEvent> getAllUserEventList(SearchParam searchParam) {
		return dashboardMapper.getAllUserEventList(searchParam);
	}

}
