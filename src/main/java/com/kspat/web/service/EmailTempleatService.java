package com.kspat.web.service;

import com.kspat.web.domain.BusinessTrip;
import com.kspat.web.domain.HalfLeave;
import com.kspat.web.domain.LatePoint;
import com.kspat.web.domain.Leave;
import com.kspat.web.domain.Replace;
import com.kspat.web.domain.Score;
import com.kspat.web.domain.User;
import com.kspat.web.domain.Workout;

public interface EmailTempleatService {

	public void setWoekoutEmailTempleate(Workout wo, String gubun,	String deptCd);

	public void setBusinessTripEmailTempleate(BusinessTrip businessTrip,
			String gubun, String deptCd);

	public void setLeaveEmailTempleate(Leave leave, String gubun, String deptCd);

	public void setHalfLeaveEmailTempleate(HalfLeave hl, String gubun,
			String deptCd);

	public void setReplaceEmailTempleate(Replace replace, String gubun,
			String deptCd);

	public void setRawDataEmailTempleate(String toDate);

	public void setLatePointEmailTempleate(User user, LatePoint lp, String content, String[] sendTo);

	public void setRemainingAnnualEmailTempleate(Score score);

}
