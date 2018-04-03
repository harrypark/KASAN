package com.kspat.web.service;

import java.util.List;

import com.kspat.web.domain.DailyRule;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.domain.YearlyRule;

public interface RuleService {

	List<DailyRule> getDailyRuleList(SearchParam searchParam);

	DailyRule getDailyRuleDetail(SearchParam searchParam);

	DailyRule updateDailyRule(DailyRule dailyRule);

	DailyRule insertDailyRule(DailyRule dailyRule);

	List<YearlyRule> getYearlyRuleList(SearchParam searchParam);

	YearlyRule getyearlyRuleDetail(SearchParam searchParam);

	YearlyRule updateYearlyRule(YearlyRule yearlyRule);

	DailyRule getCurrentDailyRule(String dt);

	String getAnnualRule();

	void updateAnnualRule(String rule);

	String getAnnualApplyDt();

	void updateAnnualApplyDt(String applyDt);

}
