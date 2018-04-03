package com.kspat.web.service;

import java.util.List;

import com.kspat.web.domain.HalfLeave;
import com.kspat.web.domain.Leave;
import com.kspat.web.domain.SearchParam;

public interface LeaveService {

	List<Leave> getLeaveList(SearchParam searchParam);

	int checkLeaveDayCount(Leave leave);

	List<Leave> insertLeave(Leave leave);

	Leave getLeaveDetail(SearchParam searchParam);

	int deleteLeave(Leave leave);

	List<HalfLeave> getHalfLeaveList(SearchParam searchParam);

	HalfLeave insertHalfLeave(HalfLeave hl);

	HalfLeave getHalfLeaveDetail(SearchParam searchParam);

	int deleteHalfLeave(HalfLeave hl);

	String getAnnualMinusUseYn();


}
