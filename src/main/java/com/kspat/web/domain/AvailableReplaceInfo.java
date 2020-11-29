package com.kspat.web.domain;

import lombok.Data;

@Data
public class AvailableReplaceInfo {
	private int currCount;
	private int todayMin;
	private String availStartTm;
	private String hasHl; //선택된날짜에 반휴 신청이 있는지 체크

}
