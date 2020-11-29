package com.kspat.web.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kspat.util.common.Constants;
import com.kspat.util.common.MD5;
import com.kspat.web.domain.CodeData;
import com.kspat.web.domain.DeptMapping;
import com.kspat.web.domain.Pwd;
import com.kspat.web.domain.RawData;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.domain.User;
import com.kspat.web.mapper.CodeMapper;
import com.kspat.web.mapper.UserMapper;
import com.kspat.web.service.UserService;

@Service
public class UserServiceImpl implements UserService{
	@Autowired
	private UserMapper userMapper;

	@Autowired
	private CodeMapper codeMapper;


	@Override
	public List<RawData> getRawDataSearchList(SearchParam searchParam) {
		return userMapper.getRawDataSearchList(searchParam);
	}

	@Override
	public List<RawData> getRawDataList(SearchParam searchParam) {
		return userMapper.getRawDataList(searchParam);
	}

	@Override
	public List<User> getUserList(SearchParam searchParam) {
		return userMapper.getUserList(searchParam);
	}

	@Override
	public User getUserDetailById(String searchId) {
		return userMapper.getUserDetailById(searchId);
	}

	@Override
	@Transactional
	public User insertUser(User user) {
		User ret_usr = new User();
		//Caps 정보 중복체크
		int count_1 = userMapper.capsInfoDuplicateCount(user);
		if(count_1 > 0){
			ret_usr.setDuplicateCaps(true);
			return ret_usr;
		}

		//LoginId 정보 중복체크
		int count_2 = userMapper.loginIdDuplicateCount(user);
		if(count_2 > 0){
			ret_usr.setDuplicateLoginId(true);
			return ret_usr;
		}

		//user 정보 등록
		String md5_pwd = MD5.getMD5(user.getLoginId()+Constants.PWD_SUFFIX);
		user.setLoginPwd(md5_pwd);//초기 비밀번호 id+@0001
		userMapper.insertUser(user);

		//user 정보 조회
		ret_usr = userMapper.getUserDetailById( Integer.toString(user.getId()));
		return ret_usr;
	}

	@Override
	@Transactional
	public User updateUser(User user) {
		User ret_usr = new User();

		//수정모두 채크
		user.setUpdate(true);

		//System.out.println("Alphanumeric[" + RandomStringUtils.randomAlphanumeric(5) + "]");
		/*
		 * 직원상태가 퇴직일경우
		 * 1. 5자리 RandomString 으로 capsId변경
		 * 2. ks_user table capsId update
		 * 3. Attendance table id 컬럼변경.
		 */
		if("003".equals(user.getStateCd())){
			String ranStr = RandomStringUtils.randomAlphanumeric(5);
			User attUseInfo = userMapper.getUserDetailById(String.valueOf(user.getId()));

			attUseInfo.setRanStr(ranStr);
			userMapper.updateAttendanceId(attUseInfo);

			//user 정보 등록
			user.setRanStr(ranStr);
		}else if("002".equals(user.getStateCd())){
			//휴직일경우 휴직적용일 이후 통계 데이터 모두 삭제
			userMapper.deleteUserStateChangeDailyStat(user);

		}

		userMapper.updateUser(user);

		//user 정보 조회
		ret_usr = userMapper.getUserDetailById( Integer.toString(user.getId()));
		return ret_usr;
	}

	@Override
	public List<User> getSearchUserList() {
		return userMapper.getSearchUserList();
	}

	@Override
	public String[] getMailSendToList(String deptCd) {
		return userMapper.getMailSendToList(deptCd);
	}

	@Override
	public String initUserPassword(int searchId) {
		User user = userMapper.getUserDetailById(Integer.toString(searchId));

		String md5_pwd = MD5.getMD5(user.getLoginId()+Constants.PWD_SUFFIX);
		user.setLoginPwd(md5_pwd);//초기 비밀번호 id+@0001
		int res = userMapper.updateUserPassword(user);
		return res==1?"success":"fail";
	}

	@Override
	public String userPasswordChange(Pwd pwd) {
		String res = "fail";
		User user = userMapper.getUserDetailById(Integer.toString(pwd.getId()));

		if(user.getLoginPwd().equals(MD5.getMD5(pwd.getOldPassword()))){
			pwd.setNewPassword(MD5.getMD5(pwd.getNewPassword()));
			userMapper.userPasswordChange(pwd);
			res="success";
		}
		return res;
	}

	@Override
	public List<User> getUserSearchList(SearchParam searchParam) {
		return userMapper.getUserSearchList(searchParam);
	}

	@Override
	public int getRawDataCheckCount(SearchParam searchParam) {
		return userMapper.getRawDataCheckCount(searchParam);
	}

	@Override
	public List<User> getManagerList(SearchParam searchParam) {
		return userMapper.getManagerList(searchParam);
	}

	@Override
	public User getManagerDetailById(String searchId) {
		return userMapper.getManagerDetailById(searchId);
	}

	@Override
	public User updateManager(User user) {
		userMapper.updateManager(user);

		user = userMapper.getManagerDetailById(Integer.toString(user.getId()));


		return user;
	}

	@Override
	public List<CodeData> getManagerDeptList(int id) {
		List<CodeData> list = new ArrayList<CodeData>();

		String depts = userMapper.getManagerDepts(id);
		if(depts != null){
			String[] values = depts.split(",");
			HashMap hm = new HashMap();
			hm.put("depts", values) ;

			list = codeMapper.getManagerDeptList(hm);

		}

		return list;
	}

	@Override
	public List<DeptMapping> getDeptManagerCount() {
		return userMapper.getDeptManagerCount();
	}

	@Override
	public List<CodeData> getDeptList(String deptCd) {
		// TODO Auto-generated method stub
		return userMapper.getDeptList(deptCd);
	}

/*
	@Override
	public List<User> getManagerUserList(SearchParam searchParam) {
		List<User> list = new ArrayList<User>();

		if("all".equals(searchParam.getSearchDept())){
			String depts = userMapper.getManagerDepts(Integer.parseInt(searchParam.getUserId()));
			if(depts != null){
				String[] values = depts.split(",");
				HashMap hm = new HashMap();
				hm.put("depts", values) ;

				list = userMapper.getManagerUserList(hm);
			}

		}else{
			list = userMapper.getUserSearchList(searchParam);
		}

		return list;
	}
*/
}
