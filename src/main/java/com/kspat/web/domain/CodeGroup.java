package com.kspat.web.domain;

import lombok.Data;
import lombok.ToString;

@Data
@ToString(callSuper = true)
public class CodeGroup extends BaseDomain{

	private int id;
	private String name;
	private String groupKey;
	private String useYn;

	private boolean isDuplicate;



}
