package com.kspat.web.mapper;

import java.util.List;

import com.kspat.web.domain.AutoAnnual;
import com.kspat.web.domain.ComPenAnnual;
import com.kspat.web.domain.SearchParam;

public interface AutoAnnualMapper {

	List<AutoAnnual> getUserHeirDtList(SearchParam searchParam);

	double getTypeAAUsedAnnual(AutoAnnual aa);

	void deleteNowAnnual(AutoAnnual na);

	void upsertAutoAnnual(AutoAnnual na);

	List<AutoAnnual> getAutoAnnualList(SearchParam searchParam);

	ComPenAnnual getUserComPenAnnual(AutoAnnual aa);

	void upsertComPenAnnual(ComPenAnnual cpa);

	AutoAnnual getUserAutoAnnualDetail(SearchParam searchParam);

}
