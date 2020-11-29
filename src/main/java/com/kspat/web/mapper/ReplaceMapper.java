package com.kspat.web.mapper;

import java.util.List;

import com.kspat.web.domain.AvailableReplaceInfo;
import com.kspat.web.domain.Replace;
import com.kspat.web.domain.SearchParam;

public interface ReplaceMapper {

	Replace getReplaceAvailableTime();

	int checkAvailableReplaceCount(SearchParam param);

	void insertReplace(Replace replace);

	Replace getReplaceDetailById(SearchParam searchParam);

	List<Replace> getReplaceList(SearchParam searchParam);

	int deleteReplace(Replace replace);

	int checkReplDuplicate(Replace replace);

	/* 체크하지 않음
	int checkHlSuppDuplicate(Replace replace);
	*/

	void updateReplace(Replace replace);

	AvailableReplaceInfo checkAvailableReplaceInfo(SearchParam param);

	int getReplDtRegDtCount(SearchParam param);

	String hasSelectDayReplace(SearchParam searchParam);

}
