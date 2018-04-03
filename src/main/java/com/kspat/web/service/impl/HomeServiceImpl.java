package com.kspat.web.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kspat.web.domain.Documents;
import com.kspat.web.domain.User;
import com.kspat.web.mapper.HomeMapper;
import com.kspat.web.service.HomeService;

@Service
public class HomeServiceImpl implements HomeService {

	@Autowired
	private HomeMapper homeMapper;

	@Override
	public String getUserEmail() {
		return homeMapper.getUserEmail();
	}

	@Override
	public List<User> getUserList() {

		return homeMapper.getUserList();
	}

	@Override
	public void insertUser(User usr) {
		homeMapper.insertUser(usr);
	}

	@Override
	public void updateuser(User usr) {
		homeMapper.updateuser(usr);

	}

	@Override
	public void insertUser2(String name, String email) {
		homeMapper.insertUser2(name,email);

	}

	@Override
	public void insertTest() {
		homeMapper.insertTest();

	}

	@Override
	public List<Documents> getDocumentList() {
		return homeMapper.getDocumentList();
	}

	@Override
	public void insertDocument(Documents dc) {
		homeMapper.insertDocument(dc);
	}
}
