package com.kspat.web.domain;


import java.util.Date;

import lombok.Data;
import lombok.ToString;

@Data
@ToString(callSuper = true)
public class User extends BaseDomain{

	private int id; // system Id
	private String capsId, capsName; //caps 정보 (key)
	private String deptCd, deptName; //부서정보
	private String mdeptCd;//매니져 부서
	private String positionCd, positionName;//직급정보
	private String loginId, loginPwd;//로그인 정보
	private String email;
	private String authCd, authName;//권한
	private String stateCd, stateName;//상태
	private String dashState; //대시보드 상태보여줄것인지?
	private String insideTel; //내선번호
	private int availAnnualCnt;//연차일수

	private String hireDt;//입사일
	private String stateApplyDt;//휴직적용시작일

	private Date lastLogin;

	private boolean isDuplicateCaps;
	private boolean isDuplicateLoginId;

	private boolean isUpdate;
	//login관련
	private boolean isLogin;
	private boolean isFirstLogin;

	//퇴직시 변경될 capsid 접두어 random5자
	private String ranStr;

}
