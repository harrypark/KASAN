package com.kspat.web.service.impl;

import java.io.File;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kspat.web.controller.ManagementController;
import com.kspat.web.domain.Regulation;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.mapper.RegulationMapper;
import com.kspat.web.service.RegulationService;

@Service
public class RegulationServiceImple implements RegulationService{
	private static final Logger logger = LoggerFactory.getLogger(RegulationServiceImple.class);
	@Autowired
	private RegulationMapper regulationMapper;

	@Override
	public Regulation insertFile(Regulation regulation) {

		regulationMapper.insertFile(regulation);

		logger.debug(regulation.toString());

		return regulationMapper.getFileDetail(regulation.getFileId());
	}

	@Override
	public List<Regulation> getRegulationList(SearchParam searchParam) {
		return regulationMapper.getRegulationList(searchParam);
	}

	@Override
	public int deleteFile(int fileId) {
		int res=0;
		Regulation regulation = regulationMapper.getFileDetail(fileId);

		File file = new File(regulation.getPath());

		if(file.delete()){
			res = regulationMapper.deleteFile(fileId);
		}

		return res;
	}

	@Override
	public Regulation getRegulationDetail(int fileId) {
		return regulationMapper.getFileDetail(fileId);
	}

	@Override
	public Regulation getLastRegulationDetail() {
		return regulationMapper.getLastRegulationDetail();
	}

}
