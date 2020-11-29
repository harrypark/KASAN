package com.kspat.web.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kspat.web.domain.AvailableReplaceInfo;
import com.kspat.web.domain.Replace;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.domain.Workout;
import com.kspat.web.mapper.ReplaceMapper;
import com.kspat.web.service.EmailTempleatService;
import com.kspat.web.service.ReplaceService;

@Service
public class ReplaceServiceImpl implements ReplaceService{

	@Autowired
	private ReplaceMapper replaceMapper;

	@Autowired
	private EmailTempleatService emailTempleatService;

	@Override
	public Replace getReplaceAvailableTime() {
		return replaceMapper.getReplaceAvailableTime();
	}

	@Override
	public int checkAvailableReplaceCount(SearchParam param) {
		return replaceMapper.checkAvailableReplaceCount(param);
	}

	@Override
	public Replace insertReplace(Replace replace) {
		Replace re = new Replace();

		boolean availReplaceCountOver =false;
		//1. 데체근무 신청건수 초과(2건이라도 같은 날이면 허용)
		SearchParam param = new SearchParam();
		param.setCrtdId(replace.getCrtdId());
		param.setSearchDt(replace.getReplDt());

		AvailableReplaceInfo availableReplaceInfo  =  replaceMapper.checkAvailableReplaceInfo(param);
		//이달 신청가능 대체근무가 없을때
		if(availableReplaceInfo.getCurrCount() <= 0){
			//이미신천된 같은 날의 대체근무가 있는지 확인
			int regCount = replaceMapper.getReplDtRegDtCount(param);
			if(regCount==0){//없으면 신청불가
				availReplaceCountOver = true;
			}
		}

		re.setAvailReplaceCountOver(availReplaceCountOver);

		//2. 반휴, 채우는날중복 체크
		/*
		 * 반휴와 채우는 날 중복 신청 허용(대신 지각 체크는 하지 않고, 근무시간만 밚(4시간)+채우는 시간으로 설정)
		 * 2016-12-20 채변리사님 요청

		boolean hlSuppDuplicate =  replaceMapper.checkHlSuppDuplicate(replace)>0?true:false;
		re.setHlSuppDuplicate(hlSuppDuplicate);
		*/
		boolean hlSuppDuplicate = false;

		if(availReplaceCountOver == false && hlSuppDuplicate ==false ){

			replaceMapper.insertReplace(replace);

			SearchParam searchParam = new SearchParam(replace.getId());
			re = replaceMapper.getReplaceDetailById(searchParam);

			//대체등록정보를 부서 매니져에게 메일발송
			emailTempleatService.setReplaceEmailTempleate(replace, "regist",replace.getDeptCd());
		}

		return re;
	}


	@Override
	public List<Replace> getReplaceList(SearchParam searchParam) {
		return replaceMapper.getReplaceList(searchParam);
	}

	@Override
	public int deleteReplace(Replace replace) {
		SearchParam searchParam = new SearchParam(replace.getId());
		Replace re = replaceMapper.getReplaceDetailById(searchParam);
		re.setCrtdId(replace.getCrtdId());

		int res = replaceMapper.deleteReplace(replace);
		//대체삭제정보를 부서 매니져에게 메일발송
		emailTempleatService.setReplaceEmailTempleate(re, "delete",replace.getDeptCd());

		return res;
	}

	@Override
	public Replace getReplaceDetail(SearchParam searchParam) {
		return replaceMapper.getReplaceDetailById(searchParam);
	}

	@Override
	public Replace updateReplace(Replace replace) {

		replaceMapper.updateReplace(replace);

		SearchParam searchParam = new SearchParam(replace.getId());
		return replaceMapper.getReplaceDetailById(searchParam);
	}

	@Override
	public AvailableReplaceInfo checkAvailableReplaceInfo(SearchParam param) {
		return replaceMapper.checkAvailableReplaceInfo(param);
	}

	@Override
	public String hasSelectDayReplace(SearchParam searchParam) {
		return replaceMapper.hasSelectDayReplace(searchParam);
	}

}
