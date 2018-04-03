package com.kspat.web.service;

import java.util.List;

import com.kspat.web.domain.AutoAnnual;
import com.kspat.web.domain.ComPenAnnual;
import com.kspat.web.domain.SearchParam;

public interface AutoAnnualService {

	List<AutoAnnual> manualCreateAutoAnnual(SearchParam searchParam);

	List<AutoAnnual> getAutoAnnualList(SearchParam searchParam);

	ComPenAnnual getUserComPenAnnual(AutoAnnual autoAnnual);

	AutoAnnual editComPenAnnual(ComPenAnnual cpa);

}
