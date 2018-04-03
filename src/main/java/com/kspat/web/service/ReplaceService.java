package com.kspat.web.service;

import java.util.List;

import com.kspat.web.domain.AvailableReplaceInfo;
import com.kspat.web.domain.Replace;
import com.kspat.web.domain.SearchParam;

public interface ReplaceService {

	Replace getReplaceAvailableTime();

	int checkAvailableReplaceCount(SearchParam param);

	Replace insertReplace(Replace replace);

	List<Replace> getReplaceList(SearchParam searchParam);

	int deleteReplace(Replace replace);

	Replace getReplaceDetail(SearchParam searchParam);

	Replace updateReplace(Replace replace);

	AvailableReplaceInfo checkAvailableReplaceInfo(SearchParam param);

}
