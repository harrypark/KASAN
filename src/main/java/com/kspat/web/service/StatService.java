package com.kspat.web.service;

import java.util.List;

import com.kspat.web.domain.LatePoint;
import com.kspat.web.domain.Score;
import com.kspat.web.domain.DailyStat;
import com.kspat.web.domain.SearchParam;

public interface StatService {

	List<DailyStat> manualCreateDailyStat(SearchParam searchParam);

	List<DailyStat> getDailyStatList(SearchParam searchParam);

	DailyStat getUserStatDetail(SearchParam searchParam);

	DailyStat updateAdjust(DailyStat ds);

	int batchDailyStat(String string);

	Score getUserScore(SearchParam param);

	List<Score> getScoreList(SearchParam param);

	List<LatePoint> getLatePointList(SearchParam param);

	int[] updateLateStat(String targetYear);

}
