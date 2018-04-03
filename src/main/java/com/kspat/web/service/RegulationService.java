package com.kspat.web.service;

import java.util.List;

import com.kspat.web.domain.Regulation;
import com.kspat.web.domain.SearchParam;

public interface RegulationService {

	Regulation insertFile(Regulation regulation);

	List<Regulation> getRegulationList(SearchParam searchParam);

	int deleteFile(int fileId);

	Regulation getRegulationDetail(int fileId);

	Regulation getLastRegulationDetail();

}
