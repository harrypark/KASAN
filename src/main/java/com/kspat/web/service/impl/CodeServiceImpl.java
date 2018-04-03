package com.kspat.web.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kspat.web.domain.CodeData;
import com.kspat.web.domain.CodeGroup;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.mapper.CodeMapper;
import com.kspat.web.service.CodeService;

@Service
public class CodeServiceImpl implements CodeService {

	@Autowired
	private CodeMapper codeMapper;

	@Override
	public CodeGroup insertCodeGroup(CodeGroup codeGroup) {
		CodeGroup cg = new CodeGroup();
		//중복체크
		int count = codeMapper.groupKeyDuplicateCount(codeGroup);
		if(count > 0){
			cg.setDuplicate(true);
		}else{
			codeMapper.insertCodeGroup(codeGroup);
			cg = codeMapper.getCodeGroupDetail(codeGroup);
		}
		return cg;
	}

	@Override
	public List<CodeGroup> getCodeGroupList(SearchParam searchParam) {
		return codeMapper.getCodeGroupList(searchParam);
	}

	@Override
	public CodeGroup getCodeGroupDetail(CodeGroup codeGroup) {
		return codeMapper.getCodeGroupDetail(codeGroup);
	}

	@Override
	public CodeGroup updateCodeGroup(CodeGroup codeGroup) {
		codeMapper.updateCodeGroup(codeGroup);
		CodeGroup cg = codeMapper.getCodeGroupDetail(codeGroup);
		return cg;
	}

	@Override
	public List<CodeData> getCodeDataList(SearchParam searchParam) {
		return codeMapper.getCodeDataList(searchParam);
	}

	@Override
	public CodeData insertCodeData(CodeData codeData) {
		CodeData cd = new CodeData();

		String code = makeCodeKey(codeMapper.getCode(codeData));
       	codeData.setCode(code);
		codeMapper.insertCodeData(codeData);
		cd = codeMapper.getCodeDataDetail(codeData);
		return cd;
	}

	private String makeCodeKey(String codeKey) {
		String key="001";
		if(codeKey != null){
			int keyVal = Integer.parseInt(codeKey)+1;
			if(keyVal<10){
				key = "00"+keyVal;
			}else if(keyVal<100){
				key = "0"+keyVal;
			}else{
				key = Integer.toString(keyVal);
			}
		}
		System.out.println("codeKey:"+key);
		return key;
	}

	@Override
	public CodeData getCodeDataDetail(CodeData codeData) {
		return codeMapper.getCodeDataDetail(codeData);
	}

	@Override
	public CodeData updateCodeData(CodeData codeData) {
		codeMapper.updateCodeData(codeData);
		CodeData cd = codeMapper.getCodeDataDetail(codeData);
		return cd;
	}

	@Override
	public List<CodeData> getCommonCodeList(String groupKey) {
		return codeMapper.getCommonCodeList(groupKey);
	}

	@Override
	public CodeGroup getCodeGroupDetailByGroupKey(String groupKey) {
		return codeMapper.getCodeGroupDetailByGroupKey(groupKey);
	}






}
