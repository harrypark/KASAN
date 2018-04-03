package com.kspat.web.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class Calendar {


	private String calYear;
	private String calMonth;
	private String calDay;
	private String calDate1;////string type yyyy-MM-dd
	private String calDate2;//yyyyMMdd
	private Date calDate3;//Date type yyyy-MM-dd
	private String calWeekName;//요일
	private String calWeekPart;//요일번호(1:일요일, 2:월요일,3:화요일...)
	private String calWeekendYn;//주말여부
	private String calHolidayYn;//공휴일 여부
	private String calHolidayName;//공휴일명

	private String dataError;
	private String memo;

	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private Date mdfyDt;
	private String mdfyId;


	public Calendar(){};

	public Calendar(String searchDt, String dataError, String mdfyId) {
		this.calDate1=searchDt;
		this.dataError=dataError;
		this.mdfyId=mdfyId;
	}



}
