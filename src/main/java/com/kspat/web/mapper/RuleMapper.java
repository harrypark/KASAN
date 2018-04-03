package com.kspat.web.mapper;

import java.util.List;

import com.kspat.web.domain.DailyRule;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.domain.YearlyRule;

public interface RuleMapper {

	List<DailyRule> getDailyRuleList(SearchParam searchParam);

	DailyRule getDailyRuleDetail(SearchParam searchParam);

	void updateDailyRule(DailyRule dailyRule);

	void insertDailyRule(DailyRule dailyRule);

	void updateDailyRuleLastRecord(DailyRule dailyRule);

	int isDuplicateCheckDailyRule(DailyRule dailyRule);

	List<YearlyRule> getYearlyRuleList(SearchParam searchParam);

	YearlyRule getyearlyRuleDetail(SearchParam searchParam);

	void updateYearlyRule(YearlyRule yearlyRule);

	DailyRule getCurrentDailyRule(String dt);

	String getAnnualRule();

	void updateAnnualRule(String rule);

	String getAnnualApplyDt();

	void insertAnnualApplyDt(String applyDt);

}
