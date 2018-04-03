package com.kspat.web.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kspat.web.domain.Reservation;
import com.kspat.web.domain.SearchParam;
import com.kspat.web.mapper.ReservationMapper;
import com.kspat.web.service.ReservationService;

@Service
public class ReservationServiceImpl implements ReservationService {

	@Autowired
	private ReservationMapper reservationMapper;

	@Override
	public List<Reservation> getReservationList(SearchParam searchParam) {
		return reservationMapper.getReservationList(searchParam);
	}

	@Override
	public Reservation getSeletDayTimeLimit(Reservation reservation) {
		return reservationMapper.getSeletDayTimeLimit(reservation);
	}

	@Override
	public Reservation insertReservation(Reservation reservation) {
		reservationMapper.insertReservation(reservation);
		Reservation res = reservationMapper.getReservationById(reservation.getId());
		return res;
	}

	@Override
	public Reservation updateReservation(Reservation reservation) {
		reservationMapper.updateReservation(reservation);
		Reservation res = reservationMapper.getReservationById(reservation.getId());
		return res;
	}

	@Override
	public int deleteReservation(Reservation reservation) {
		return reservationMapper.deleteReservation(reservation);
	}
}
