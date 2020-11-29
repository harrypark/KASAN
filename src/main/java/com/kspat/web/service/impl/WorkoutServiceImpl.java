package com.kspat.web.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kspat.web.domain.SearchParam;
import com.kspat.web.domain.Workout;
import com.kspat.web.mapper.WorkoutMapper;
import com.kspat.web.service.EmailTempleatService;
import com.kspat.web.service.WorkoutService;

@Service
public class WorkoutServiceImpl implements WorkoutService {

	@Autowired
	private WorkoutMapper workoutMapper;

	@Autowired
	private EmailTempleatService emailTempleatService;

	@Override
	public Workout insertWorkout(Workout workout) {
		workoutMapper.insertWorkout(workout);

		SearchParam searchParam = new SearchParam(workout.getId());
		Workout wo = workoutMapper.getWorkoutDetailById(searchParam);

		//외근등록정보를 부서 매니져에게 메일발송
		emailTempleatService.setWoekoutEmailTempleate(workout, "regist",workout.getDeptCd());

		return wo;
	}

	@Override
	public List<Workout> getUserWorkoutList(SearchParam searchParam) {
		return workoutMapper.getUserWorkoutList(searchParam);
	}

	@Override
	public Workout getWorkoutDetailById(SearchParam searchParam) {
		return workoutMapper.getWorkoutDetailById(searchParam);
	}

	@Override
	public Workout updateWorkout(Workout workout) {
		workoutMapper.updateWorkout(workout);

		SearchParam searchParam = new SearchParam(workout.getId());
		Workout wo = workoutMapper.getWorkoutDetailById(searchParam);
		return wo;
	}

	@Override
	public int deleteWorkout(Workout workout) {
		SearchParam searchParam = new SearchParam(workout.getId());
		Workout wo = workoutMapper.getWorkoutDetailById(searchParam);
		wo.setCrtdId(workout.getCrtdId());

		int res = workoutMapper.deleteWorkout(workout);
		//외근t삭제정보를 부서 매니져에게 메일발송
		emailTempleatService.setWoekoutEmailTempleate(wo, "delete",workout.getDeptCd());

		return res;
	}

	@Override
	public Workout getWorkoutAvailableTime() {
		return workoutMapper.getWorkoutAvailableTime();
	}


}
