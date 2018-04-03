package com.kspat.web.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kspat.web.domain.BusinessTrip;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.domain.Workout;
import com.kspat.web.mapper.BusinessTripMapper;
import com.kspat.web.service.BusinessTripService;
import com.kspat.web.service.EmailTempleatService;
@Service
public class BusinessTripServiceImpl implements BusinessTripService {

	@Autowired
	private BusinessTripMapper businessTripMapper;

	@Autowired
	private EmailTempleatService emailTempleatService;

	@Override
	public BusinessTrip insertBusinessTrip(BusinessTrip businessTrip) {
		businessTripMapper.insertBusinessTrip(businessTrip);

		SearchParam searchParam = new SearchParam(businessTrip.getId());
		BusinessTrip bt = businessTripMapper.getBusinessTripDetailById(searchParam);

		//출장등록정보를 부서 매니져에게 메일발송
		emailTempleatService.setBusinessTripEmailTempleate(businessTrip, "regist",businessTrip.getDeptCd());
		return bt;
	}

	@Override
	public List<BusinessTrip> getUserBusinessTripList(SearchParam searchParam) {
		return businessTripMapper.getUserBusinessTripList(searchParam);
	}

	@Override
	public BusinessTrip getBusinessTripDetailById(SearchParam searchParam) {
		return businessTripMapper.getBusinessTripDetailById(searchParam);
	}

	@Override
	public BusinessTrip updateBusinessTrip(BusinessTrip businessTrip) {
		businessTripMapper.updateBusinessTrip(businessTrip);

		SearchParam searchParam = new SearchParam(businessTrip.getId());
		BusinessTrip bt = businessTripMapper.getBusinessTripDetailById(searchParam);
		return bt;
	}

	@Override
	public int deleteBusinessTrip(BusinessTrip businessTrip) {
		SearchParam searchParam = new SearchParam(businessTrip.getId());
		BusinessTrip bt = businessTripMapper.getBusinessTripDetailById(searchParam);
		bt.setCrtdId(businessTrip.getCrtdId());

		//System.out.println(bt.toString());

		int res = businessTripMapper.deleteBusinessTrip(businessTrip);
		//외근t삭제정보를 부서 매니져에게 메일발송
		emailTempleatService.setBusinessTripEmailTempleate(bt, "delete",businessTrip.getDeptCd());

		return res;
	}

}
