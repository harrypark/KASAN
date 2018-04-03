package com.kspat.web.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kspat.web.domain.DailyRule;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.domain.YearlyRule;
import com.kspat.web.mapper.RuleMapper;
import com.kspat.web.service.RuleService;

@Service
public class RuleServiceImpl implements RuleService {

	@Autowired
	private RuleMapper ruleMapper;

	@Override
	public List<DailyRule> getDailyRuleList(SearchParam searchParam) {
		return ruleMapper.getDailyRuleList(searchParam);
	}

	@Override
	public DailyRule getDailyRuleDetail(SearchParam searchParam) {
		return ruleMapper.getDailyRuleDetail(searchParam);
	}

	@Override
	public DailyRule updateDailyRule(DailyRule dailyRule) {

		ruleMapper.updateDailyRule(dailyRule);

		SearchParam searchParam = new SearchParam();
		searchParam.setFromDate(dailyRule.getApplyStartDt());
		searchParam.setToDate(dailyRule.getApplyEndDt());

		return ruleMapper.getDailyRuleDetail(searchParam);
	}

	@Override
	@Transactional
	public DailyRule insertDailyRule(DailyRule dailyRule) {

		int count = ruleMapper.isDuplicateCheckDailyRule(dailyRule);
		//System.out.println(count);
		if(count > 0){
			dailyRule.setDuplicate(true);

		}else{
			System.out.println("설마");
			ruleMapper.updateDailyRuleLastRecord(dailyRule);

			ruleMapper.insertDailyRule(dailyRule);
		}

		//System.out.println(dailyRule.toString());

		return dailyRule;

	}

	@Override
	public List<YearlyRule> getYearlyRuleList(SearchParam searchParam) {
		return ruleMapper.getYearlyRuleList(searchParam);
	}

	@Override
	public YearlyRule getyearlyRuleDetail(SearchParam searchParam) {
		return ruleMapper.getyearlyRuleDetail(searchParam);
	}

	@Override
	public YearlyRule updateYearlyRule(YearlyRule yearlyRule) {
		YearlyRule rule = new YearlyRule();

		ruleMapper.updateYearlyRule(yearlyRule);
		if("2".equals(yearlyRule.getUpdateType())){//선택 년도만 업데이트하면
			SearchParam searchParam = new SearchParam();
			searchParam.setSearchYear(yearlyRule.getApplyYear());
			rule = ruleMapper.getyearlyRuleDetail(searchParam);
		}else{
			rule = yearlyRule;
		}


		return rule;
	}

	@Override
	public DailyRule getCurrentDailyRule(String dt) {
		return ruleMapper.getCurrentDailyRule(dt);
	}

	@Override
	public String getAnnualRule() {
		return ruleMapper.getAnnualRule();
	}

	@Override
	public void updateAnnualRule(String rule) {
		ruleMapper.updateAnnualRule(rule);

	}

	@Override
	public String getAnnualApplyDt() {
		String applyDt = ruleMapper.getAnnualApplyDt();

		return applyDt;
	}

	@Override
	public void updateAnnualApplyDt(String applyDt) {
		ruleMapper.insertAnnualApplyDt(applyDt);

	}

}
