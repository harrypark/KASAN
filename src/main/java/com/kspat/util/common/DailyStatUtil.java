package com.kspat.util.common;

import java.util.List;

import org.joda.time.DateTime;
import org.joda.time.Minutes;
import org.slf4j.LoggerFactory;

import ch.qos.logback.classic.Logger;

import com.kspat.web.domain.DailyRule;
import com.kspat.web.domain.DayInfo;
import com.kspat.web.domain.Replace;
import com.kspat.web.domain.UserState;
import com.kspat.web.domain.Workout;

public class DailyStatUtil {
	private static final Logger logger = (Logger) LoggerFactory.getLogger(DailyStatUtil.class);

	/** 검색 날짜  user별 RawData의 근태 기록을 바탕으로 DashBoard
	 *  출근시간, 퇴근예정시간, 근무해야할시간, 지각기준시간을 구한다.
	 *  출근시간과 당일 이벤트를 근거로 현재 사무실 재실여부를 판단한다.
	 * @param list : user  Raw Data list
	 * @param searchParam : 검색 조건
	 */
	public static final List<UserState> getNowWorking(List<UserState> list, String calDt,DayInfo dayInfo,DailyRule dailyRule) {
		//logger.debug("==>dayInfo:{}",dayInfo.toString());

		for(UserState us:list){
			int workTime = 9*60;//근무시간 9시간 적용 기본세팅(분으로 540분)
			us.setWorkTmMin(workTime);
			//지각 기준시간 기본세팅
			us.setLateTm(calDt + " " + dailyRule.getGoEndTm());
			//if(us.getId()==5){//user id :2
				//logger.debug("=====================>"+us.getCalHereGo());

				if("Y".equals(dayInfo.getIsHoliday())){
					//logger.debug("======[1].휴일일경우 시작 =====================");
					us.setWorkTmMin(0);
					//출장이 있을 경우
					if(us.getBtrip() != null){
						//logger.debug("======[1-1].휴일 - 출장일 경우 시작 =====================");
						us.setCalHereGo(calDt+ " 09:00");
						us.setExpHereOut(calDt+ " 18:00");
						us.setHereOut(calDt+ " 18:00");
						us.setWorkTmMin(60*9);
						us.setInOffice(false);
						//logger.debug(us.toString());
						//logger.debug("======[1-1].휴일 - 출장일 경우 끝 =====================");

					}

					// 일통계에서 대체근무시간 계산
					if(us.getSupple()!=null && us.getSupple().size()>0){//채우는날
						//채우는날 이라면 List에서 term 근무시간 계산
						workTime=0;
						for(Replace su: us.getSupple()){
							workTime = workTime + su.getTerm();
						}
						us.setWorkTmMin(workTime);

						//외근이 있다면 현지 출근시간 체크
						if(us.getWorkout() != null && us.getWorkout().size()>0){
							//logger.debug("#휴일 외근 현출 체크=====================>workout");
							for(Workout wo: us.getWorkout()){
								if("Y".equals(wo.getHereGoYn())){//외근 현지 출근 이면 출근시간변경
									us.setCalHereGo(wo.getOutDt() + " " + wo.getStartTm());
								}
							}
						}//dashboard는 출근시간까지만 현지 퇴근은 일병통게에서 체크

						if(us.getCalHereGo() != null){//출근 기록이 있으면 퇴근예상시간 계산
							us.setExpHereOut(DateTimeUtil.getExpectedHereOutTime(us.getCalHereGo(),workTime));
						}

					}

					us.setInOffice(checkInoffice(us));
					//logger.debug(us.toString());
					//logger.debug("======[1].휴일일경우 끝 =====================");
				}else if(us.getBtrip() != null){
					//logger.debug("======[2].출장의 경우 시작 =====================");
					us.setCalHereGo(calDt+ " 09:00");
					us.setExpHereOut(calDt+ " 18:00");
					us.setHereOut(calDt+ " 18:00");
					us.setInOffice(false);
					//logger.debug(us.toString());
					//logger.debug("======[2].출장의 경우 끝 =====================");
				}else if(us.getLeave() != null){
					//logger.debug("======[3].휴가의 경우 시작 =====================");
					//근무시간 0
					us.setWorkTmMin(0);
					us.setInOffice(false);
					//logger.debug(us.toString());
					//logger.debug("======[3].휴가의 경우 끝 =====================");
				}else if(us.getHlLeave() != null){
					logger.info("======[4].반휴의 경우 시작 =====================");
					workTime = 4*60;//반휴근무시간
					us.setWorkTmMin(workTime);

					//반휴에 채우는날 근무시간 4시간+채우는 시간의 합. 2016-12-20 채변리사님요구사항
					//반휴 지각체크는 없음(채우는날 있어도)
					if(us.getSupple() !=null && us.getSupple().size()>0){
						//logger.debug("#채우는날=====================>supple");
						for(Replace su : us.getSupple()){
							us.setWorkTmMin(us.getWorkTmMin()+su.getTerm());//대체근무 신청시간 만큼 근무시간 플러스
						}
					}

					//외근이 있다면 현지 출근시간 체크
					if(us.getWorkout() != null && us.getWorkout().size()>0){
						//logger.debug("#반휴외근 현출 체크=====================>workout");
						for(Workout wo: us.getWorkout()){
							if("Y".equals(wo.getHereGoYn())){//외근 현지 출근 이면 출근시간변경
								us.setCalHereGo(wo.getOutDt() + " " + wo.getStartTm());
							}
							if("Y".equals(wo.getHereOutYn())){//외근 현지퇴근 이면 퇴근시간변경
								us.setCalHereOut(wo.getOutDt() + " " + wo.getEndTm());
							}

						}
					}//dashboard는 출근시간까지만 현지 퇴근은 일병통계에서 체크


					if(us.getCalHereGo() != null){//출근 기록이 있으면 퇴근예상시간 계산
						//여기 - 반휴퇴근예상시간계산
						//us.setExpHereOut(DateTimeUtil.getExpectedHereOutTime(us.getCalHereGo(),us.getWorkTmMin()));
						logger.info("======[4].반휴 퇴근예상시간계산 =====================");
						logger.info("us.getCalHereGo():"+us.getCalHereGo());
						logger.info("us.getWorkTmMin():"+us.getWorkTmMin());
						us.setExpHereOut(DateTimeUtil.getExpectedHereOutTimeStandardTime(us.getCalHereGo(),us.getWorkTmMin()));
					}

					//대체근무가 있다면
					if(us.getRepl() !=null ){
						//logger.debug("#반휴 대체근무 체크=====================>repl");
						Replace re = us.getRepl();

						us.setWorkTmMin(us.getWorkTmMin()-re.getTerm());//대체근무 신청시간 만큼 근무시간 마이너스
						/* 이미 점심시간은 신청받을때 빼고 있음.
						if("Y".equals(re.getInLunch())){
							//점심시간 포함이라면 근무시간에서 60분 추가 마이너스
							us.setWorkTmMin(us.getWorkTmMin()-re.getTerm()-60);//대체근무 신청시간 만큼 근무시간 마이너스
						}else{
							us.setWorkTmMin(us.getWorkTmMin()-re.getTerm());//대체근무 신청시간 만큼 근무시간 마이너스
						}
						*/

					}
					/*
					if(us.getCalHereGo() != null){//출근 기록이 있으면 퇴근예상시간 계산
						us.setExpHereOut(DateTimeUtil.getExpectedHereOutTime(us.getCalHereGo(),us.getWorkTmMin()));
					}
					*/
					us.setInOffice(checkInoffice(us));
					//logger.debug("======[4].반휴의 경우 끝 =====================");
				}else{
					//일반적인경우 시작
					//외근이 있다면
					if(us.getWorkout() != null && us.getWorkout().size()>0){
						//logger.debug("#3=====================>workout");
						//외근출근시간
						for(Workout wo: us.getWorkout()){
							if("Y".equals(wo.getHereGoYn())){//외근 현지 출근 이면 출근시간변경
								us.setCalHereGo(wo.getOutDt() + " " + wo.getStartTm());
							}
							if("Y".equals(wo.getHereOutYn())){//외근 현지퇴근 이면 퇴근시간변경
								us.setCalHereOut(wo.getOutDt() + " " + wo.getEndTm());
							}
						}
						//외근근무시간은 9시간 기본
					}
					//채우는날 2건신청가능
					if(us.getSupple() !=null && us.getSupple().size()>0){
						//logger.debug("#채우는날=====================>supple");
						for(Replace su : us.getSupple()){
							us.setWorkTmMin(us.getWorkTmMin()+su.getTerm());//대체근무 신청시간 만큼 근무시간 플러스
						}
					}
					if(us.getRepl() != null ){
						//빠지는날 여러건 4시간까지 나누어신청가능
						//logger.debug("#빠지는날=====================>replace");
						Replace re = us.getRepl();
						if("Y".equals(re.getInLunch())){
							//점심시간 포함이라면 근무시간에서 60분 추가 마이너스
							us.setWorkTmMin(us.getWorkTmMin()-re.getTerm()-60);//대체근무 신청시간 만큼 근무시간 마이너스
						}else{
							us.setWorkTmMin(us.getWorkTmMin()-re.getTerm()-60);//대체근무 신청시간 만큼 근무시간 마이너스
						}


						//출근시간 체크
						if(computeReplaceGoHereTime(dailyRule,re.getReplDt(),re.getReplStartTm())){
							//logger.debug("latetm 1:"+us.getLateTm());
							us.setLateTm(re.getReplDt() + " " + re.getReplEndTm());
							//logger.debug("term:"+re.getTerm());
							//logger.debug("latetm 2:"+us.getLateTm());
						}

					}

					//퇴근예정시간계산
					if(us.getCalHereGo() != null){
						if(us.getRepl() != null) {
							//대체근무가 있을경우
							logger.info("======[5].반휴 퇴근예상시간계산 =====================");
							logger.info("us.getCalHereGo():"+us.getCalHereGo());
							logger.info("us.getWorkTmMin():"+us.getWorkTmMin());
							us.setExpHereOut(DateTimeUtil.getExpectedHereOutTimeStandardTime(us.getCalHereGo(),us.getWorkTmMin()));
						}else {
							us.setExpHereOut(DateTimeUtil.getExpectedHereOutTime(us.getCalHereGo(),us.getWorkTmMin()));
						}
						
						
						
						/*
						 * 대체근무시간이 퇴근시간 쪽으로 설정되있을경우 퇴근예상시간이 대체시작시간보다 크다면 대체 시작시간을 퇴근 예상시간으로 변경
						 */
						//if(us.getRepl() != null) {
							//Replace re = us.getRepl();
							//logger.debug("대체근무 시작시간:"+re.getReplStartTm());
							//logger.debug("퇴근예정시간:"+us.getExpHereOut());
							
							/*
							 * 대체근무가 있을 경우
							 * 퇴근 예상시간이 대체근무 시작 시간 이후, 종료시간 이전 일경우 퇴근 예정시간을 대체근무 시작시간으로 대체
							 * 20190827 대체근무 퇴근예상시간 변경으로 삭제
							 */
//							if(computeReplaceExpHereOutTime(re ,us.getExpHereOut())) {
//								us.setExpHereOut(re.getReplDt() +" "+re.getReplStartTm());
//							}
						//}
						
						
					}
					us.setInOffice(checkInoffice(us));
					//logger.debug(us.toString());

				}

			//}//user id :2
		}
		return list;
	}


	/*
	 * 대체근무가 있을 경우
	 * 퇴근 예상시간이 대체근무 시작 시간 이후, 종료시간 이전 일경우 퇴근 예정시간을 대체근무 시작시간으로 대체
	 */
	private static boolean computeReplaceExpHereOutTime(Replace re, String expHereOut) {
		boolean res=false;
		//logger.debug("******************************************************************");
		//대체 시작시간
		DateTime reStartDateTime = DateTimeUtil.parseStringToDatetime(re.getReplDt() + " " + re.getReplStartTm(),"yyyy-MM-dd HH:mm");
		//대체 종료시간
		DateTime reEndDateTime = DateTimeUtil.parseStringToDatetime(re.getReplDt() + " " + re.getReplEndTm(),"yyyy-MM-dd HH:mm");
		//계산된 퇴근예상시간
		DateTime orgExpHereOutDateTime = DateTimeUtil.parseStringToDatetime(expHereOut,"yyyy-MM-dd HH:mm");
		
		System.out.println("reStartDateTime:"+reStartDateTime);
		System.out.println("orgExpHereOutDateTime:"+orgExpHereOutDateTime);
		
		if(reStartDateTime.isBefore(orgExpHereOutDateTime) && orgExpHereOutDateTime.isBefore(reEndDateTime)){
			res=true;
			//logger.debug("예상퇴근시간이 중간에 걸린다.");
		}
		return res;
		
	}


	/** 재실체크
	 * @param us
	 * @return
	 */
	private static boolean checkInoffice(UserState us) {
		//logger.debug("+++++++++++++++ inOffice ");
		boolean res = false;
		boolean hereCheck = false;
		if(us.getCalHereGo() != null && us.getExpHereOut() != null){//출근, 퇴근에정시간 이고
			DateTime startDateTime = DateTimeUtil.parseStringToDatetime(us.getCalHereGo(),"yyyy-MM-dd HH:mm");
			DateTime endDateTime = DateTimeUtil.parseStringToDatetime(us.getExpHereOut(),"yyyy-MM-dd HH:mm");
			//System.out.println(startDateTime.isBeforeNow());
			//System.out.println(endDateTime.isAfterNow());

			if(startDateTime.isBeforeNow() == true && endDateTime.isAfterNow() == true){
				hereCheck=true;
			}else{
				return false;
			}
		}else{
			return false;
		}
		//logger.debug("======>hereCheck:"+hereCheck);

		//외근시간 체크
		boolean workoutCheck = false;
		if(us.getWorkout() !=null && us.getWorkout().size()>0){
			for(Workout wo: us.getWorkout()){
				//logger.debug("start:"+wo.getStartTm());
				//logger.debug("end:"+wo.getEndTm());
				//logger.debug("wo:"+wo.toString());

				DateTime startDateTime = DateTimeUtil.parseStringToDatetime(wo.getOutDt()+" "+wo.getStartTm(),"yyyy-MM-dd HH:mm");
				DateTime endDateTime = DateTimeUtil.parseStringToDatetime(wo.getOutDt()+" "+wo.getEndTm(),"yyyy-MM-dd HH:mm");
				System.out.println(startDateTime.isBeforeNow());
				System.out.println(endDateTime.isAfterNow());

				if(startDateTime.isBeforeNow() == true && endDateTime.isAfterNow() == true){
					workoutCheck=false;
				}else{
					workoutCheck=true;
					continue;
				}
			}
		}else{
			workoutCheck=true;
		}

		//빠지는날 시작종료 체크 추가
		boolean replCheck=false;
		if(us.getRepl() !=null){
			Replace repl = us.getRepl();
			DateTime startDateTime = DateTimeUtil.parseStringToDatetime(repl.getReplDt() + " " + repl.getReplStartTm(),"yyyy-MM-dd HH:mm");
			DateTime endDateTime = DateTimeUtil.parseStringToDatetime(repl.getReplDt() + " " +repl.getReplEndTm(),"yyyy-MM-dd HH:mm");
			//System.out.println(startDateTime.isBeforeNow());
			//System.out.println(endDateTime.isAfterNow());


			if(startDateTime.isBeforeNow() == true && endDateTime.isAfterNow() == true){
				return false;
			}else{
				replCheck=true;

			}
		}else{
			replCheck =true;
		}


		//logger.debug("======>hereCheck:"+hereCheck);
		//logger.debug("======>workoutCheck:"+workoutCheck);
		//logger.debug("======>replCheck:"+replCheck);


		if(hereCheck == true && workoutCheck == true && replCheck == true){
			res=true;
		}

		return res;
	}

	/** 대체근무신청일 시작시간이
	 *  출근가능시간에 걸리는지 체크
	 * @param dr
	 * @param replDt
	 * @param replStartTm
	 * @return
	 */
	private static boolean computeReplaceGoHereTime(DailyRule dr,String replDt, String replStartTm) {

		boolean res=false;
		//logger.debug("******************************************************************");
		DateTime startDateTime = DateTimeUtil.parseStringToDatetime(replDt + " " + dr.getGoStartTm(),"yyyy-MM-dd HH:mm");
		DateTime endDateTime = DateTimeUtil.parseStringToDatetime(replDt + " " + dr.getGoEndTm(),"yyyy-MM-dd HH:mm");
		DateTime replStartTime = DateTimeUtil.parseStringToDatetime(replDt+ " " + replStartTm,"yyyy-MM-dd HH:mm");
//		System.out.println("startDateTime:"+startDateTime);
//		System.out.println("endDateTime:"+endDateTime);
//		System.out.println("replStartTime:"+replStartTime);

		//System.out.println(startDateTime.isBefore(replStartTime) || startDateTime.isEqual(replStartTime));
		//System.out.println(endDateTime.isAfter(replStartTime) || endDateTime.isEqual(replStartTime));
		if((startDateTime.isBefore(replStartTime) || startDateTime.isEqual(replStartTime)) && (endDateTime.isAfter(replStartTime) || endDateTime.isEqual(replStartTime))){
			res=true;
		}
		//logger.debug("******************************************************************");

		return res;
	}


	/** 일별통계 기초계산
	 *
	 *  퇴근시간, 지각계산, 실제 근무시간 계산, 결근여부계산
	 * @param list
	 * @param calDt
	 * @param dayInfo
	 * @param dailyRule
	 * @return
	 */
	public static List<UserState> getDailyStat(List<UserState> list, String calDt,DayInfo dayInfo,DailyRule dailyRule) {
		logger.debug("=============  Daily Stat Start ===========");
		for(UserState us:list){
			//logger.debug(us.toString());
			us.setCalHereOut(us.getHereOut());
			if("Y".equals(dayInfo.getDataError())){
				/*
				 * 지각, 근무시감미달,결근 체크 없음 --> 연차차감없음 (출근 퇴근시간 없음)
				 * 휴가, 반휴에 대한 연차차감만 한다.
				 *
				 */

				//TODO 보상테이블삭제



			}else{
				if("Y".equals(dayInfo.getIsHoliday())){
					if(us.getBtrip() != null){
						//logger.debug(us.toString());
					}
					//3.근무시간미달계산
					//4.무단결근계산
					//출장이 있을 경우

					//1.퇴근시간계산
					if(us.getSupple()!=null && us.getSupple().size()>0){//채우는날
						//외근이 있다면 현지 퇴근시간 체크
						if(us.getWorkout() != null && us.getWorkout().size()>0){
							//logger.debug("#휴일 외근 현지퇴근 체크=====================>workout");
							for(Workout wo: us.getWorkout()){
								if("Y".equals(wo.getHereOutYn())){//외근 현지 퇴근 이면 퇴근시간변경
									us.setCalHereOut(wo.getOutDt() + " " + wo.getEndTm());
								}
							}
						}
					}

					//2.지각계산 - 휴일 없음
					//3.근무시간미달계산
					//계산된근무시간(분)
					us.setCalWorkTmMin(getCalWorkTime(us));

					//logger.debug("휴일:"+us.toString());
				}else if(us.getBtrip() != null){
					us.setCalWorkTmMin(getCalWorkTime(us));

				}else if(us.getLeave() != null){
					//게산된 근무시간도 0
					us.setCalWorkTmMin(0);
				}else if(us.getHlLeave() != null){

					//외근이 있다면 현지 퇴근시간 체크 - 실제퇴근시간으로 대입 (게산된 퇴근시간은 nowworking에서)
					if(us.getWorkout() != null && us.getWorkout().size()>0){
						//logger.debug("#휴일 외근 현지퇴근 체크=====================>workout");
						for(Workout wo: us.getWorkout()){
							if("Y".equals(wo.getHereOutYn())){//외근 현지 퇴근 이면 퇴근시간변경
								us.setHereOut(wo.getOutDt() + " " + wo.getEndTm());
								//20180829 외근 현지 퇴근일경우 퇴근시간을 현지 퇴근시간으로 지정 해야 퇴근시간이 찍혀 무단 결근이 방지된다.
								us.setCalHereOut(wo.getOutDt() + " " + wo.getEndTm());
							}
						}
					}
					us.setCalWorkTmMin(getCalWorkTime(us));

					if(us.getRepl() !=null ){
						//logger.debug("#반휴 대체근무 체크=====================>repl");
						Replace re = us.getRepl();
						//대체근무 신청시간이 4시간일경우 반휴시간과 일치 출근기록 없어도되고, 퇴근기록 없어도 인정
						if(re.getTerm()==60*4){
							//****결근아님****
							us.setCalWorkTmMin(0);
						}else{

						}

					}

				}else{
					//외근이 있다면 현지 퇴근시간 체크
					if(us.getWorkout() != null && us.getWorkout().size()>0){
						//logger.debug("#외근 현지퇴근 체크=====================>workout");
						for(Workout wo: us.getWorkout()){
							if("Y".equals(wo.getHereOutYn())){//외근 현지 퇴근 이면 퇴근시간변경
								us.setCalHereOut(wo.getOutDt() + " " + wo.getEndTm());
							}
						}
					}

					us.setCalWorkTmMin(getCalWorkTime(us));
					//logger.debug("**********CalWorkTmMin:"+us.getCalWorkTmMin());
					us = checkLateTime(us,dailyRule);
				}
				//지각에 대한 연차 차감계산
			}

			us.setDiffWorkTmMin(us.getCalWorkTmMin()-us.getWorkTmMin());
			us.setFailWorkTm(us.getDiffWorkTmMin()<0?"미달":"정상");

			//전체 연차 계산
		}
		logger.debug("============= Daily Stat End===========");
		return list;
	}

	/** 실제 근무시간 계산 (출근시간 - 퇴근시간) 분단위
	 * @param us
	 * @return
	 */
	private static final int getCalWorkTime(UserState us) {
		int calWorkMin = 0;
		if(us.getCalHereGo() != null && us.getCalHereOut() != null){
			DateTime goTime = DateTimeUtil.parseStringToDatetime(us.getCalHereGo(),"yyyy-MM-dd HH:mm");
			DateTime outTime = DateTimeUtil.parseStringToDatetime(us.getCalHereOut(),"yyyy-MM-dd HH:mm");
			calWorkMin = Minutes.minutesBetween(goTime, outTime).getMinutes();
		}else{
			//출퇴근기록이 없을경우 도 있을수있다.
			//이러한경우는 또 발생 할수 있음. 모든경우를 체크 할수는 없고, 생기면 그때 그때 반영 해야 함.

			//외근 이 있을경우 외근시간 만큼 근무시간으로 계산한다.
			if(us.getWorkout() != null && us.getWorkout().size()>0){
				for(Workout wo: us.getWorkout()){
					calWorkMin = calWorkMin + wo.getDiffm();
				}
			}


		}
		return calWorkMin;
	}

	/** 기준에 따른 지각계산 정상,단,장 {"normal","short","long"}
	 * @param us
	 * @param dailyRule
	 * @return
	 */
	private static final UserState checkLateTime(UserState us,DailyRule dailyRule){
		//(String lateTime, String calHereGoTime,  int longLate) {
			String res = null;
			String[] resString = {"normal","short","long"};
			if(us.getCalHereGo() != null && us.getLateTm() != null){
				DateTime calHereGoTm = DateTimeUtil.parseStringToDatetime(us.getCalHereGo(),"yyyy-MM-dd HH:mm");
				DateTime lateTm = DateTimeUtil.parseStringToDatetime(us.getLateTm(),"yyyy-MM-dd HH:mm");
				int diffMinutes = Minutes.minutesBetween(lateTm,calHereGoTm).getMinutes();
				us.setDiffLateMin(diffMinutes);
				//System.out.println(diffMinutes);
				if(diffMinutes>0 && diffMinutes <= dailyRule.getLongLateRule()){
					res=  resString[1];
				}else if(diffMinutes > dailyRule.getLongLateRule()){
					res =  resString[2];
				}else{
					res = resString[0];
				}
				us.setLate(res);
			}
			return us;

		}

}
