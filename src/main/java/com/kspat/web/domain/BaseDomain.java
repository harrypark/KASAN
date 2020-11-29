package com.kspat.web.domain;

import java.io.Serializable;
import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;
import lombok.Data;

@Data
public abstract class BaseDomain implements Serializable{

	private static final long serialVersionUID = 1L;

	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private Date crtdDt;
	private String crtdId;
	private String crtdNm;

	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private Date mdfyDt;
	private String mdfyId;
	private String mdfyNm;

	private String timeDiff;




}
