package com.kspat.web.domain;

import java.sql.Date;


public class Documents {

	private int document_srl;
	private String title;
	private String content;
	private String user_id;
	private String nick_name;
	private String email_address;
	private Date regdate;
	public int getDocument_srl() {
		return document_srl;
	}
	public void setDocument_srl(int document_srl) {
		this.document_srl = document_srl;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getNick_name() {
		return nick_name;
	}
	public void setNick_name(String nick_name) {
		this.nick_name = nick_name;
	}
	public String getEmail_address() {
		return email_address;
	}
	public void setEmail_address(String email_address) {
		this.email_address = email_address;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	@Override
	public String toString() {
		return "Documents [document_srl=" + document_srl + ", title=" + title
				+ ", content=" + content + ", user_id=" + user_id
				+ ", nick_name=" + nick_name + ", email_address="
				+ email_address + ", regdate=" + regdate + "]";
	}



}
