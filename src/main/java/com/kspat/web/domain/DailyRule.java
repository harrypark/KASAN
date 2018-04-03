package com.kspat.web.domain;

import lombok.Data;
import lombok.ToString;

@Data
@ToString(callSuper = true)
public class DailyRule extends BaseDomain{

	private String applyStartDt;
	private String applyEndDt;

	private int longLateRule;//장지각 적용 기준시간(분)
	private String goStartTm;//출근 인정시간 시작
	private String goEndTm;//출근인정시간 종료

	private int monthReplaceCount;//월 가능 대체근무 횟수
	private int maxReplaceHr;//대체근무 최대 가능시간

	private boolean duplicate;



}
