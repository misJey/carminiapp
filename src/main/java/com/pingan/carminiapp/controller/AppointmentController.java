package com.pingan.carminiapp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pingan.carminiapp.domain.Appointment;
import com.pingan.carminiapp.domain.SystemUser;
import com.pingan.carminiapp.service.face.AppointmentService;
import com.pingan.carminiapp.utils.UserStatusUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年8月8日 上午10:22:45
 * @version 1.0
 * @since JDK1.8
 * @Description (这里用一句话描述这个类的作用)
 */
@Controller
public class AppointmentController {
	private static final Logger log = LoggerFactory.getLogger(AppointmentController.class);
	
	@Autowired
	@Qualifier("appointmentServiceImpl")
	AppointmentService appointmentService;
	
	//预约记录页（默认页）
	@GetMapping("/appindex")
	public ModelAndView appointmentView(HttpServletRequest request,@RequestParam("currentPage") String currentPage,String fuzzy){
		log.info("appointmentView controller start!");
		ModelAndView mav = new ModelAndView("index");
		int pageSize = 15;
		int pageNow = Integer.valueOf(currentPage);//页码，从0开始为第一页
		SystemUser user = UserStatusUtil.getUser(request);
		int category = user.getCategory();
		mav.addObject("category", category);//用户类型
		mav.addObject("username", user.getUsername());
		int total = 0;
		
		List<Appointment> appointmentInfo = null;
		JSONArray jsonArray = null;
		if(category < 2){//管理员可以查看所有
			appointmentInfo = this.appointmentService.getAllCardealer(pageNow, pageSize,fuzzy);
			if(null == appointmentInfo){
				mav.addObject("total", 0);
				return mav;
			}
			total = this.appointmentService.getTotal();//预约总数
		}else{
			appointmentInfo = this.appointmentService.getAllCardealer(pageNow,pageSize,user.getCardealername());
			total = this.appointmentService.getTotal();
		}
		jsonArray = JSONArray.fromObject(appointmentInfo.toArray());
		mav.addObject("total", total);
		mav.addObject("appointmentInfo", jsonArray);
		return mav;
	}
	
	//新增或更新预约请求
	@PostMapping("/appaddappointment")
	@ResponseBody
	public Object addAppointment(@RequestBody JSONObject jsonObject){
		log.info("start addSystemUser--add!");
		Appointment appointment = (Appointment) JSONObject.toBean(jsonObject, Appointment.class);
		this.appointmentService.insertOrUpdateAppointment(appointment);
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("result", "success");
		return map;
	}
}
