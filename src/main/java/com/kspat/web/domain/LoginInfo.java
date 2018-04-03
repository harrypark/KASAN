package com.kspat.web.domain;

import lombok.Data;

@Data
public class LoginInfo {

	private String loginId;
	private String loginPwd;

	private String newPwd;

	private boolean isLogin;
	private boolean isFirstLogin;


	public LoginInfo(){}

	public LoginInfo(boolean isLogin, boolean isFirstLogin) {
		super();
		this.isLogin = isLogin;
		this.isFirstLogin = isFirstLogin;
	}


}
