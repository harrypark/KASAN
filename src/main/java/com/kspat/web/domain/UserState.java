package com.kspat.web.domain;

import java.util.List;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;


@Data
public class UserState {

	private int id; // system Id
	private String capsId, capsName; //caps 정보 (key)
	private String deptCd, deptName; //부서정보
	private String positionCd, positionName;//직급정보

	private String calHereGo; //계산된 출근시간
	private String expHereOut;//퇴근예정시간
	private String calHereOut; //계산된퇴근시간
	private String hereGo; //출근가능시간 가장빠른 입문기록
	private String hereOut;
	private String earlyGo; //가장빠른 입문시간
	private String lateTm;//지각 기준시간
	private String dashState;//대시보드상태표시
	private String insideTel;//내선번호

	private String earlyHereGo; //출근인정전 시간에 입문일경우 인정되는 출근시간
	private int workTmMin=60*9;


	private boolean inOffice;//재실


	//private int shotLateMin = 0;//단지각(분)
	//private int longLateMin = 0;//장지각(분)
	private int diffLateMin;//지각기분시간과 차이
	private String late;

	private int calWorkTmMin = 0;//실제근무시간(분)
	private boolean isAbsence = false; //무단결근

	private int diffWorkTmMin;
	private String failWorkTm;

	/*
	private boolean isDataError;//DataError
	private String weekName;//요일
	private boolean isHoliday;
	private String holidayname;
	*/


	private String searchDt;//검색하는 날짜

	private List<Workout> workout;//외근정보
	private BusinessTrip btrip;//출장정보
	private Leave leave;//휴가정보
	private HalfLeave hlLeave;//반휴정보
	private Replace repl; //빠지는날
	private List<Replace> supple; //채우는날









}
