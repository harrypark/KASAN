package com.kspat.web.service.impl;

import java.util.HashMap;
import java.util.Map;












import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Service;

import com.kspat.web.domain.BusinessTrip;
import com.kspat.web.domain.HalfLeave;
import com.kspat.web.domain.LatePoint;
import com.kspat.web.domain.Leave;
import com.kspat.web.domain.Replace;
import com.kspat.web.domain.User;
import com.kspat.web.domain.Workout;
import com.kspat.web.mapper.EmailMapper;
import com.kspat.web.mapper.UserMapper;
import com.kspat.web.service.EmailService;
import com.kspat.web.service.EmailTempleatService;
import com.kspat.web.service.UserService;

@Service
@EnableAsync
public class EmailTempleatServiceImpl implements EmailTempleatService {

	private static final Logger logger = LoggerFactory.getLogger(EmailTempleatServiceImpl.class);
	@Autowired
	private EmailService emailService;

	@Autowired
	private UserService userService;

	@Autowired
	private UserMapper userMapper;

	@Autowired
	private EmailMapper emailMapper;

	@Value("#{sendMailInfo.address}")
    private String senderEmailAddress;

	DateTimeFormatter fmt_ymdhm = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm");


	/** devMail == (개발자메일주소.) */
	@Value("#{sendMailInfo.devMail}")
    private String devMail;

	/** The Test template. */
	@Value("#{sendMailInfo.test}")
    private String testMailForm;

	/** The 외근 template. */
	@Value("#{sendMailInfo.woMailForm}")
    private String woMailForm;

	/** The 출장 template. */
	@Value("#{sendMailInfo.btMailForm}")
    private String btMailForm;

	/** The 휴가 template. */
	@Value("#{sendMailInfo.leaveMailForm}")
    private String leaveMailForm;

	/** The 반휴 template. */
	@Value("#{sendMailInfo.hlMailForm}")
    private String hlMailForm;

	/** The 대체근무 template. */
	@Value("#{sendMailInfo.replaceMailForm}")
    private String replaceMailForm;


	/** Caps Raw Data template. */
	@Value("#{sendMailInfo.rowDataMailForm}")
    private String rowDataMailForm;

	/** Late Point template. */
	@Value("#{sendMailInfo.latePointMailForm}")
    private String latePointMailForm;



	/*
	private String[] mailSendManagerListByDeptcd(String deptCd){
		String[] sendTo = {"bbaga93@daum.net"};
		if(!"dev".equals(sendToMail)){
			sendTo = userMapper.mailSendManagerListByDeptcd(deptCd);
		}
		return sendTo;
	}
	*/
	private String[] mailSendUserList(String deptCd){
		String[] sendTo = null ;
		//메일발송 type 가져오기
		String sendType = emailMapper.getMailSendType();
		logger.debug("mail send Type : {}",sendType);

		if("A".equals(sendType)){//발송하지 않음

		}else if("B".equals(sendType)){//개발자에게만 발송
			sendTo = new String[] {devMail};
		}else if("C".equals(sendType)){//매니져발송
			sendTo = userMapper.mailSendManagerListByDeptcd(deptCd);
		}else if("D".equals(sendType)){//매니져 + 관리부서
			sendTo = userMapper.mailSendManagerDeptListByDeptcd(deptCd);
		}else if("E".equals(sendType)){//전체발송
			sendTo = userMapper.mailSendAllUserList();

		}else{//기타

		}

		return sendTo;
	}

	/* 외근 메일템플릿
	 * (non-Javadoc)
	 * @see com.kspat.web.service.EmailTempleatService#setWoekoutEmailTempleate(com.kspat.web.domain.Workout, java.lang.String)
	 */
	@Override
	public void setWoekoutEmailTempleate(Workout wo,String gubun, String deptCd) {
		DateTime dateTime = new DateTime();
		String[] sendTo = mailSendUserList(deptCd);
		/*
		logger.debug("===>sendTo:{}",sendTo.length);
		for(int i=0; i<sendTo.length;i++){
			logger.debug("===>sendTo:{}",sendTo[i]);
		}
		*/
		if(sendTo != null){
			User user = userService.getUserDetailById(wo.getCrtdId());
			String subject = mailSubject("외근",gubun) + user.getCapsName();

			Map<String, String> params = new HashMap<String,String>();
			params.put("title", mailSubject("외근",gubun));
			params.put("gubun", gubun);
			params.put("name", user.getCapsName());
			params.put("deptNm", user.getDeptName());
			params.put("outDt", wo.getOutDt());
			params.put("startTm", wo.getStartTm());
			params.put("endTm", wo.getEndTm());
			params.put("hereGoYn", wo.getHereGoYn());
			params.put("hereOutYn", wo.getHereOutYn());
			params.put("destination", wo.getDestination());
			params.put("today", dateTime.toString(fmt_ymdhm));

			emailService.sendMail(woMailForm, params, subject, sendTo);
		}
	}

	private String mailSubject(String appName,String gubun){
		String subject = null;
		if("regist".equals(gubun)){
			subject = "["+appName+"등록] ";
		}else{
			subject = "["+appName+"삭제] ";
		}

		return subject;
	}

	/* 출장 메일 템플릿
	 * (non-Javadoc)
	 * @see com.kspat.web.service.EmailTempleatService#setBusinessTripEmailTempleate(com.kspat.web.domain.BusinessTrip, java.lang.String, java.lang.String)
	 */
	@Override
	public void setBusinessTripEmailTempleate(BusinessTrip businessTrip,
			String gubun, String deptCd) {
		DateTime dateTime = new DateTime();
		String[] sendTo = mailSendUserList(deptCd);

		if(sendTo != null){
			User user = userService.getUserDetailById(businessTrip.getCrtdId());
			String subject = mailSubject("출장",gubun) + user.getCapsName();

			Map<String, String> params = new HashMap<String,String>();
			params.put("title", mailSubject("출장",gubun));
			params.put("gubun", gubun);
			params.put("name", user.getCapsName());
			params.put("deptNm", user.getDeptName());
			//params.put("tripRange", businessTrip.getTripRange());
			params.put("tripRange", businessTrip.getStartDt()+"~"+businessTrip.getEndDt());
			params.put("destination", businessTrip.getDestination());
			params.put("today", dateTime.toString(fmt_ymdhm));

			emailService.sendMail(btMailForm, params, subject, sendTo);
		}

	}

	/* 휴가 메일 템플릿
	 * (non-Javadoc)
	 * @see com.kspat.web.service.EmailTempleatService#setLeaveEmailTempleate(com.kspat.web.domain.Leave, java.lang.String, java.lang.String)
	 */
	@Override
	public void setLeaveEmailTempleate(Leave leave, String gubun, String deptCd) {
		DateTime dateTime = new DateTime();
		String[] sendTo = mailSendUserList(deptCd);

		if(sendTo != null){
			User user = userService.getUserDetailById(leave.getCrtdId());
			String subject = mailSubject("휴가",gubun) + user.getCapsName();

			Map<String, String> params = new HashMap<String,String>();
			params.put("title", mailSubject("휴가",gubun));
			params.put("gubun", gubun);
			params.put("name", user.getCapsName());
			params.put("deptNm", user.getDeptName());

			if("regist".equals(gubun)){
				params.put("leaveRange", leave.getStartDt()+"~"+leave.getEndDt());
			}else{
				params.put("leaveRange", leave.getLeDt());
			}
			params.put("offcial", leave.getOffcial());
			params.put("memo", leave.getMemo());
			params.put("today", dateTime.toString(fmt_ymdhm));

			emailService.sendMail(leaveMailForm, params, subject, sendTo);
		}
	}

	@Override
	public void setHalfLeaveEmailTempleate(HalfLeave hl, String gubun,
			String deptCd) {
		DateTime dateTime = new DateTime();
		String[] sendTo = mailSendUserList(deptCd);

		if(sendTo != null){
			User user = userService.getUserDetailById(hl.getCrtdId());
			String subject = mailSubject("반휴",gubun) + user.getCapsName();

			Map<String, String> params = new HashMap<String,String>();
			params.put("title", mailSubject("반휴",gubun));
			params.put("gubun", gubun);
			params.put("name", user.getCapsName());
			params.put("deptNm", user.getDeptName());
			params.put("hlDt", hl.getHlDt());
			params.put("offcial", hl.getOffcial());
			params.put("memo", hl.getMemo());
			params.put("today", dateTime.toString(fmt_ymdhm));

			emailService.sendMail(hlMailForm, params, subject, sendTo);
		}

	}

	/* 대체근무
	 * (non-Javadoc)
	 * @see com.kspat.web.service.EmailTempleatService#setReplaceEmailTempleate(com.kspat.web.domain.Replace, java.lang.String, java.lang.String)
	 */
	@Override
	public void setReplaceEmailTempleate(Replace replace, String gubun,
			String deptCd) {
		DateTime dateTime = new DateTime();
		String[] sendTo = mailSendUserList(deptCd);

		if(sendTo != null){
			User user = userService.getUserDetailById(replace.getCrtdId());
			String subject = mailSubject("대체근무",gubun) + user.getCapsName();

			Map<String, String> params = new HashMap<String,String>();
			params.put("title", mailSubject("대체근무",gubun));
			params.put("gubun", gubun);
			params.put("name", user.getCapsName());
			params.put("deptNm", user.getDeptName());
			params.put("replDt", replace.getReplDt());
			params.put("time", replace.getReplStartTm() + " ~ " + replace.getReplEndTm());
			params.put("suppleDt", replace.getSuppleDt());
			params.put("today", dateTime.toString(fmt_ymdhm));

			emailService.sendMail(replaceMailForm, params, subject, sendTo);
		}

	}



	/* (non-Javadoc)
	 * RawData 체크
	 * @see com.kspat.web.service.EmailTempleatService#setRawDataEmailTempleate(java.lang.String)
	 */
	@Override
	public void setRawDataEmailTempleate(String toDate) {
		DateTime dateTime = new DateTime();
		String[] sendTo = userMapper.getAdminEmailAddress();
		logger.debug("sendTo Length:"+sendTo.length);

		DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyyMMddHHmmss");
		DateTime to_dateTime = formatter.parseDateTime(toDate);

		if(sendTo.length>0){

			String subject = "[가산] Caps MSSql Raw Data 확인 요망";

			Map<String, String> params = new HashMap<String,String>();
			params.put("toDate", to_dateTime.toString(fmt_ymdhm));
			params.put("today", dateTime.toString(fmt_ymdhm));

			//if(!"test".equals(mode))
			emailService.sendMail(rowDataMailForm, params, subject, sendTo);
		}


	}


	@Override
	public void setLatePointEmailTempleate(User user, LatePoint lp,	String content, String[] sendTo) {
		DateTime dateTime = new DateTime();
		//제목
		String subject = "[근태관련안내] 지각 관련 확인 요청의 건 (대상자:"+user.getCapsName()+")";
		// 메일내용
		Map<String, String> params = new HashMap<String,String>();
		params.put("title", subject);
		params.put("name", user.getCapsName());
		params.put("deptNm", user.getDeptName());
		params.put("year", lp.getYear());
		params.put("shortLate", String.valueOf(lp.getShortLate()));
		params.put("longLate", String.valueOf(lp.getLongLate()));
		//params.put("latePoint", String.valueOf(lp.getOrgLateueOf(Point()));
		params.put("content", content);
		params.put("lastMailSendDt", lp.getLastMailSendDt());
		//params.put("mailCount", String.valueOf(lp.getMailCount()+1));
		params.put("mailCount", String.valueOf(lp.getLatePoint()));
		params.put("content", content);
		params.put("today", dateTime.toString(fmt_ymdhm));

		//logger.debug("메일내용(params):"+params.toString());

		emailService.sendMail(latePointMailForm, params, subject, sendTo);

	}



}
