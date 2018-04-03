package com.kspat.web.service;

import java.util.List;

import com.kspat.web.domain.BusinessTrip;
import com.kspat.web.domain.SearchParam;

public interface BusinessTripService {

	BusinessTrip insertBusinessTrip(BusinessTrip businessTrip);

	List<BusinessTrip> getUserBusinessTripList(SearchParam searchParam);

	BusinessTrip getBusinessTripDetailById(SearchParam searchParam);

	BusinessTrip updateBusinessTrip(BusinessTrip businessTrip);

	int deleteBusinessTrip(BusinessTrip businessTrip);

}
