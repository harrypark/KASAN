package com.kspat.web.domain;

import lombok.Data;

@Data
public class SessionInfo {
	private int id;
	private String capsId;
	private String capsName;
	private String authCd;
	private String 	authName;
	private String deptCd;

}
