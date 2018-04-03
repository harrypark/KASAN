package com.kspat.web.service.impl;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kspat.util.common.MD5;
import com.kspat.web.domain.LoginInfo;
import com.kspat.web.domain.User;
import com.kspat.web.mapper.LoginMapper;
import com.kspat.web.service.LoginService;

@Service
public class LoginServiceImpl implements LoginService {

	@Autowired
	private LoginMapper loginMapper;

	@Override
	public User getLoginCheck(LoginInfo loginInfo) {

		loginInfo.setLoginPwd(MD5.getMD5(loginInfo.getLoginPwd()));
		User user = loginMapper.getLoginCheck(loginInfo);

		if(user == null){//로그인정보 없음
			user = new User();
			user.setLogin(false);
		}else{//로그인정보 있음
			user.setLogin(true);
			if(user.getLastLogin() == null){
				user.setFirstLogin(true);
			}
			loginMapper.updateLoginTime(user);
		}

		return user;
	}

}
