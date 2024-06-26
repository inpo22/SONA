package com.sona.music.alarm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sona.music.alarm.dto.AlarmDTO;

public interface AlarmDAO {

	List<AlarmDTO> alarmList(int cnt, int start, String user_id);

	
	@Mapper
	Object alarmListAllCount(@Param("cnt") int cnt, @Param("user_id") String user_id);


	int del(String idx);


	int alarmViews(String idx);


	AlarmDTO alarmDetail(int idx);


	void alarmViews(int idx);


	int detailDel(int alarm_idx);




}
