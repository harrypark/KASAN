package com.kspat.web.mapper;

import java.util.List;

import com.kspat.web.domain.BusinessTrip;
import com.kspat.web.domain.SearchParam;

public interface BusinessTripMapper {

	void insertBusinessTrip(BusinessTrip businessTrip);

	BusinessTrip getBusinessTripDetailById(SearchParam searchParam);

	List<BusinessTrip> getUserBusinessTripList(SearchParam searchParam);

	void updateBusinessTrip(BusinessTrip businessTrip);

	int deleteBusinessTrip(BusinessTrip businessTrip);

}
