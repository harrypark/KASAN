package com.kspat.web.domain;

import lombok.Data;
import lombok.ToString;

@Data
@ToString(callSuper = true)
public class Regulation extends BaseDomain {
	private int fileId;
	private String orgName;
	private String sysName;
	private long size;
	private String path;
	private String type;


}
