package com.kspat.web.service;

import java.util.List;

import com.kspat.web.domain.Documents;
import com.kspat.web.domain.User;

public interface HomeService {

	String getUserEmail();

	List<User> getUserList();

	void insertUser(User usr);

	void updateuser(User usr);

	void insertUser2(String name, String email);

	void insertTest();

	List<Documents> getDocumentList();

	void insertDocument(Documents dc);

}
