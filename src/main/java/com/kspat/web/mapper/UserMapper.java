package com.kspat.web.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kspat.web.domain.DeptMapping;
import com.kspat.web.domain.Pwd;
import com.kspat.web.domain.RawData;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.domain.User;

public interface UserMapper {

	List<RawData> getRawDataSearchList(SearchParam searchParam);

	List<RawData> getRawDataList(SearchParam searchParam);

	List<User> getUserList(SearchParam searchParam);

	User getUserDetailById(@Param("searchId") String searchId);

	int capsInfoDuplicateCount(User user);

	int loginIdDuplicateCount(User user);

	void insertUser(User user);

	void updateUser(User user);

	List<User> getSearchUserList();

	String[] getMailSendToList(String deptCd);

	int updateUserPassword(User user);

	void userPasswordChange(Pwd pwd);

	List<User> getUserSearchList(SearchParam searchParam);

	int getRawDataCheckCount(SearchParam searchParam);

	List<User> getManagerList(SearchParam searchParam);

	User getManagerDetailById(String searchId);

	void updateManager(User user);

	String[] mailSendManagerListByDeptcd(String deptCd);

	String[] getAdminEmailAddress();

	String getManagerDepts(int id);

	List<DeptMapping> getDeptManagerCount();

	String[] mailSendAllUserList();

	String[] mailSendManagerDeptListByDeptcd(String deptCd);

	void updateAttendanceId(User attUseInfo);

	void deleteUserStateChangeDailyStat(User user);


}
