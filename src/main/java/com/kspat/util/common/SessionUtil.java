package com.kspat.util.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.kspat.web.domain.SessionInfo;

public class SessionUtil {

	@SuppressWarnings("unused")
	public static final SessionInfo getSessionInfo(HttpServletRequest request){
		HttpSession session = request.getSession(false);

		SessionInfo info = new SessionInfo();
		info.setId((Integer) session.getAttribute("id"));
		info.setCapsId((String) session.getAttribute("capsId"));
		info.setCapsName((String) session.getAttribute("capsName"));
		info.setAuthCd((String) session.getAttribute("authCd"));
		info.setAuthName((String) session.getAttribute("authName"));
		info.setDeptCd((String) session.getAttribute("deptCd"));

		return info;
	}
}
