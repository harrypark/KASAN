package com.kspat.web.mapper;

import com.kspat.web.domain.LoginInfo;
import com.kspat.web.domain.User;

public interface LoginMapper {

	User getLoginCheck(LoginInfo loginInfo);

	void updateLoginTime(User user);

}
