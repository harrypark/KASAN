package com.kspat.web.domain;

import lombok.Data;

@Data
public class MailContent extends BaseDomain{


	private int id;
	private String type;
	private String content;


	public MailContent(int searchId) {
		this.id= searchId;
	}


	public MailContent() {
		// TODO Auto-generated constructor stub
	}
}
