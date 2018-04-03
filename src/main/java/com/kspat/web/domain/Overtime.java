package com.kspat.web.domain;


import lombok.Data;

@Data
public class Overtime extends BaseDomain{

	private int id;
	private String name;
	private String deptNm;
	private String reqDt;
	private String reqYm;
	private String expOutTm;
	private String outTm;
	private int overtimeMin;
	private String memo;
	private String result;


	private boolean holidayYn;
	private boolean dataErrorYn;
	private boolean duplicateReq;


}
