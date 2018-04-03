package com.kspat.web.domain;

import java.util.Date;

import lombok.Data;
import lombok.ToString;

@Data
@ToString(callSuper = true)
public class RawData extends BaseDomain{
	private Date attDate;
	private String gate;
	private String id;
	private String userName;
	private String company;
	private String team;
	private String part;
	private String grade;
	private String card;
	private String detail;

	private String selUserText;
	private String selUserVal;

	public String getSelUserText() {
		if (this.id == null || this.userName == null) {
			return null;
		}
		else {
			return this.userName+"("+this.id+")";
		}

	}

	public String getSelUserVal() {
		if (this.id == null || this.userName == null) {
			return null;
		}
		else {
			return this.id+"|"+this.userName;
		}

	}

}
