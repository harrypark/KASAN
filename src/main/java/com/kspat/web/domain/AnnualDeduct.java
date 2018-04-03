package com.kspat.web.domain;

import lombok.Data;
import lombok.ToString;

@Data
@ToString(callSuper = true)
public class AnnualDeduct extends BaseDomain {

	private int id;
	private String adDt;
	private int shortLate;
	private int longLate;
	private double failWorkTm;
	private double absence;
	private String memo;

}
