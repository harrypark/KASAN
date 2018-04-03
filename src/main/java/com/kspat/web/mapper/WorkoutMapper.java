package com.kspat.web.mapper;

import java.util.List;

import com.kspat.web.domain.SearchParam;
import com.kspat.web.domain.Workout;

public interface WorkoutMapper {

	void insertWorkout(Workout workout);

	List<Workout> getUserWorkoutList(SearchParam searchParam);

	Workout getWorkoutDetailById(SearchParam searchParam);

	void updateWorkout(Workout workout);

	int deleteWorkout(Workout workout);

	Workout getWorkoutAvailableTime();

}
