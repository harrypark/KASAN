package com.kspat.web.scheduler;

import java.util.List;

import org.apache.commons.lang.time.StopWatch;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.kspat.web.domain.AutoAnnual;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.service.AutoAnnualService;

@Component
public class DailyAutoAnnualScheduler {

	/** The logger.<br/> 로거. */
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private AutoAnnualService autoAnnualService;


	//Formatter
	DateTimeFormatter fmt_ymdhms = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss");
	DateTimeFormatter fmt_ymd = DateTimeFormat.forPattern("yyyy-MM-dd");

	@Scheduled(cron="0 0 01 * * ?") //새벽1시 실행
	public void scheduleDailyAutoAnnualTask() {
		StopWatch stopWatch = new StopWatch();
		stopWatch.reset();
		stopWatch.start();

		logger.debug("=== Daily AutoAnnual batch start==================");
		DateTime dateTime = new DateTime();
	    logger.debug("Current time - " + dateTime.toString(fmt_ymdhms));

	    SearchParam searchParam = new SearchParam();
	    searchParam.setSearchDate(dateTime.toString(fmt_ymd));

		List<AutoAnnual> list = autoAnnualService.manualCreateAutoAnnual(searchParam);


		if(list != null){
			logger.debug("===>AutoAnnual 전체작업건수:"+ list.size());
		}else{
			logger.debug("===>AutoAnnual 전체작업건수:"+ list);
		}


		// 매년 06-25, 10-25 미사용연차에대한 메일발송
		autoAnnualService.sendRemainingAnnualMail(searchParam);


	    stopWatch.stop();
	    logger.debug("작업시간:"+ stopWatch.toString());
	    logger.debug("=== Daily AutoAnnual batch end==================");


	}
}
