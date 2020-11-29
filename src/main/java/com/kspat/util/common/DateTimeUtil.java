package com.kspat.util.common;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.slf4j.LoggerFactory;

import ch.qos.logback.classic.Logger;

public class DateTimeUtil {
	private static final Logger logger = (Logger) LoggerFactory.getLogger(DateTimeUtil.class);

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
		//today="2019-09-05";
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

	public static String getExpectedHereOutTimeStandardTime(String calHereGo, int workTime) {
		//기준시간 12:00
		DateTime standard = fmt_ymd_hm.parseDateTime(calHereGo.substring(0, 10)+" 12:00");
		logger.info("기준시간:"+standard.toString(fmt_ymd_hm));
		//
		DateTime outrule = fmt_ymd_hm.parseDateTime(calHereGo.substring(0, 10)+" 14:00");
		logger.info("허용시간:"+outrule.toString(fmt_ymd_hm));	
		DateTime dt = fmt_ymd_hm.parseDateTime(calHereGo);
		
		//출근시간이 기준시간 이전이면
		if(dt.isBefore(standard)) {
			//logger.info("=============================================== 12:00 이전출근");
			workTime = workTime+60;
			//logger.info("=============================================== worktime:"+workTime);
		}
		//계산된 퇴근시간
		DateTime calDt1 =  dt.plusMinutes(workTime);
		//logger.info("===============================================111 calDt1.toString(fmt_ymd_hm):"+calDt1.toString(fmt_ymd_hm));
		//12이전 출근이고 퇴근시간이 13:00 이전이라면 점심시간빼고 일찍 보내준다.(13:00 포함)
//		logger.info("dt.isBefore(standard):"+dt.isBefore(standard));
//		logger.info("calDt1.isBefore(outrule):"+calDt1.isBefore(outrule));
//		logger.info("calDt1.isEqual(outrule):"+calDt1.isEqual(outrule));
		
		
		if(dt.isBefore(standard) && ( calDt1.isBefore(outrule) || calDt1.isEqual(outrule))) {
//			logger.info("=============================================== 12:00 이전출근 13시이전 끝남");
			calDt1 = calDt1.minusMinutes(60);
//			logger.info("===============================================222 calDt1.toString(fmt_ymd_hm):"+calDt1.toString(fmt_ymd_hm));
		}
		
		String calDt = calDt1.toString(fmt_ymd_hm);
		
		return calDt;
	}





}
