package com.kspat.web.domain;

import lombok.Data;
import lombok.ToString;

@Data
@ToString(callSuper = true)
public class AutoAnnual extends BaseDomain{

	private int id; // system Id
	private String capsId, capsName; //caps 정보 (key)
	private String deptCd, deptName; //부서정보
	private String stateCd, stateName;//상태

	private String type; //연차게산 구분

	private double autoAnnual, comAnnual, availCount;// 자동계산된 연차(A),보정연차(B) , 사용가능연차(A+B)

	private int year;//몇년차?
	private String applyDtType; //기준일 이전 입사자인가 구분 b:이전 a:이후

	private String applyDt;
	private String hireDt;

	private String startDt, endDt;//연차 적용 시작일 , 종료일






}
