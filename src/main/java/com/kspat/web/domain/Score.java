package com.kspat.web.domain;

import lombok.Data;

@Data
public class Score {


	private int id;
	private String capsName;
	private String deptCd;
	private String deptName;
	private String email;

	private String hireDt;
	private String startDt;
	private String endDt;

	private double availCount;//총연차

	private double currCount;//잔여(현재)연차
	private double usedCount;//사용연차(휴가+반휴)
	private double usedLeave;//사용연차(휴가)
	private double usedHlLeave;//사용연차(반휴)

	private double subCount;//차감연차
	private double subShort;//단지각횟수
	private double subLong;//장지각횟수

	private double subLate;//지각차감횟수계산

	private double subFailTm;//근무시간미준수
	private double subAbsence;//무단결근
	private double currReplace;//남은 잔여대체근무


	public Score() {};

	public Score(int id,String capsName, String deptName, String startDt, String endDt,String email, double currCount) {
		this.id=id;
		this.capsName= capsName;
		this.deptName= deptName;
		this.startDt= startDt;
		this.endDt= endDt;
		this.email= email;
		this.currCount= currCount;
	}


}
