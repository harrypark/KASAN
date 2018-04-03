package com.kspat;

import org.joda.time.DateTime;
import org.joda.time.DateTime.Property;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.kspat.util.common.DateTimeUtil;
import com.kspat.web.domain.DayInfo;

public class JodaTimeTest {

	public static void main(String[] args) {
		//Formatter
		DateTimeFormatter fmt_ymdhms = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss");
		DateTimeFormatter fmt_ymdhm = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm");
		DateTimeFormatter fmt_ymd = DateTimeFormat.forPattern("yyyy-MM-dd");

		
		DateTime dateTime = new DateTime();
		String currDate = dateTime.toString(fmt_ymd);
		System.out.println("============ Raw Data check ("+currDate+")=====================");
		
		//DayInfo todayInfo = calendarMapper.getDayInfo(currDate);
		//logger.debug("오늘 정보 : {}",todayInfo.toString());
		
		String currDateTime = dateTime.toString(fmt_ymdhm);
		String prevDateTime = dateTime.minusHours(2).toString(fmt_ymdhm);
		
		
		System.out.println("Raw Data 검색시간 : "+prevDateTime+" ~ "+currDateTime);
		
		
	    System.out.println("Current time - " + dateTime.toString(fmt_ymdhms));
	}

}
