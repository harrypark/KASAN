package com.kspat.web.service;

import java.util.List;

import com.kspat.web.domain.Reservation;
import com.kspat.web.domain.SearchParam;

public interface ReservationService {

	List<Reservation> getReservationList(SearchParam searchParam);

	Reservation getSeletDayTimeLimit(Reservation reservation);

	Reservation insertReservation(Reservation reservation);

	Reservation updateReservation(Reservation reservation);

	int deleteReservation(Reservation reservation);

}
