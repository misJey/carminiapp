package com.pingan.carminiapp.service.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.pingan.carminiapp.dao.AppointmentRepository;
import com.pingan.carminiapp.domain.Appointment;
import com.pingan.carminiapp.service.face.AppointmentService;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年8月8日 上午10:30:01
 * @version 1.0
 * @since JDK1.8
 * @Description (这里用一句话描述这个类的作用)
 */
@Service
public class AppointmentServiceImpl implements AppointmentService {
	private static final Logger log = LoggerFactory.getLogger(AppointmentServiceImpl.class);
	
	@Autowired
	AppointmentRepository appointmentRepository;
	
	@Override
	public List<Appointment> getAllCardealer(int pageNow, int pageSize, String fuzzy) {
		List<Appointment> allAppointment = null;
		Pageable pageable = PageRequest.of(pageNow, pageSize);
		if(StringUtils.isEmpty(fuzzy)){
	        allAppointment = appointmentRepository.findAll(pageable).getContent();
		}else {
			//分页模糊查询
			allAppointment = appointmentRepository.searchLike("%"+fuzzy+"%",pageable);
		}
        return allAppointment;
	}

	@Override
	public int getTotal() {
		int total = (int) appointmentRepository.count();
		return total;
	}

	@Override
	public int getTotalByName(String cardealername) {
		int total = (int) appointmentRepository.getTotalByName(cardealername);
		return total;
	}

	@Override
	public void insertOrUpdateAppointment(Appointment appointment) {
		log.info("start insertOrUpdateAppointment service!");
		this.appointmentRepository.saveAndFlush(appointment);
	}
}
