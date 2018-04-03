package com.kspat.web.domain;

import lombok.Data;
import lombok.ToString;

@Data
@ToString(callSuper = true)
public class DayInfo extends Calendar{
	private String isHoliday;//주말과 공휴 일을 계산헤서 휴무일인가?

}
