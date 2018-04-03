package com.kspat.web.domain;

import lombok.Data;
import lombok.ToString;

@Data
@ToString(callSuper = true)
public class Reservation extends BaseDomain {
	private int id;
	private String type;
	private String code;
	private String title;
	private String description;
	private String start;
	private String end;

	private String capsName;
}
