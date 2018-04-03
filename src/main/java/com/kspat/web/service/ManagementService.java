package com.kspat.web.service;

import java.util.List;

import com.kspat.web.domain.Dept;
import com.kspat.web.domain.SearchParam;

public interface ManagementService {

	List<Dept> getDeptDeptsList(SearchParam searchParam);

	Dept getDeptDeptsDetailByCode(String searchCode);

	Dept updateDeptDepts(Dept dept);


}
