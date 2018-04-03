package com.kspat.util.common;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

public class DateTimeUtil {

	static DateTimeFormatter fmt_ymd = DateTimeFormat.forPattern("yyyy-MM-dd");
	static DateTimeFormatter fmt_y = DateTimeFormat.forPattern("yyyy");
	static DateTimeFormatter fmt_ymd_hm = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm");
	static DateTimeFormatter fmt_ymdhms = DateTimeFormat.forPattern("yyyyMMddHHmmss");


	/**
	 * today String
	 * @return
	 */
	public static final String getTodayString(){
		DateTime dateTime = new DateTime();
		String today = dateTime.toString(fmt_ymd);
		//today="2016-08-01";
		return today;
	}

	public static final String getTomorrowString(){
		DateTime today = fmt_ymd.parseDateTime(getTodayString());
		String tomorrow = today.plusDays(1).toString(fmt_ymd);
		return tomorrow;
	}


	public static final String getTodayTimeString(){
		DateTime dateTime = new DateTime();
		String todayTime = dateTime.toString(fmt_ymd_hm);

		return todayTime;
	}

	public static final String getTodayYearString(){
		DateTime dateTime = new DateTime();
		String todayYear = dateTime.toString(fmt_y);

		return todayYear;
	}


	public static final DateTime parseStringToDatetime(String dt,String pattern){
		DateTimeFormatter formatter = DateTimeFormat.forPattern(pattern);
		DateTime dateTime = formatter.parseDateTime(dt);
		return dateTime;
	}

	public static final String parseDatetimeToStrong(DateTime dt,String pattern){
		String calDt = dt.toString(pattern);
		return calDt;
	}

	/** 퇴근예정시간계산.
	 * @param calHereGo
	 * @param workTime
	 * @return
	 */
	public static String getExpectedHereOutTime(String calHereGo, int workTime) {
		DateTime dt = fmt_ymd_hm.parseDateTime(calHereGo);
		String calDt = dt.plusMinutes(workTime).toString(fmt_ymd_hm);
		return calDt;
	}

	public static final String getSystemFileName(String orgName){
		DateTime dateTime = new DateTime();
		String today = dateTime.toString(fmt_ymdhms);

		return today+"_"+orgName;
	}





}
