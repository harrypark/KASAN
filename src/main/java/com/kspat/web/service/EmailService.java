package com.kspat.web.service;

import java.util.List;
import java.util.Map;

import com.kspat.web.domain.MailContent;
import com.kspat.web.domain.SearchParam;

public interface EmailService {

	public void sendMail(String template, Map<String, String> params, String subject,  String email);


	public void sendMail(String template, Map<String, String> params,String subject,  String[] sendTo);


	public String getMailSendType();


	public void updateMailSendType(String sendType);


	public List<MailContent> getMailContentList(SearchParam searchParam);


	public MailContent insertMailContent(MailContent content);


	public MailContent getMailContentDetail(MailContent mailContent);


	public MailContent updateMailContent(MailContent mailContent);


	public String getMailDefault();


	public void updateMailDefault(String lateDefaultAddr);
}
