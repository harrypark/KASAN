package com.kspat.web.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kspat.web.domain.BusinessTrip;
import com.kspat.web.domain.Calendar;
import com.kspat.web.domain.HalfLeave;
import com.kspat.web.domain.Leave;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.mapper.LeaveMapper;
import com.kspat.web.service.EmailTempleatService;
import com.kspat.web.service.LeaveService;

@Service
public class LeaveServiceImpl implements LeaveService {

	@Autowired
	private LeaveMapper leaveMapper;

	@Autowired
	private EmailTempleatService emailTempleatService;

	@Override
	public List<Leave> getLeaveList(SearchParam searchParam) {
		return leaveMapper.getLeaveList(searchParam);
	}

	@Override
	public int checkLeaveDayCount(Leave leave) {
		return leaveMapper.checkLeaveDayCount(leave);
	}

	@Override
	@Transactional
	public List<Leave> insertLeave(Leave leave) {
		List<Leave> res = new ArrayList<Leave>();

		List<Calendar> days = leaveMapper.checkLeaveDay(leave);
		if(days !=null && days.size()>0){
			for(Calendar cal: days){
				if("Y".equals(cal.getCalHolidayYn()) || "Y".equals(cal.getCalWeekendYn())) {
					leave.setTerm(0.0);
				}else {
					leave.setTerm(1.0);
				}
			
			leave.setLeDt(cal.getCalDate1());
			
			//등록
			leaveMapper.insertLeave(leave);
			SearchParam searchParam = new SearchParam(leave.getId());
			Leave leaveDetail = leaveMapper.getLeaveDetail(searchParam);
			res.add(leaveDetail);

			}

			//휴가등록정보를 부서 매니져에게 메일발송
			emailTempleatService.setLeaveEmailTempleate(leave, "regist",leave.getDeptCd());
		}
		return res;
	}

	@Override
	public Leave getLeaveDetail(SearchParam searchParam) {
		return leaveMapper.getLeaveDetail(searchParam);
	}

	@Override
	@Transactional
	public int deleteLeave(Leave leave) {
		SearchParam searchParam = new SearchParam(leave.getId());
		Leave lv =leaveMapper.getLeaveDetail(searchParam);
		lv.setCrtdId(leave.getCrtdId());


		int res = leaveMapper.deleteLeave(leave);

		//휴가삭제정보를 부서 매니져에게 메일발송
		emailTempleatService.setLeaveEmailTempleate(lv, "delete",leave.getDeptCd());

		return res;
	}

	@Override
	public List<HalfLeave> getHalfLeaveList(SearchParam searchParam) {
		return leaveMapper.getHalfLeaveList(searchParam);
	}

	@Override
	@Transactional
	public HalfLeave insertHalfLeave(HalfLeave hl) {
		HalfLeave res = new HalfLeave();
		//반휴와 보추일 중복체크
		/*
		반휴와 채우는 날 중복 신청 허용(대신 지각 체크는 하지 않고, 근무시간만 밚(4시간)+채우는 시간으로 설정)
		2016-12-20 채변리사님 요청
		boolean hlSuppDuplicate= leaveMapper.chackhlSuppDuplicate(hl)>0?true:false;
		*/
		boolean hlSuppDuplicate = false;
		res.setHlSuppDuplicate(hlSuppDuplicate);


		if(hlSuppDuplicate == false){

			//등록
			leaveMapper.insertHalfLeave(hl);


			SearchParam searchParam = new SearchParam(hl.getId());
			res = leaveMapper.getHalfLeaveDetail(searchParam);

			//반휴등록정보를 부서 매니져에게 메일발송
			emailTempleatService.setHalfLeaveEmailTempleate(hl, "regist",hl.getDeptCd());

		}
		return res;
	}

	@Override
	public HalfLeave getHalfLeaveDetail(SearchParam searchParam) {
		return leaveMapper.getHalfLeaveDetail(searchParam);
	}

	@Override
	@Transactional
	public int deleteHalfLeave(HalfLeave halfLeave) {
		SearchParam searchParam = new SearchParam(halfLeave.getId());
		HalfLeave hl =  leaveMapper.getHalfLeaveDetail(searchParam);
		hl.setCrtdId(halfLeave.getCrtdId());

		int res = leaveMapper.deleteHalfLeave(halfLeave);

		//반휴삭제정보를 부서 매니져에게 메일발송
		emailTempleatService.setHalfLeaveEmailTempleate(hl, "delete",halfLeave.getDeptCd());

		return res;
	}

	@Override
	public String getAnnualMinusUseYn() {
		return leaveMapper.getAnnualMinusUseYn();
	}
}
