package com.kspat.web.scheduler;

import java.util.List;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.kspat.util.common.DateTimeUtil;
import com.kspat.web.domain.Calendar;
import com.kspat.web.domain.DayInfo;
import com.kspat.web.domain.RawData;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.mapper.CalendarMapper;
import com.kspat.web.service.CalendarService;
import com.kspat.web.service.EmailTempleatService;
import com.kspat.web.service.UserService;

@Component
public class RawDataScheduler {

	/** The logger.<br/> 로거. */
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private UserService userService;

	@Autowired
	private CalendarMapper calendarMapper;

	@Autowired
	private EmailTempleatService emailTempleatService;

	//Formatter
	DateTimeFormatter fmt_ymdhms = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss");
	DateTimeFormatter fmt_ymdhm = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm");
	DateTimeFormatter fmt_ymdhm2 = DateTimeFormat.forPattern("yyyyMMddHHmmss");
	DateTimeFormatter fmt_ymd = DateTimeFormat.forPattern("yyyy-MM-dd");


	/*
	 * 휴일제외
	 * 09:30,11:30,13:30,15:30,17:30,19:30
	 *
	 * 초	분	시	                          일	월	요일
     * 0	30	9,11,13,15,17,19	*	*	MON-FRI
	 */
	@Scheduled(cron = "0 30 9,11,13,15,17,19 * * MON-FRI") //
	//@Scheduled(cron = "0 02 9,11,13,15,17,19,23 * * SUN") //
	public void scheduleRawDataCheckTask() {

	    DateTime dateTime = new DateTime();
		String currDate = dateTime.toString(fmt_ymd);
		logger.debug("============ Raw Data check ({})=====================",currDate);

		DayInfo todayInfo = calendarMapper.getDayInfo(currDate);
		logger.debug("오늘 정보 : {}",todayInfo.toString());
		logger.debug("휴일인가? : {}",todayInfo.getIsHoliday());
		//휴일이 아니라면 2시간동안의 RowData count 체크
		if("N".equals(todayInfo.getIsHoliday())){
			String toDate = dateTime.toString(fmt_ymdhm2);
			String fromDate = dateTime.minusHours(2).toString(fmt_ymdhm2);
			SearchParam searchParam = new SearchParam(fromDate,toDate);

			int dataCount = userService.getRawDataCheckCount(searchParam);

			if(dataCount > 0){
				logger.debug("Raw Data 정상");
			}else{
				logger.debug("Raw Data 비정상 check 요망 메일발송.");
				emailTempleatService.setRawDataEmailTempleate(toDate);

			}

			logger.debug("Raw Data 검색시간 : "+fromDate+" ~ "+toDate);
		}

	}
}
