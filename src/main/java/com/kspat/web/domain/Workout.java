package com.kspat.web.domain;

import java.util.Date;

import lombok.Data;
import lombok.ToString;

@Data
@ToString(callSuper = true)
public class Workout extends BaseDomain {

	/**
	 *
	 */
	private static final long serialVersionUID = -7251067025085330590L;
	private int id;
	private String outDt;
	private String weekName;
	private String startTm;
	private String endTm;
	private int diffm; //외근소요분
	private String hereGoYn;//현지출근 Y,N
	private String hereOutYn;//현지퇴근 Y,N
	private String destination; //목적지(장소)
	private String memo;

	private String deptCd;

}
