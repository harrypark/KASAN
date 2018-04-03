package com.kspat.web.mapper;

import java.util.List;

import com.kspat.web.domain.Reservation;
import com.kspat.web.domain.SearchParam;

public interface ReservationMapper {

	List<Reservation> getReservationList(SearchParam searchParam);

	Reservation getSeletDayTimeLimit(Reservation reservation);

	void insertReservation(Reservation reservation);

	Reservation getReservationById(int id);

	void updateReservation(Reservation reservation);

	int deleteReservation(Reservation reservation);

}
