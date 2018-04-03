package com.kspat.web.domain;

import lombok.Data;
import lombok.ToString;

@Data
@ToString(callSuper = true)
public class Annual extends BaseDomain{

	private int id;
	private String capsId;
	private String capsName;
	private String year;
	private double availCount;
	private double usedCount;
	private double deductCount;
	private double currCount;//현재 신청가능연차

	private String chk;//해당년도 연차 등록여부 체크필드(0000)

	public Annual(){}

	public Annual(int id, String year, double availCount, double usedCount,double deductCount) {
		super();
		this.id = id;
		this.year = year;
		this.availCount = availCount;
		this.usedCount = usedCount;
		this.deductCount=deductCount;
	}




}
