package com.kspat.web.mapper;

import java.util.List;

import com.kspat.web.domain.DailyStat;
import com.kspat.web.domain.LatePoint;
import com.kspat.web.domain.Score;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.domain.LateStatPoint;

public interface StatMapper {

	void deleteDayilStat(String calDt);

	List<DailyStat> getDailyStatList(SearchParam param);

	void insertDailyStat(DailyStat ds);

	DailyStat getUserStatDetail(SearchParam searchParam);

	void updateAdjust(DailyStat ds);

	Score getUserAnnualUsedInfo(SearchParam param);

	Score getUserAnnualSubInfo(SearchParam param);

	Score getUserScore(SearchParam param);

	List<Score> getScoreList(SearchParam param);

	List<LatePoint> getLatePointList(SearchParam param);

	List<LateStatPoint> getLateStatPointList(String targetYear);

	void insertLatePoint(LatePoint lp);

	void updateLatePointWithMailSendDt(LatePoint lp);

	void updateLatePoint(LatePoint lp);

	List<Score> getAnnualEmailSendScoreList(SearchParam searchParam);

}
