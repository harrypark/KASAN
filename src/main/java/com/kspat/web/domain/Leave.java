package com.kspat.web.domain;

import lombok.Data;
import lombok.ToString;


/** 휴가
 * @author harry
 *
 */
@Data
@ToString(callSuper = true)
public class Leave extends BaseDomain{

	private int id;
	private String leaveRange;
	private String year;
	private String leDt;
	private String startDt;
	private String endDt;
	private double term;
	private String memo;
	private String offcial;//공가

	private String deptCd;


	public String getStartDt() {
		if (this.leaveRange == null) {
			return this.startDt;
		}
		else {
			return this.leaveRange.split("~")[0].trim();
		}

	}

	public String getEndDt() {
		if (this.leaveRange == null) {
			return this.endDt;
		}
		else {
			return this.leaveRange.split("~")[1].trim();
		}

	}




}
