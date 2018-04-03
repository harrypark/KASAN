package com.kspat.web.domain;

import lombok.Data;
import lombok.ToString;

@Data
@ToString(callSuper = true)
public class Dept extends BaseDomain{
	private String code;
	private String name;
	private String mdeptCd;


}
