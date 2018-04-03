package com.kspat.web.mapper;

import java.util.List;

import com.kspat.web.domain.Regulation;
import com.kspat.web.domain.SearchParam;

public interface RegulationMapper {

	void insertFile(Regulation regulation);

	Regulation getFileDetail(int id);

	List<Regulation> getRegulationList(SearchParam searchParam);

	int deleteFile(int id);

	Regulation getLastRegulationDetail();

}
