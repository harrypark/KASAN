package com.kspat.web.service;

import java.util.HashMap;

import com.kspat.web.domain.LoginInfo;
import com.kspat.web.domain.User;

public interface LoginService {

	User getLoginCheck(LoginInfo loginInfo);

}
