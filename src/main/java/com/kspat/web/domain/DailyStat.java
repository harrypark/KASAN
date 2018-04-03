package com.kspat.web.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.ToString;

@Data
@ToString(callSuper = true)
public class DailyStat extends BaseDomain{

	private int id;
	private String capsName, deptName;
	private String stDt;
	private String weekName;
	private String holidayYn;

	private String goTm;
	private String outTm;
	private String lateTm;
	private String expOutTm;

	private int calWorkTmMin;

	private int workTmMin;

	private double stLeave;

	private double stHlLeave;

	private String stOffcial="N";

	private int stShortLate;

	private int stLongLate;

	private double stFailWorkTm;

	private double stAbsence;

	private String memo;

	private String dataErrorYn;

	private String stAdjust;//사후조정

	public DailyStat(){}

	public DailyStat(int id, String capsName, String searchDt,
			String calWeekName, String isHoliday, String dataError) {
		this.id=id;
		this.capsName = capsName;
		this.stDt=searchDt;
		this.weekName=calWeekName;
		this.holidayYn=isHoliday;
		this.dataErrorYn=dataError;
	}



}
