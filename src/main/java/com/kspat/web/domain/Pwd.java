package com.kspat.web.domain;

import lombok.Data;

@Data
public class Pwd {
	private int id;
	private String oldPassword;
	private String newPassword;
	private String confirmNewPassword;

}
