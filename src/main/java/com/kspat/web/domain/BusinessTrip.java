package com.kspat.web.domain;

import lombok.Data;
import lombok.ToString;

@Data
@ToString(callSuper = true)
public class BusinessTrip extends BaseDomain{

	private int id;
	private String tripRange;
	private String startDt;
	private String endDt;
	private String destination; //목적지(장소)
	private String memo;

	private String deptCd;

//	public void setTrip_range(String tripRange){
//		this.tripRange=tripRange;
//
//		setStartDt(this.tripRange.split("~")[0].trim().replace("-", ""));
//		setEndDt(this.tripRange.split("~")[1].trim().replace("-", ""));
//
//	}


}
