package com.kspat.web.domain;

import lombok.Data;

@Data
public class DayEvent {

	private int id;
	private String cssText;
	private String gubun;
	private String term;
	private String info;

	/*
		출장 : bt
		외근 : wo
		휴가 : le
		반휴 : hl
		빠지는날 : re
		채우는날 : su
	 */
}
