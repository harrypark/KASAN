package com.kspat.web.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kspat.web.domain.Dept;
import com.kspat.web.domain.RawData;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.mapper.ManagementMapper;
import com.kspat.web.service.ManagementService;

@Service
public class ManagementServiceImpl implements ManagementService{

	@Autowired
	private ManagementMapper managementMapper;

	@Override
	public List<Dept> getDeptDeptsList(SearchParam searchParam) {
		return managementMapper.getDeptDeptsList(searchParam);
	}

	@Override
	public Dept getDeptDeptsDetailByCode(String searchCode) {
		return managementMapper.getDeptDeptsDetailByCode(searchCode);
	}

	@Override
	public Dept updateDeptDepts(Dept dept) {
		managementMapper.updateDeptDepts(dept);

		Dept res = managementMapper.getDeptDeptsDetailByCode(dept.getCode());

		return res;
	}

}
