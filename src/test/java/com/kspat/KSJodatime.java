package com.kspat;


import org.joda.time.DateTime;
import org.joda.time.Interval;
import org.joda.time.Minutes;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

public class KSJodatime {

	static DateTimeFormatter fmt_ymd = DateTimeFormat.forPattern("yyyy-MM-dd");
	static DateTimeFormatter fmt_ymd_hm = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm");

	public static void main(String[] args) {



		//worktime 계산
		int userWorkTime = getWorkTime("2016-09-13 07:30","2016-09-13 18:00");

		System.out.println("userWorkTime:"+userWorkTime);


		// 해당시간에 속하는지 (외근시간, 대체신청시간 등)
		boolean isContainTime = checkContainTime("2016-09-13 09:30","2016-09-13 09:50");
		System.out.println("현재 시간 isContainTime:"+isContainTime);

			isContainTime = checkContainTime("2016-09-13 09:30","2016-09-13 12:14","2016-09-13 10:00");
		System.out.println("지정 시간 isContainTime:"+isContainTime);

		//지각계산 기준시간, 출근시간,  , 장지각기준 normal, short, long
		String late = checkLateTime("2016-09-13 10:00","2016-09-13 10:35",30);

		System.out.println("지각:"+late);


	}








	private static String checkLateTime(String lateTime, String calHereGoTime,  int longLate) {
		String res = null;
		String[] resString = {"normal","short","long"};
		if(calHereGoTime != null && lateTime != null){
			DateTime calHereGoTm = fmt_ymd_hm.parseDateTime(calHereGoTime);
			DateTime lateTm = fmt_ymd_hm.parseDateTime(lateTime);
			int diffMinutes = Minutes.minutesBetween(lateTm,calHereGoTm).getMinutes();
			System.out.println(diffMinutes);
			if(diffMinutes>0 && diffMinutes <= longLate){
				res=  resString[1];
			}else if(diffMinutes > longLate){
				res =  resString[2];
			}else{
				res = resString[0];
			}
		}
		return res;

	}








	private static boolean checkContainTime(String start, String end) {
		boolean res = false;
		if(start != null && end != null){

			DateTime startTm = fmt_ymd_hm.parseDateTime(start);
			DateTime endTm = fmt_ymd_hm.parseDateTime(end);

			Interval interval = new Interval(startTm, endTm);

			DateTime testTm = new DateTime();

			res = interval.contains(testTm);

		}
		return res;
	}

	private static boolean checkContainTime(String start, String end, String test ) {
		boolean res = false;
		if(start != null && end != null){

			DateTime startTm = fmt_ymd_hm.parseDateTime(start);
			DateTime endTm = fmt_ymd_hm.parseDateTime(end);

			Interval interval = new Interval(startTm, endTm);

			DateTime testTm = fmt_ymd_hm.parseDateTime(test);;

			res = interval.contains(testTm);


		}
		return res;
	}









	/** 출근시간, 퇴근시간을 입력받아 당일 업무시간을 분으로 리턴
	 * @param go
	 * @param out
	 * @return int (minutes)
	 */
	private static int getWorkTime(String go, String out) {
		int workTime = 0;
		if(go != null && out != null){
			DateTime goTm = fmt_ymd_hm.parseDateTime(go);
			DateTime outTm = fmt_ymd_hm.parseDateTime(out);
			workTime = Minutes.minutesBetween(goTm, outTm).getMinutes();
		}
		return workTime;
	}





}
