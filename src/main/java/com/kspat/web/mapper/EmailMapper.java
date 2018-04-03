package com.kspat.web.mapper;

import java.util.List;

import com.kspat.web.domain.MailContent;
import com.kspat.web.domain.SearchParam;

public interface EmailMapper {

	String getMailSendType();

	void updateMailSendType(String sendType);

	List<MailContent> getMailContentList(SearchParam searchParam);

	void insertMailContent(MailContent content);

	MailContent getMailContentDetail(MailContent content);

	void updateMailContent(MailContent mailContent);

	String getLateMailDefault();

	void updateLateMailDefault(String lateDefaultAddr);

}
