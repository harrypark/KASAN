package com.kspat.web.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kspat.util.common.Constants;
import com.kspat.util.common.DailyStatUtil;
import com.kspat.web.domain.DailyRule;
import com.kspat.web.domain.DailyStat;
import com.kspat.web.domain.DayInfo;
import com.kspat.web.domain.LatePoint;
import com.kspat.web.domain.MailContent;
import com.kspat.web.domain.Overtime;
import com.kspat.web.domain.Score;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.domain.User;
import com.kspat.web.domain.UserState;
import com.kspat.web.domain.LateStatPoint;
import com.kspat.web.mapper.CalendarMapper;
import com.kspat.web.mapper.DashboardMapper;
import com.kspat.web.mapper.OvertimeMapper;
import com.kspat.web.mapper.RuleMapper;
import com.kspat.web.mapper.StatMapper;
import com.kspat.web.mapper.UserMapper;
import com.kspat.web.service.EmailService;
import com.kspat.web.service.EmailTempleatService;
import com.kspat.web.service.OvertimeService;
import com.kspat.web.service.StatService;

@Service
public class StatServiceImpl implements StatService {
	private static final Logger logger = LoggerFactory.getLogger(StatServiceImpl.class);

	@Autowired
	private StatMapper statMapper;

	@Autowired
	private DashboardMapper dashboardMapper;

	@Autowired
	private CalendarMapper calendarMapper;

	@Autowired
	private RuleMapper ruleMapper;

	@Autowired
	private OvertimeMapper overtimeMapper;

	@Autowired
	private OvertimeService overtimeService;

	@Autowired
	private EmailTempleatService emailTempleatService;

	@Autowired
	private EmailService emailService;

	@Autowired
	private UserMapper userMapper;



	/* 수동 통게생성
	 * 1. 기존 통계 삭제
	 * ------------
	 * 2.
	 * (non-Javadoc)
	 * @see com.kspat.web.service.StatService#manualCreateDailyStat(com.kspat.web.domain.SearchParam)
	 */
	@Override
	public List<DailyStat> manualCreateDailyStat(SearchParam searchParam) {
		List<DailyStat> statList = new ArrayList<DailyStat>();
		//searchParam.setSearchDt("2019-09-25");//test 용
		String calDt = searchParam.getSearchDt();


		DayInfo dayInfo = calendarMapper.getDayInfo(calDt);
		DailyRule dailyRule = ruleMapper.getCurrentDailyRule(calDt);


		List<UserState> list =  dashboardMapper.dashUserStateList(searchParam);
		if(list.size()>0){
			list = DailyStatUtil.getNowWorking(list,calDt, dayInfo,dailyRule);

			list = DailyStatUtil.getDailyStat(list,calDt, dayInfo,dailyRule);

			statList = setDailyStat(list, calDt, dayInfo,dailyRule);

			//해당낭짜의 통게가 있다면 삭제
			statMapper.deleteDayilStat(calDt);
			for(DailyStat ds : statList){
				statMapper.insertDailyStat(ds);
			}
			//야근신청 데이터 update
			updateOvertime(calDt, statList);
		}

		SearchParam param = new SearchParam(calDt,calDt,"all","all");
		statList = statMapper.getDailyStatList(param);

		return statList;
	}



	/** 야근신청 update
	 * @param calDt
	 * @param statList
	 */
	private void updateOvertime(String calDt, List<DailyStat> statList) {
		List<Overtime> overtimeList = overtimeMapper.getRequestOvertimeList(calDt);

		if(overtimeList.size() > 0){
			SearchParam searchParam = new SearchParam();
			searchParam.setSearchDt(calDt);

			for(Overtime ot: overtimeList){
				searchParam.setCrtdId(ot.getCrtdId());
				Overtime checkOvertime = overtimeService.getReqDateOvertimeInfo(searchParam);

				if(checkOvertime != null){
					//overtime id set
					checkOvertime.setId(ot.getId());

					if(checkOvertime.isHolidayYn() == true){
						checkOvertime.setResult("003");
						checkOvertime.setMemo("휴일");
					}
					if(checkOvertime.isDataErrorYn() == true){
						checkOvertime.setResult("003");
						checkOvertime.setMemo("데이터 에러");
					}
					//근태 기록이  없을때 sql에러 방지
					if(checkOvertime.getExpOutTm() == null || checkOvertime.getOutTm() == null){
						checkOvertime.setResult("003");
						checkOvertime.setMemo("근태기록(출퇴근) 없음.");
						checkOvertime.setExpOutTm("00:00");
						checkOvertime.setOutTm("00:00");
					}

				}

				overtimeMapper.updateReqUserOvertime(checkOvertime);
			}
		}

	}



	private List<DailyStat> setDailyStat(List<UserState> list, String calDt,
			DayInfo dayInfo, DailyRule dailyRule) {

		List<DailyStat> dsList = new ArrayList<DailyStat>();
		for(UserState us: list){
			DailyStat ds= new DailyStat(us.getId(),us.getCapsName(),calDt,dayInfo.getCalWeekName(),dayInfo.getIsHoliday(),dayInfo.getDataError());
//			logger.info("***********************");
//			logger.info(ds.toString());
//			logger.info("***********************");


			if("Y".equals(dayInfo.getDataError())){
				/*
				 * 지각, 근무시감미달,결근 체크 없음 --> 연차차감없음 (출근 퇴근시간 없음)
				 * 휴가, 반휴에 대한 연차차감만 한다.
				 *
				 */
				if("Y".equals(dayInfo.getIsHoliday())){
					ds.setGoTm(null);
					ds.setOutTm(null);
					ds.setExpOutTm(null);
					ds.setLateTm(null);
					ds.setCalWorkTmMin(0);
					ds.setWorkTmMin(0);

					ds.setStLeave(0.0);
					ds.setStHlLeave(0.0);
					ds.setStOffcial("N");
					ds.setStShortLate(0);
					ds.setStLongLate(0);
					ds.setStFailWorkTm(0);
					ds.setStAbsence(0);
					ds.setMemo("Data Error");
				}else{
					ds.setGoTm(null);
					ds.setOutTm(null);
					ds.setExpOutTm(null);
					ds.setLateTm(null);
					ds.setCalWorkTmMin(0);
					ds.setWorkTmMin(0);
					//반휴 체크
					if(us.getHlLeave()!=null){
						if("Y".equals(us.getHlLeave().getOffcial())){
							ds.setStHlLeave(0.0);
							ds.setStOffcial("Y");
						}else{
							ds.setStHlLeave(0.5);
							ds.setStOffcial("N");
						}
					}else{
						ds.setStHlLeave(0.0);
					}
					//휴가체크
					if(us.getLeave()!=null){
						if("Y".equals(us.getLeave().getOffcial())){
							ds.setStLeave(0.0);
							ds.setStOffcial("Y");
						}else{
							ds.setStLeave(1.0);
							ds.setStOffcial("N");
						}

					}else{
						ds.setStLeave(0.0);
						ds.setStOffcial(null);
					}
					ds.setStShortLate(0);
					ds.setStLongLate(0);
					ds.setStFailWorkTm(0);
					ds.setStAbsence(0);
					ds.setMemo("Data Error");
				}
			}else{
				if("Y".equals(dayInfo.getIsHoliday())){
					if(us.getBtrip() != null){
						logger.debug("출장");
					}
					ds.setGoTm(us.getCalHereGo());
					ds.setOutTm(us.getCalHereOut());
					ds.setExpOutTm(us.getExpHereOut());
					ds.setLateTm(us.getLateTm());
					ds.setCalWorkTmMin(us.getCalWorkTmMin());
					ds.setWorkTmMin(us.getWorkTmMin());

					//반휴 체크
					if(us.getHlLeave()!=null){
						if("Y".equals(us.getHlLeave().getOffcial())){
							ds.setStHlLeave(0.0);
							ds.setStOffcial("Y");
						}else{
							ds.setStHlLeave(0.5);
							ds.setStOffcial("N");
						}
					}else{
						ds.setStHlLeave(0.0);
						ds.setStOffcial("N");
					}
					//휴가체크
					if(us.getLeave()!=null){
						if("Y".equals(us.getLeave().getOffcial())){
							ds.setStLeave(0.0);
							ds.setStOffcial("Y");
						}else{
							ds.setStLeave(1.0);
							ds.setStOffcial("N");
						}

					}else{
						ds.setStLeave(0.0);
						ds.setStOffcial("N");
					}
					// 일통계에서 대체근무시간 계산
					if(us.getSupple()!=null && us.getSupple().size()>0){//채우는날
						if(us.getDiffWorkTmMin()<0){
							ds.setStFailWorkTm(0.5);
						}else{
							ds.setStFailWorkTm(0);
						}
						if(us.getCalHereGo()==null || us.getCalHereOut()==null){//휴일결근은 근문시간 부족으로 처리한다.
							ds.setStFailWorkTm(0.5);//휴일결근 0.5차감
						}
						ds.setStAbsence(0);
					}else{
						ds.setStAbsence(0);
					}
					ds.setStShortLate(0);
					ds.setStLongLate(0);
					ds.setMemo(null);

				}else if(us.getBtrip() != null){
					ds.setGoTm(us.getCalHereGo());
					ds.setOutTm(us.getCalHereOut());
					ds.setExpOutTm(us.getExpHereOut());
					ds.setLateTm(us.getLateTm());
					ds.setCalWorkTmMin(us.getCalWorkTmMin());
					ds.setWorkTmMin(us.getWorkTmMin());

					ds.setStLeave(0.0);
					ds.setStHlLeave(0.0);
					ds.setStOffcial("N");
					ds.setStShortLate(0);
					ds.setStLongLate(0);
					ds.setStFailWorkTm(0);
					ds.setStAbsence(0);
					ds.setMemo("출장적용");

				}else if(us.getLeave() != null){
					ds.setGoTm(null);
					ds.setOutTm(null);
					ds.setExpOutTm(null);
					ds.setLateTm(null);
					ds.setCalWorkTmMin(0);
					ds.setWorkTmMin(0);

					//휴가체크
					if("Y".equals(us.getLeave().getOffcial())){
						ds.setStLeave(0.0);
						ds.setStOffcial("Y");
					}else{
						ds.setStLeave(1.0);
						ds.setStOffcial("N");
					}

					ds.setStHlLeave(0.0);
					ds.setStShortLate(0);
					ds.setStLongLate(0);
					ds.setStFailWorkTm(0);
					ds.setStAbsence(0);
					ds.setMemo("휴가적용");
				}else if(us.getHlLeave() != null){
					ds.setGoTm(us.getCalHereGo());
					ds.setOutTm(us.getCalHereOut());
					ds.setExpOutTm(us.getExpHereOut());
					ds.setLateTm(us.getLateTm());
					ds.setCalWorkTmMin(us.getCalWorkTmMin());
					ds.setWorkTmMin(us.getWorkTmMin());

					//반휴체크
					if("Y".equals(us.getHlLeave().getOffcial())){
						ds.setStHlLeave(0.0);
						ds.setStOffcial("Y");
					}else{
						ds.setStHlLeave(0.5);
						ds.setStOffcial("N");
					}
					ds.setStLeave(0.0);
					ds.setStShortLate(0);
					ds.setStLongLate(0);
					//근무시간미준수체크
					if(us.getDiffWorkTmMin()<0 && "Y".equals(us.getDashState())){ //파트너 제외 20170612
						ds.setStFailWorkTm(0.5);
					}else{
						ds.setStFailWorkTm(0);
					}
					//무단결근체크
					if(us.getCalHereGo()==null || us.getCalHereOut()==null){
//						logger.debug("us.getCalWorkTmMin():"+us.getCalWorkTmMin());
//						logger.debug("us.getWorkTmMin():"+us.getWorkTmMin());
//						logger.debug("us.getDiffWorkTmMin():"+us.getDiffWorkTmMin());
//						logger.debug("us.getWorkTmMin():"+ (us.getCalWorkTmMin()-us.getWorkTmMin()));
						if(us.getCalWorkTmMin() !=0 && "Y".equals(us.getDashState())){//파트너 제외 20170612
							ds.setStAbsence(1);
						}else{
							ds.setStAbsence(0);
						}

					}else{
						ds.setStAbsence(0);
					}
					ds.setMemo("반휴적용");
				}else{
					ds.setGoTm(us.getCalHereGo());
					ds.setOutTm(us.getCalHereOut());
					ds.setExpOutTm(us.getExpHereOut());
					ds.setLateTm(us.getLateTm());
					ds.setCalWorkTmMin(us.getCalWorkTmMin());
					ds.setWorkTmMin(us.getWorkTmMin());

					//반휴 체크
					if(us.getHlLeave()!=null){
						if("Y".equals(us.getHlLeave().getOffcial())){
							ds.setStHlLeave(0.0);
							ds.setStOffcial("Y");
						}else{
							ds.setStHlLeave(0.5);
							ds.setStOffcial("N");
						}
					}else{
						ds.setStHlLeave(0.0);
					}
					//휴가체크
					if(us.getLeave()!=null){
						if("Y".equals(us.getLeave().getOffcial())){
							ds.setStLeave(0.0);
							ds.setStOffcial("Y");
						}else{
							ds.setStLeave(1.0);
							ds.setStOffcial("N");
						}

					}else{
						ds.setStLeave(0.0);
						ds.setStOffcial(null);
					}
					//지각체크
					if("short".equals(us.getLate())){
						ds.setStShortLate(1);
						ds.setStLongLate(0);
					}else if("long".equals(us.getLate())){
						ds.setStShortLate(0);
						ds.setStLongLate(1);
					}else{
						ds.setStShortLate(0);
						ds.setStLongLate(0);
					}
                    //근무시간미준수체크
					if(us.getDiffWorkTmMin()<0 ){
						ds.setStFailWorkTm(0.5);
					}else{
						ds.setStFailWorkTm(0);
					}
					//무단결근체크
					if(us.getCalHereGo()!=null && us.getCalHereOut()!=null){
						ds.setStAbsence(0);
					}else{
						if(us.getCalWorkTmMin() <= 0){
							ds.setStAbsence(1);
						}else{
							ds.setStAbsence(0);
						}
					}
					/* 2017-04-20 위 로직으로 수정
					if(us.getCalHereGo()==null || us.getCalHereOut()==null){
						ds.setStAbsence(1);
					}else{
						ds.setStAbsence(0);
					}
					*/
					ds.setMemo("일반적용");
				}
				//지각에 대한 연차 차감계산
			}

			//만약 결근의경우 근무시간 미달은 적용하지 않는다.
			if(ds.getStAbsence()==1){
				ds.setStFailWorkTm(0);
			}
			//사후조정은 기본값 N
			ds.setStAdjust("N");
			/*
			 * 파트너 제외 20170821
			 * 파트너는 무단결근, 근무시간 미준수 패널티 제외
			 */
			if("N".equals(us.getDashState())){
				ds.setStFailWorkTm(0);
				ds.setStAbsence(0);
			}

			//통계 list에 추가
			dsList.add(ds);
		}


		return dsList;
	}



	@Override
	public List<DailyStat> getDailyStatList(SearchParam searchParam) {
		return statMapper.getDailyStatList(searchParam);
	}



	@Override
	public DailyStat getUserStatDetail(SearchParam searchParam) {
		return statMapper.getUserStatDetail(searchParam);
	}



	/* (non-Javadoc)
	 * 사후조정
	 * @see com.kspat.web.service.StatService#updateAdjust(com.kspat.web.domain.DailyStat)
	 */
	@Override
	public DailyStat updateAdjust(DailyStat ds) {
		statMapper.updateAdjust(ds);

		SearchParam searchParam = new SearchParam();
		searchParam.setSearchUser(Integer.toString(ds.getId()));
		searchParam.setSearchDt(ds.getStDt());
		DailyStat stat = statMapper.getUserStatDetail(searchParam);
		return stat;
	}



	/* (non-Javadoc)
	 * 배치작업
	 * @see com.kspat.web.service.StatService#batchDailyStat(java.lang.String)
	 */
	@Override
	public int batchDailyStat(String calDt) {
		logger.debug("  작업일: "+calDt);
		List<DailyStat> statList = new ArrayList<DailyStat>();


		DayInfo dayInfo = calendarMapper.getDayInfo(calDt);
		DailyRule dailyRule = ruleMapper.getCurrentDailyRule(calDt);

		SearchParam searchParam = new SearchParam();
		searchParam.setSearchDt(calDt);

		List<UserState> list =  dashboardMapper.dashUserStateList(searchParam);

		int userCount = list.size();

		if(userCount>0){
			list = DailyStatUtil.getNowWorking(list,calDt, dayInfo,dailyRule);

			list = DailyStatUtil.getDailyStat(list,calDt, dayInfo,dailyRule);

			statList = setDailyStat(list, calDt, dayInfo,dailyRule);

			//해당낭짜의 통게가 있다면 삭제
			statMapper.deleteDayilStat(calDt);
			for(DailyStat ds : statList){
				statMapper.insertDailyStat(ds);
			}

			//야근신청 업데이트
			updateOvertime(calDt, statList);
		}


		return userCount;
	}



	/* (non-Javadoc)
	 * 근태스코어
	 * @see com.kspat.web.service.StatService#getUserScore(com.kspat.web.domain.SearchParam)
	 */
	@Override
	public Score getUserScore(SearchParam param) {

		return statMapper.getUserScore(param);
	}



	@Override
	public List<Score> getScoreList(SearchParam param) {
		return statMapper.getScoreList(param);
	}



	@Override
	public List<LatePoint> getLatePointList(SearchParam param) {
		return statMapper.getLatePointList(param);
	}



	/* 지각통계 update
	 * @see com.kspat.web.service.StatService#updateLateStat(java.lang.String)
	 */
	@Override
	public int[] updateLateStat(String targetYear) {
		logger.debug("targetYear:{}",targetYear);
		List<LateStatPoint> list = statMapper.getLateStatPointList(targetYear);

		//mail content
		MailContent content = emailService.getMailContentDetail(new MailContent(Constants.MAIL_CONTENT_LATE_POINT_ID));

		//lateDefaultAddr
		String lateAddr = emailService.getMailDefault();
		//String[] lateDefaultAddr = lateAddr.split(",");
	    StringTokenizer tokens = new StringTokenizer( lateAddr, "," );
	    //기본수신인
	    String[] lateDefaultAddress = null;
	    if(tokens.countTokens()>0){
	    	lateDefaultAddress = new String[tokens.countTokens()];
		    for( int i = 0; tokens.hasMoreElements(); i++ ){
		    	lateDefaultAddress[i]=tokens.nextToken();
		    }
	    }

		/*
		 * 결과 저장용 배열
		 */
		int[] result = new int[3];
		int insertCnt=0;
		int mailSendCnt=0;
		int updateCnt=0;

		for(LateStatPoint p: list){
			//logger.debug(p.toString());
			if(p.getKlpLatePoint()==null){//지각점수 테이블에 데이터가 없을 경우 insert(최초등록)
				//logger.debug("insert");
				LatePoint lp = new LatePoint(p.getId(),p.getYear(),p.getShortLateSum(),p.getLongLateSum(),p.getOrgLatePoint(),p.getLatePoint());
				statMapper.insertLatePoint(lp);
				insertCnt += 1;
			}else{
				if(p.getLatePoint() > p.getKlpLatePoint()){//통계에의해 계산된 점수가 지각점수 테이블의 점수보다 크면 mail발송 and update
					User user = userMapper.getUserDetailById(String.valueOf(p.getId()));
					if("N".equals(user.getDashState())){//대시보드상태표시 N 이면 (파트너)메일발송 하지 않는다.
						//logger.debug("update");
						LatePoint lp = new LatePoint(p.getId(),p.getYear(),p.getShortLateSum(),p.getLongLateSum(),p.getOrgLatePoint(),p.getLatePoint());

						statMapper.updateLatePoint(lp);
						updateCnt += 1;
					}else{
						//logger.debug("mail발송 & update");
						//메일주소구성
						String [] sendTo = makeLateMailSendAddrs(user,lateDefaultAddress);

						LatePoint lp = new LatePoint(p.getId(),p.getYear(),p.getShortLateSum(),p.getLongLateSum(),p.getOrgLatePoint(),p.getLatePoint(),p.getKlpMailCount(),p.getKlpLastMailSendDt());
						emailTempleatService.setLatePointEmailTempleate(user,lp,content.getContent().replace("\n","<br/>"),sendTo);
						statMapper.updateLatePointWithMailSendDt(lp);

						mailSendCnt += 1;
					}

				}else{//점수가 같다면 update만
					//logger.debug("update");
					LatePoint lp = new LatePoint(p.getId(),p.getYear(),p.getShortLateSum(),p.getLongLateSum(),p.getOrgLatePoint(),p.getLatePoint());

					statMapper.updateLatePoint(lp);
					updateCnt += 1;
				}
			}
		}

		result[0]=insertCnt;
		result[1]=mailSendCnt;
		result[2]=updateCnt;
		return result;

	}



	/** 메일주소구성
	 * @param user
	 * @param lateDefaultAddr
	 * @return
	 */
	private String[] makeLateMailSendAddrs(User user, String[] lateDefaultAddress) {

		//부서메니져 Emails
		String[] managersEmail = userMapper.mailSendManagerListByDeptcd(user.getDeptCd());
		//수신자수 배열크기= 기본2(본인,지각점수관리자)+ 부서메니져수
		int arraySize=0;
		if(lateDefaultAddress != null && lateDefaultAddress.length>0){
			arraySize = 1+lateDefaultAddress.length+managersEmail.length;
		}else{
			arraySize = 1+managersEmail.length;
		}

		//메일발송자명단
		String[] sendTo = new String[arraySize];

		sendTo[0]=user.getEmail();
		for(int i=0;i<managersEmail.length;i++){
			//logger.debug(managersEmail[i]);
			sendTo[i+1]=managersEmail[i];
		}

		if(lateDefaultAddress != null && lateDefaultAddress.length>0){
			for( int i = 0; i< lateDefaultAddress.length; i++ ){
				sendTo[i+1+managersEmail.length]=lateDefaultAddress[i];
		    }
		}

		/* 테스트용
		for(int i=0;i<sendTo.length;i++){
			logger.debug("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%메일보내는주소:"+sendTo[i]);;
		}
		String[] sendTo2 = {"bbaga93@naver.com","bbaga93@gmail.com"};
		 */
		return sendTo;
	}



	/* (non-Javadoc)
	 * 매년 06-25, 10-25 미사용연차에대한 메일발송
	 * @see com.kspat.web.service.StatService#getAnnualEmailSendScoreList(com.kspat.web.domain.SearchParam)
	 */
	@Override
	public List<Score> getAnnualEmailSendScoreList(SearchParam searchParam) {
		return statMapper.getAnnualEmailSendScoreList(searchParam);
	}




}
