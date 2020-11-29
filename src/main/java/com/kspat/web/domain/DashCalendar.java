package com.kspat.web.domain;


import lombok.Data;
import lombok.ToString;

@Data
@ToString(callSuper = true)
public class DashCalendar {
	/**
	 * 
	 */
	private static final long serialVersionUID = -6850495785524260575L;
	
	private int id;
	private String type;
	private String code;
	private String title;
	private String description;
	private String start;
	private String end;
	private boolean allDay;

	private String capsName;
}
