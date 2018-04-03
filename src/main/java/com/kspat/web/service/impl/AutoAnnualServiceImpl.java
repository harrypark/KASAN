package com.kspat.web.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.joda.time.DateTime;
import org.joda.time.Days;
import org.joda.time.Months;
import org.joda.time.format.DateTimeFormatter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kspat.util.AutoAnnualUtil;
import com.kspat.web.domain.AutoAnnual;
import com.kspat.web.domain.ComPenAnnual;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.mapper.AutoAnnualMapper;
import com.kspat.web.service.AutoAnnualService;

@Service
public class AutoAnnualServiceImpl implements AutoAnnualService {
	private static DateTimeFormatter fmt = org.joda.time.format.DateTimeFormat.forPattern("yyyy-MM-dd");
	private static DateTimeFormatter fmt_yyyy = org.joda.time.format.DateTimeFormat.forPattern("yyyy");
	private static DateTimeFormatter fmt_MM_dd = org.joda.time.format.DateTimeFormat.forPattern("MM-dd");

	@Autowired
	private AutoAnnualMapper autoAnnualMapper;

	@Override
	public List<AutoAnnual> manualCreateAutoAnnual(SearchParam searchParam) {

		List<AutoAnnual> list = autoAnnualMapper.getUserHeirDtList(searchParam);
		List<AutoAnnual> newList = new ArrayList<AutoAnnual>();
		//연차 update
		if(list !=null){
			for(AutoAnnual aa : list){
				AutoAnnual na = getUserCurrentAnnual(aa, searchParam.getSearchDate());
				na.setCrtdId(searchParam.getCrtdId());
				na.setMdfyId(searchParam.getCrtdId());
				newList.add(na);
				//System.out.println(na.toString());
				autoAnnualMapper.deleteNowAnnual(na);
				autoAnnualMapper.upsertAutoAnnual(na);
				//System.out.println(aa.toString());
			}
		}
		return newList;
	}

	/** toDay 기준 연차 계산
	 * @param aa
	 * @param toDay
	 * @return
	 */
	private AutoAnnual getUserCurrentAnnual(AutoAnnual aa,String toDay) {

		DateTime hireDt = DateTime.parse(aa.getHireDt(), fmt);
		DateTime currDt = DateTime.parse(toDay, fmt);

		int hireYear = hireDt.getYear();
		int currYear = currDt.getYear();

		String term = null;
		double availAnnual= 0;//사용가능연차=자동계산연차(autoAnnual)+보정연차
		double autoAnnual = 0;//자동계산된연차
		String startDt=null, endDt=null;
		String type=null;

		//입사일이 1년이 안될때
		int realYear = AutoAnnualUtil.getRealYearDateTime(hireDt,currDt);//만 근무년
		int year = AutoAnnualUtil.getYear(String.valueOf(hireYear),String.valueOf(currYear));
		double [] BDAnnualArray = {0,0,15,15,16,16,17,17,18,18,19,19,20,20,21,21,22,22,23,23,24,24,25,25};

		if("before".equals(aa.getApplyDtType())){
//			System.out.println("before");
//			System.out.println("만 나이  계산(realYear):"+ realYear);
//			System.out.println("한국나이 계산(year):"+ year);
			if(hireYear == currYear){
//				System.out.println("C로직");
				type = "BC";
				//String tempYear = hireDt.plusYears(2).toString(fmt_yyyy);
				//System.out.println(hireDt.plusYears(2).toString(fmt));
				//System.out.println(DateTime.parse(tempYear+"-12-31", fmt).toString(fmt));
				DateTime yearLastDay = DateTime.parse(hireYear+"-12-31", fmt);
				int  termDay = Days.daysBetween(hireDt, yearLastDay).getDays();
//				System.out.println("termDay: "+ termDay);
				double annual = ((double)termDay*15)/365;
//				System.out.println("년차 d: "+ annual);
				double annual2 = Math.floor(annual);
				autoAnnual = (int) annual2;
				startDt = hireDt.toString(fmt);
				endDt = yearLastDay.toString(fmt);;
				term = startDt +" ~ "+ endDt;
//				System.out.println("		"+currDt.toString(fmt)+"		"+realYear+"		"+year+"		"+type+"("+termDay+")		"+availAnnual+"		"+term);
			}else{
				//System.out.println("만 3년이상");
				type = "BD";

				double annual=0;
				if(year < BDAnnualArray.length){
					annual = BDAnnualArray[year];
				}else{
					annual = 25;
				}


				if(annual > 25){
					annual =25;
				}
				//System.out.println("연차 :"+annual);
				String tempYear = currDt.toString(fmt_yyyy);
				//System.out.println();
				//System.out.println("기간:"+DateTime.parse(tempYear+"-01-01", fmt).toString(fmt) +" ~ "+ DateTime.parse(tempYear+"-12-31", fmt).toString(fmt));

				autoAnnual = annual;
				startDt = DateTime.parse(tempYear+"-01-01", fmt).toString(fmt);
				endDt = DateTime.parse(tempYear+"-12-31", fmt).toString(fmt);
				term = startDt +" ~ "+ endDt;
				//System.out.println("		"+currDt.toString(fmt)+"		"+realYear+"		"+year+"		"+type+"		"+availAnnual+"		"+term);
			}



		}else if("after".equals(aa.getApplyDtType())){
			//System.out.println("after");
			if(realYear < 1){
				type = "AA";
				autoAnnual = Months.monthsBetween(hireDt, currDt).getMonths();
				startDt = hireDt.toString(fmt);
				endDt = hireDt.plusMonths(12).minusDays(1).toString(fmt);
				term = startDt +" ~ "+ endDt;
//					System.out.println("만1년 미만");
//					System.out.println("년차:"+ ann);
//					System.out.println("기간:"+ term);
//					System.out.println("Day		CurrentDT		realYear		year		state		annual		term");
				//System.out.println("		"+currDt.toString(fmt)+"		"+realYear+"		"+year+"		"+type+"		"+availAnnual+"		"+term);

			}else if(realYear < 2){
				type = "AB";
				double usedAnnual = getTypeAAUsedAnnual(aa);
				//System.out.println("usedAnnual:"+usedAnnual);

				autoAnnual = 15-usedAnnual;
				startDt = hireDt.plusMonths(12).toString(fmt);
				endDt = hireDt.plusMonths(24).minusDays(1).toString(fmt);
				term = startDt +" ~ "+ endDt;

//					System.out.println("만2년 미만");
//					System.out.println("년차:"+ ann);
//					System.out.println("기간:"+term);
				//System.out.println("		"+currDt.toString(fmt)+"		"+realYear+"		"+year+"		"+type+"		"+availAnnual+"		"+term);

			}else{
				String hierDt_MM_DD = hireDt.toString(fmt_MM_dd);
				boolean dtCheck = "01-01".equals(hierDt_MM_DD);//만 2년을 딱 채웠나?

				if(year == 3 && dtCheck == false){
					type = "AC";
					String tempYear = hireDt.plusYears(2).toString(fmt_yyyy);
					//System.out.println(hireDt.plusYears(2).toString(fmt));
					//System.out.println(DateTime.parse(tempYear+"-12-31", fmt).toString(fmt));
					DateTime yearLastDay = DateTime.parse(tempYear+"-12-31", fmt);
					int  termDay = Days.daysBetween(hireDt.plusYears(2), yearLastDay).getDays();
					//System.out.println("termDay: "+ termDay);
					double annual = (termDay*15)/365;
					//System.out.println("년차 d: "+ annual);
					autoAnnual = Math.floor(annual);
					startDt = hireDt.plusMonths(24).toString(fmt);
					endDt = yearLastDay.toString(fmt);;
					term = startDt +" ~ "+ endDt;
					//System.out.println("		"+currDt.toString(fmt)+"		"+realYear+"		"+year+"		"+type+"("+termDay+")		"+availAnnual+"		"+term);
				}else{
					//System.out.println("만 3년이상");
					type = "AD";
					//term = hireDt.plusMonths(12).toString(fmt) +" ~ "+ hireDt.plusMonths(24).minusDays(1).toString(fmt);
					double annual = 15;
					annual  = annual + (year/2 -2) +1;

					if(annual > 25){
						annual =25;
					}
					//System.out.println("연차 :"+annual);
					String tempYear = currDt.toString(fmt_yyyy);
					//System.out.println();
					//System.out.println("기간:"+DateTime.parse(tempYear+"-01-01", fmt).toString(fmt) +" ~ "+ DateTime.parse(tempYear+"-12-31", fmt).toString(fmt));

					autoAnnual = annual;
					startDt = DateTime.parse(tempYear+"-01-01", fmt).toString(fmt);
					endDt = DateTime.parse(tempYear+"-12-31", fmt).toString(fmt);
					term = startDt +" ~ "+ endDt;
					//System.out.println("		"+currDt.toString(fmt)+"		"+realYear+"		"+year+"		"+type+"		"+availAnnual+"		"+term);
				}
			}
		}
		aa.setAutoAnnual(autoAnnual);
		aa.setType(type);
		aa.setStartDt(startDt);
		aa.setEndDt(endDt);
		aa.setYear(year);

		//연차 보정체크
		ComPenAnnual cpa =  getUserComPenAnnual(aa);

		//System.out.println("comAnnual :"+comAnnual + "/ "+aa.toString());
		aa.setComAnnual(cpa==null?0:cpa.getComAnnual());
		availAnnual = autoAnnual+aa.getComAnnual();

		aa.setAvailCount(availAnnual);
		return aa;

	}



	private double getTypeAAUsedAnnual(AutoAnnual aa) {

		String startDt = aa.getHireDt();
		aa.setStartDt(startDt);
		String endDt = DateTime.parse(aa.getHireDt(), fmt).plusMonths(12).minusDays(1).toString(fmt);
		aa.setEndDt(endDt);
		return autoAnnualMapper.getTypeAAUsedAnnual(aa);
	}

	@Override
	public List<AutoAnnual> getAutoAnnualList(SearchParam searchParam) {
		return autoAnnualMapper.getAutoAnnualList(searchParam);
	}

	@Override
	public ComPenAnnual getUserComPenAnnual(AutoAnnual autoAnnual) {
		ComPenAnnual cpa = autoAnnualMapper.getUserComPenAnnual(autoAnnual);
		if(cpa == null){
			cpa = new ComPenAnnual(autoAnnual.getId(),autoAnnual.getStartDt(),autoAnnual.getEndDt(),0);
		}

		return cpa;
	}

	@Override
	public AutoAnnual editComPenAnnual(ComPenAnnual cpa) {
		//연차보정
		autoAnnualMapper.upsertComPenAnnual(cpa);

		return calculateUserAutoAnnual(cpa);
	}

	private AutoAnnual calculateUserAutoAnnual(ComPenAnnual cpa) {
		AutoAnnual aa = new AutoAnnual();

		//해당 id 연차 다시 계산
		SearchParam searchParam = new SearchParam(cpa.getId(),cpa.getStartDt(),cpa.getEndDt());

		DateTime dateTime = new DateTime();
	    searchParam.setSearchDate(dateTime.toString(fmt));

		List<AutoAnnual> list = manualCreateAutoAnnual(searchParam);


		return autoAnnualMapper.getUserAutoAnnualDetail(searchParam);
	}


}
