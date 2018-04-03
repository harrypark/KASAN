package com.kspat.web.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kspat.web.domain.Documents;
import com.kspat.web.domain.User;

public interface HomeMapper {

	String getUserEmail();

	List<User> getUserList();

	void insertUser(User usr);

	void updateuser(User usr);

	void insertUser2(@Param("name")String name, @Param("email")String email);

	void insertTest();

	List<Documents> getDocumentList();

	void insertDocument(Documents dc);

}
