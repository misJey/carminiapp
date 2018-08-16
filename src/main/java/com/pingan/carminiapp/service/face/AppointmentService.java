package com.pingan.carminiapp.service.face;

import java.util.List;

import com.pingan.carminiapp.domain.Appointment;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年8月8日 上午10:29:37
 * @version 1.0
 * @since JDK1.8
 * @Description (这里用一句话描述这个类的作用)
 */
public interface AppointmentService {
	List<Appointment> getAllCardealer(int pageNow,int pageSize,String fuzzy);
	
	int getTotal();

	int getTotalByName(String cardealername);
	
	void insertOrUpdateAppointment(Appointment appointment);
}
