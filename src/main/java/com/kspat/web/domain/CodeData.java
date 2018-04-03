package com.kspat.web.domain;

import lombok.Data;
import lombok.ToString;

@Data
@ToString(callSuper = true)
public class CodeData extends BaseDomain{
	private int id;
	private String name;
	private String groupName;
	private String groupKey;
	private String useYn;
	private String code;
	private int ord;

	private boolean duplicate;

}
