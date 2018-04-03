package com.kspat.web.domain;

import java.util.Date;

import lombok.Data;
import lombok.ToString;

import org.springframework.format.annotation.DateTimeFormat;

@Data
@ToString(callSuper = true)
public class LatePoint extends BaseDomain{

	private int id;
	private String year;
	private String dashState;
	private int shortLate;
	private int longLate;
	private float orgLatePoint;
	private int latePoint;
	private String mailTo;
	private int mailCount;

	private String lastMailSendDt;

	private String capsName;
	private String deptName;

	public LatePoint(){}

	public LatePoint(int id, String year, int shortLate, int longLate,
			float orgLatePoint, int latePoint) {
		super();
		this.id = id;
		this.year = year;
		this.shortLate = shortLate;
		this.longLate = longLate;
		this.orgLatePoint = orgLatePoint;
		this.latePoint = latePoint;
	}

	public LatePoint(int id, String year, int shortLate, int longLate,
			float orgLatePoint, int latePoint, int mailCount,
			String lastMailSendDt) {
		super();
		this.id = id;
		this.year = year;
		this.shortLate = shortLate;
		this.longLate = longLate;
		this.orgLatePoint = orgLatePoint;
		this.latePoint = latePoint;
		this.mailCount = mailCount;
		this.lastMailSendDt = lastMailSendDt;
	}



}
