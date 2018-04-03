package com.kspat.web.mapper;

import java.util.List;

import com.kspat.web.domain.Calendar;
import com.kspat.web.domain.HalfLeave;
import com.kspat.web.domain.Leave;
import com.kspat.web.domain.SearchParam;

public interface LeaveMapper {

	List<Leave> getLeaveList(SearchParam searchParam);

	int checkLeaveDayCount(Leave leave);

	void insertLeave(Leave leave);

	Leave getLeaveDetail(SearchParam searchParam);

	int deleteLeave(Leave leave);

	List<HalfLeave> getHalfLeaveList(SearchParam searchParam);

	void insertHalfLeave(HalfLeave hl);

	HalfLeave getHalfLeaveDetail(SearchParam searchParam);

	int deleteHalfLeave(HalfLeave hl);

	/*
	int chackhlSuppDuplicate(HalfLeave hl);
	*/
	List<Calendar> checkLeaveDay(Leave leave);

	String getAnnualMinusUseYn();

}
