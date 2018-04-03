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
public class DailyLateStatScheduler {
	/** The logger.<br/> 로거. */
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private StatService statService;

	//Formatter
	DateTimeFormatter fmt_ymdhms = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss");
	DateTimeFormatter fmt_yyyy = DateTimeFormat.forPattern("yyyy");


	@Scheduled(cron="0 30 02 * * ?") //새벽02:30  실행
	public void scheduleDailyLateStatTask() {
		StopWatch stopWatch = new StopWatch();
		stopWatch.reset();
		stopWatch.start();

		logger.debug("=== Daily Late Stat batch start==================");
		DateTime dateTime = new DateTime();
	    logger.debug("Current time - " + dateTime.toString(fmt_ymdhms));

		String targetYear = dateTime.minusDays(1).toString(fmt_yyyy);
		//targetYear="2016";
	    logger.debug("Late stat update year - " + targetYear);

	    int[] result = statService.updateLateStat(targetYear);

	    logger.debug("Current time - " + dateTime.toString(fmt_ymdhms));

	    logger.debug("===>초기데이터 insert:"+ result[0]);
	    logger.debug("===>mail발송 & update:"+ result[1]);
	    logger.debug("===>기존데이터 update:"+ result[2]);
	    logger.debug("===>전체작업건수:"+ result[0]+result[1]+result[2]);


	    stopWatch.stop();
	    logger.debug("작업시간:"+ stopWatch.toString());
	    logger.debug("=== Daily Late Stat batch end==================");


	}

}
