package com.kspat.web.service;

import java.util.List;

import com.kspat.web.domain.Calendar;
import com.kspat.web.domain.CodeData;
import com.kspat.web.domain.CodeGroup;
import com.kspat.web.domain.SearchParam;

public interface CodeService {

	CodeGroup insertCodeGroup(CodeGroup codeGroup);

	List<CodeGroup> getCodeGroupList(SearchParam searchParam);

	CodeGroup getCodeGroupDetail(CodeGroup codeGroup);

	CodeGroup updateCodeGroup(CodeGroup codeGroup);

	List<CodeData> getCodeDataList(SearchParam searchParam);

	CodeData insertCodeData(CodeData codeData);

	CodeData getCodeDataDetail(CodeData codeData);

	CodeData updateCodeData(CodeData codeData);

	List<CodeData> getCommonCodeList(String groupKey);

	CodeGroup getCodeGroupDetailByGroupKey(String groupKey);



}
