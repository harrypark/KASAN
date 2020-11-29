package com.kspat.web.domain;
import lombok.Data;
import lombok.ToString;

@Data
@ToString(callSuper = true)
public class DashPrivate extends BaseDomain{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5226425318576250465L;
	private int id;
	private String type;
	private String code;
	private String deptName;
	private String capsName;
	private String title;
	private String destination;//목적지
	private String description;//메모
	private String start;//시작
	private String end;//종료

	
}
