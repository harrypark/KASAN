package com.kspat.web.domain;

import lombok.Data;

@Data
public class SearchParam {

	private String searchDM;
	private String searchDate;
	private String searchDt;
	private String searchYear;
	private String fromDate;
	private String fromTime;
	private String toDate;
	private String toTime;
	private String searchUser;

	private String searchId;

	private String dataError;

	private String mdept_cd;

	private String searchText;
	private String searchOption;
	private String searchDept;
	private String searchPosition;
	private String searchState;
	private String searchAuth;

	private String crtdId;
	private String searchType;
	private String searchCode;

	private String startDt, endDt;

	private String userId;
	private String userName;
	private String id;

	public String getFromDate() {
		if (this.searchDate == null) {
			return this.fromDate;
		}
		else {
			return this.searchDate.split("~")[0].trim().replace("-", "");
		}

	}

	public String getToDate() {
		if (this.searchDate == null) {
			return this.toDate;
		}
		else {
			return this.searchDate.split("~")[1].trim().replace("-", "");
		}

	}

	public SearchParam() {}

	public SearchParam(int searchId) {
		this.searchId=Integer.toString(searchId);
	}

	public SearchParam(String searchId) {
		this.searchId=searchId;
	}

	public SearchParam(String fromDate, String toDate) {
		this.fromDate=fromDate;
		this.toDate=toDate;
	}


	public SearchParam(String fromDate, String toDate, String searchuser,String searchDept) {
		this.fromDate=fromDate;
		this.toDate=toDate;
		this.searchUser=searchuser;
		this.searchDept=searchDept;
	}

	public SearchParam(int searchId, String startDt, String endDt) {
		this.searchId = Integer.toString(searchId);
		this.startDt = startDt;
		this.endDt = endDt;
	}



}
