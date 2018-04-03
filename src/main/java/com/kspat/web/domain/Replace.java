package com.kspat.web.domain;

import lombok.Data;
import lombok.ToString;

/** 대체근무
 * @author harry
 *
 */
@Data
@ToString(callSuper = true)
public class Replace extends BaseDomain{
	private int id;
	private String replDt;//빠지는날
	private String replStartTm;
	private String replEndTm;
	private int term;//시간의 분
	private String termHM; //term의 시간 변환
	private String suppleDt;//채우는날  supplement(보충)
	private String memo;
	private String inLunch;//점심시간 포함여부

	private String deptCd;

	private boolean availReplaceCountOver;//대체근무 신청건수 초과
	private boolean hlSuppDuplicate;//반휴, 채우는날중복

}
