package com.kspat.web.service.impl;

import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import com.kspat.template.TemplateBuilder;
import com.kspat.web.domain.MailContent;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.mapper.EmailMapper;
import com.kspat.web.service.EmailService;
@Service
public class EmailServiceImpl implements EmailService{
	private static final Logger logger = LoggerFactory.getLogger(EmailServiceImpl.class);

	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	private EmailMapper emailMapper;

	@Autowired
	private TemplateBuilder templateBuilder;

	@Value("#{sendMailInfo.address}")
    private String senderEmailAddress;

	@Value("#{sendMailInfo.operate}") //운영중 true -> mail발송
	private Boolean operate;

	@Async
	public void sendMail(String template, Map<String, String> params, String subject,  String email) {
		MimeMessage msg = mailSender.createMimeMessage();
		try {
		    MimeMessageHelper helper = new MimeMessageHelper(msg, true, "UTF-8");
		    helper.setSubject(subject);
		    helper.setTo(email);
		    helper.setFrom(senderEmailAddress);
		    String mailText = templateBuilder.merge(template, params);
//		    logger.debug("==========================================================================");
//		    logger.debug(mailText);
//		    logger.debug("==========================================================================");

		    helper.setText(mailText, true);

		    if(operate) {
		    	mailSender.send(msg);
		    }
		} catch (MessagingException e) {
		    e.printStackTrace();
		    logger.info("error occurred during send email @@@@Message : "+ e);
		}
	}

	@Async
	public void sendMail(String template,Map<String, String> params, String subject, String[] sendTo) {
		MimeMessage msg = mailSender.createMimeMessage();
		try {
		    MimeMessageHelper helper = new MimeMessageHelper(msg, true, "UTF-8");
		    helper.setSubject(subject);
		    helper.setTo(sendTo);
		    helper.setFrom(senderEmailAddress);
		    String mailText = templateBuilder.merge(template, params);
		    //logger.debug("==========================================================================");
		    //logger.debug(mailText);
		    //logger.debug("==========================================================================");

		    helper.setText(mailText, true);
		    if(operate) {
		    	mailSender.send(msg);
		    }


		} catch (MessagingException e) {
		    e.printStackTrace();
		    logger.info("error occurred during send email @@@@Message : "+ e);
		}

	}

	@Override
	public String getMailSendType() {
		return emailMapper.getMailSendType();
	}

	@Override
	public void updateMailSendType(String sendType) {
		emailMapper.updateMailSendType(sendType);

	}

	@Override
	public List<MailContent> getMailContentList(SearchParam searchParam) {
		return emailMapper.getMailContentList(searchParam);
	}

	@Override
	public MailContent insertMailContent(MailContent content) {
		emailMapper.insertMailContent(content);
		return emailMapper.getMailContentDetail(content);
	}

	@Override
	public MailContent getMailContentDetail(MailContent mailContent) {
		return emailMapper.getMailContentDetail(mailContent);
	}

	@Override
	public MailContent updateMailContent(MailContent mailContent) {
		emailMapper.updateMailContent(mailContent);
		return emailMapper.getMailContentDetail(mailContent);
	}

	@Override
	public String getMailDefault() {
		return emailMapper.getLateMailDefault();
	}

	@Override
	public void updateMailDefault(String lateDefaultAddr) {
		emailMapper.updateLateMailDefault(lateDefaultAddr);
	}
}
