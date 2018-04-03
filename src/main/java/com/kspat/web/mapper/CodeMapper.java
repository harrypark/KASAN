package com.kspat.web.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kspat.web.domain.CodeData;
import com.kspat.web.domain.CodeGroup;
import com.kspat.web.domain.SearchParam;

public interface CodeMapper {

	void insertCodeGroup(CodeGroup codeGroup);

	int groupKeyDuplicateCount(CodeGroup codeGroup);

	CodeGroup getCodeGroupDetail(CodeGroup codeGroup);

	List<CodeGroup> getCodeGroupList(SearchParam searchParam);

	void updateCodeGroup(CodeGroup codeGroup);

	List<CodeData> getCodeDataList(SearchParam searchParam);

	int dataKeyDuplicateCount(CodeData codeData);

	String getCode(CodeData codeData);

	void insertCodeData(CodeData codeData);

	CodeData getCodeDataDetail(CodeData codeData);

	void updateCodeData(CodeData codeData);

	List<CodeData> getCommonCodeList(@Param("groupKey")String groupKey);

	List<CodeData> getManagerDeptList(HashMap depts);

	CodeGroup getCodeGroupDetailByGroupKey(String groupKey);

}
