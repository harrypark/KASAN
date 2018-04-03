package com.kspat.web.domain;

import lombok.Data;
import lombok.ToString;

/** 반차
 * @author harry
 *
 */
@Data
@ToString(callSuper = true)
public class HalfLeave extends BaseDomain{
	private int id;
	private String year;
	private String hlDt;
	private double term;
	private String memo;
	private String offcial;//공가

	private String deptCd;


	private String startDt;

	private boolean hlSuppDuplicate;//반휴, 채우는날중복

}
