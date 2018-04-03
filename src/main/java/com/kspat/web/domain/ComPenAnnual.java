package com.kspat.web.domain;

import lombok.Data;
import lombok.ToString;

@Data
@ToString(callSuper = true)
public class ComPenAnnual extends BaseDomain{



	private int id;

	private String startDt, endDt;

	private String memo;

	private Double comAnnual;

	public ComPenAnnual(){}

	public ComPenAnnual(int id, String startDt, String endDt, double comAnnual) {
		this.id = id;
		this.startDt = startDt;
		this.endDt = endDt;
		this.comAnnual =comAnnual;
	}




}
