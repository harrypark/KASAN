package com.kspat.web.scheduler;

import org.apache.commons.lang.time.StopWatch;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.kspat.web.service.StatService;

@Component
public class DailyStatScheduler {
	/** The logger.<br/> 로거. */
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private StatService statService;

	//Formatter
	DateTimeFormatter fmt_ymdhms = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss");
	DateTimeFormatter fmt_ymd = DateTimeFormat.forPattern("yyyy-MM-dd");


	@Scheduled(cron="0 0 02 * * ?") //새벽2시 실행
	public void scheduleDailyStatTask() {
		StopWatch stopWatch = new StopWatch();
		stopWatch.reset();
		stopWatch.start();

		logger.debug("=== Daily Stat batch start==================");
		DateTime dateTime = new DateTime();
	    logger.debug("Current time - " + dateTime.toString(fmt_ymdhms));

	    int resCount = statService.batchDailyStat(dateTime.minusDays(1).toString(fmt_ymd));

	    logger.debug("Current time - " + dateTime.toString(fmt_ymdhms));
	    logger.debug("작업건수:"+ resCount);
	    stopWatch.stop();
	    logger.debug("작업시간:"+ stopWatch.toString());
	    logger.debug("=== Daily Stat batch end==================");


	}

}
