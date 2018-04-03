package com.kspat.web.service;

import java.util.List;

import com.kspat.web.domain.Overtime;
import com.kspat.web.domain.SearchParam;

public interface OvertimeService {

	Overtime getReqDateOvertimeInfo(SearchParam searchParam);

	Overtime insertOvertime(Overtime overtime);

	List<Overtime> getOvertimeListById(SearchParam searchParam);

	List<Overtime> getOvertimeAdminList(SearchParam searchParam);

}
