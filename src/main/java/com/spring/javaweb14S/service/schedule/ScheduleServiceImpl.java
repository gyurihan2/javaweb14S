package com.spring.javaweb14S.service.schedule;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb14S.dao.ScheduleDAO;
import com.spring.javaweb14S.vo.SchduleVO;

@Service
public class ScheduleServiceImpl implements ScheduleService{
	@Autowired
	ScheduleDAO scheduleDAO;

	@Override
	public String getScheduleList(String requestDate) {
		ArrayList<SchduleVO> vos =  scheduleDAO.getSchduleList(requestDate);
		if(vos.size() != 0) {
			System.out.println("하하하");
		}
		else {
			System.out.println("없어");
		}
		return null;
		
	}
	
	
}
