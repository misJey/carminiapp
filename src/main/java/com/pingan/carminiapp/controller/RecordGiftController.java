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

import com.pingan.carminiapp.domain.RecordGift;
import com.pingan.carminiapp.domain.SystemUser;
import com.pingan.carminiapp.service.face.RecordGiftService;
import com.pingan.carminiapp.utils.UserStatusUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年8月8日 上午11:55:02
 * @version 1.0
 * @since JDK1.8
 * @Description (这里用一句话描述这个类的作用)
 */
@Controller
public class RecordGiftController {
	private static final Logger log = LoggerFactory.getLogger(RecordGiftController.class);
	
	@Autowired
	@Qualifier("recordGiftServiceImpl")
	RecordGiftService recordGiftService;
	
	//礼品发放记录页
	@GetMapping("/appgift")
	public ModelAndView giftView(HttpServletRequest request,@RequestParam("currentPage") String currentPage,String fuzzy){
		log.info("giftView controller start!");
		ModelAndView mav = new ModelAndView("gift");
		int pageSize = 15;
		int pageNow = Integer.valueOf(currentPage);//页码，从0开始为第一页
		SystemUser user = UserStatusUtil.getUser(request);
		int category = user.getCategory();
		mav.addObject("category", category);//用户类型
		mav.addObject("username", user.getUsername());
		int total = 0;
		
		List<RecordGift> recordGiftInfo = null;
		JSONArray jsonArray = null;
		if(category < 2){//管理员可以查看所有
			recordGiftInfo = this.recordGiftService.getAllRecordGift(pageNow, pageSize,fuzzy);
			if(null == recordGiftInfo){
				mav.addObject("total", 0);
				return mav;
			}
			total = this.recordGiftService.getTotal();//预约总数
		}else{
			recordGiftInfo = this.recordGiftService.getAllRecordGift(pageNow,pageSize,user.getCardealername());
			total = this.recordGiftService.getTotal();
		}
		jsonArray = JSONArray.fromObject(recordGiftInfo.toArray());
		mav.addObject("total", total);
		mav.addObject("recordGiftInfo", jsonArray);
		return mav;
	}
	
	//新增或更新礼品记录
	@PostMapping("/appaddrecordgift")
	@ResponseBody
	public Object addRecordGift(@RequestBody JSONObject jsonObject){
		log.info("start addRecordGift--add!");
		RecordGift recordGift = (RecordGift) JSONObject.toBean(jsonObject, RecordGift.class);
		this.recordGiftService.insertOrUpdateRecordGift(recordGift);
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("result", "success");
		return map;
	}
}
