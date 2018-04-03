package com.kspat.web.mapper;

import java.util.List;

import com.kspat.web.domain.Dept;
import com.kspat.web.domain.SearchParam;

public interface ManagementMapper {

	List<Dept> getDeptDeptsList(SearchParam searchParam);

	Dept getDeptDeptsDetailByCode(String searchCode);

	void updateDeptDepts(Dept dept);


}
