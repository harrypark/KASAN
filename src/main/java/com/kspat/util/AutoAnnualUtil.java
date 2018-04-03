package com.kspat.util;

import org.apache.commons.lang.StringUtils;
import org.joda.time.DateTime;
import org.joda.time.Days;
import org.joda.time.Months;
import org.joda.time.Years;
import org.joda.time.format.DateTimeFormatter;

import com.kspat.web.domain.AutoAnnual;

public class AutoAnnualUtil {

	private static DateTimeFormatter fmt = org.joda.time.format.DateTimeFormat.forPattern("yyyy-MM-dd");
	private static DateTimeFormatter fmt_yyyy = org.joda.time.format.DateTimeFormat.forPattern("yyyy");





	/**
	 * 현재 일자를 기준으로 생년월일에서 만 나이를 구한다.
	 *
	 * <pre>
	 * <b>examples</b>
	 * AgeUtils.getRealYear("19731201"); = 39 (현재 년도가 2013년인 경우)
	 * </pre>
	 *
	 * @param birthDate 생년월일 (yyyyMMdd 형식)
	 * @return 만 나이
	 * @throws IllegalArgumentException null 혹은 잘못된 형식의 날짜를 입력한 경우 예외 발생
	 */
	public static int getRealYear(String birthDate, String refDate) {
		return getRealYear(toDateChange(birthDate), toDateChange(refDate));
	}

	public static int getRealYearDateTime(DateTime birthDate, DateTime refDate) {
		return getRealYear(birthDate, refDate);
	}

	/**
	 * 생년월일과 기준 일자를 비교하여 만 나이를 계산한다.
	 *
	 * <pre>
	 * <b>examples</b>
	 * Date birthDate = DateUtils.toDate("20120101");
	 * AgeUtils.getRealYear(birthDate, DateUtils.toDate("20120201")); = 0
	 * AgeUtils.getRealYear(birthDate, DateUtils.toDate("20130101")); = 1
	 * </pre>
	 *
	 * @param birthDate 생년월일 (Date 타입)
	 * @param refDate 기준일자 (Date 타입)
	 * @return 만 나이
	 * @throws IllegalArgumentException null 혹은 잘못된 형식의 날짜를 입력한 경우 예외 발생
	 */
	public static int getRealYear(DateTime birthDate, DateTime refDate) {
		if (birthDate == null || refDate == null) {
			throw new IllegalArgumentException("Invalid argument value. birthDate = '" + birthDate + "', refDate = '" + refDate + "'");
		} else {
			return Years.yearsBetween(birthDate, refDate).getYears();
		}
	}



	/**
	 * 기준일자를 기준으로 생년월일에서 한국식 나이를 구한다.
	 *
	 * <pre>
	 * <b>examples</b>
	 * AgeUtils.getYear("19731201", "20121225"); = 40
	 * </pre>
	 *
	 * @param birthDate 생년월일 (yyyyMMdd 형식 혹은 yyyy 형식)
	 * @param refDate 기준일자 (yyyyMMdd 형식 혹은 yyyy 형식)
	 * @return 한국식 나이
	 * @throws IllegalArgumentException null 혹은 잘못된 형식의 날짜를 입력한 경우 예외 발생
	 */
	public static int getYear(String birthDate, String refDate) {
		if (StringUtils.isEmpty(birthDate) || StringUtils.isEmpty(refDate)) {
			throw new IllegalArgumentException("birthDate or refDate parameter is empty.");
		} else if (birthDate.length() < 4 || refDate.length() < 4) {
			throw new IllegalArgumentException("birthDate or refDate parameter length is too short (must longer than 3).");
		} else if (!StringUtils.isNumeric(birthDate) || !StringUtils.isNumeric(refDate)) {
			throw new IllegalArgumentException("birthDate or refDate parameter is not numeric data.");
		}
		if (birthDate.length() == 4) {
			return Integer.parseInt(refDate) - Integer.parseInt(birthDate) + 1;
		} else {
			return getYear(toDateChange(birthDate), toDateChange(refDate));
		}
	}



	/**
	 * 생년월일과 기준 일자를 비교하여 한국식 나이를 반환한다.
	 *
	 * <pre>
	 * <b>examples</b>
	 * Date birthDate = DateUtils.toDate("20120101");
	 * AgeUtils.getYear(birthDate, DateUtils.toDate("20120201")); = 1
	 * AgeUtils.getYear(birthDate, DateUtils.toDate("20130101")); = 2
	 * </pre>
	 *
	 * @param birthDate 생년월일 (yyyyMMdd 형식)
	 * @param refDate 기준일자 (yyyyMMdd 형식)
	 * @return 한국식 나이
	 * @throws IllegalArgumentException null 혹은 잘못된 형식의 날짜를 입력한 경우 예외 발생
	 */
	public static int getYear(DateTime birthDate, DateTime refDate) {
		if (birthDate == null || refDate == null) {
			throw new IllegalArgumentException("Invalid argument value. birthDate = '" + birthDate + "', refDate = '" + refDate + "'");
		} else {
			return refDate.getYear() - birthDate.getYear() + 1;
		}
	}

	private static DateTime toDateChange(String strDt){
		return DateTime.parse(strDt, fmt);
	}






}
