package com.kspat.web.domain;

import lombok.Data;
import lombok.ToString;

@Data
@ToString(callSuper = true)
public class YearlyRule extends BaseDomain{
	private String applyYear;
	private int shortLateCount;//연차 차감 단지각 횟수
	private int longLateCount;//연차 차감 장지각 횟수

	private float shortLateWeight;//단지각 가중치
	private float longLateWeight;//장지각 가중치

	private String updateType; //현재만 변경 여부 1.모두 2.현재만

}
