package com.kspat.web.domain;

import lombok.Data;
import lombok.ToString;

@Data
@ToString(callSuper = true)
public class LateStatPoint extends BaseDomain{

	private int id;
	private String year;

	/*
	 * 통계 테이블에서 가져온정보
	 */
	private int shortLateSum;
	private int longLateSum;
	private float orgLatePoint;
	private int latePoint;

	/*
	 * Late_Point 테이블에서 가져온 데이터
	 */
	private int klpShortLate;
	private int klpLongLate;
	private float klpOrgLatePoint;
	private Integer klpLatePoint;
	private int klpMailCount;
	private String klpLastMailSendDt;




}
