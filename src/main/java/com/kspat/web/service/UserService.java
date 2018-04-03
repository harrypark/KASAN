package com.kspat.web.service;

import java.util.List;

import com.kspat.web.domain.CodeData;
import com.kspat.web.domain.DeptMapping;
import com.kspat.web.domain.Pwd;
import com.kspat.web.domain.RawData;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.domain.User;

public interface UserService {


	List<RawData> getRawDataSearchList(SearchParam searchParam);

	List<RawData> getRawDataList(SearchParam searchParam);

	List<User> getUserList(SearchParam searchParam);

	User getUserDetailById(String searchId);

	User insertUser(User user);

	User updateUser(User user);

	List<User> getSearchUserList();

	String[] getMailSendToList(String deptCd);

	String initUserPassword(int searchId);

	String userPasswordChange(Pwd pwd);

	List<User> getUserSearchList(SearchParam searchParam);

	int getRawDataCheckCount(SearchParam searchParam);

	List<User> getManagerList(SearchParam searchParam);

	User getManagerDetailById(String searchId);

	User updateManager(User user);

	List<CodeData> getManagerDeptList(int id);

	List<DeptMapping> getDeptManagerCount();


}
