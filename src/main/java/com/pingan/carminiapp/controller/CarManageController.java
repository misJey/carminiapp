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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.pingan.carminiapp.domain.CarSeries;
import com.pingan.carminiapp.domain.CarType;
import com.pingan.carminiapp.domain.SystemUser;
import com.pingan.carminiapp.service.face.CarSeriesService;
import com.pingan.carminiapp.service.face.CarTypeService;
import com.pingan.carminiapp.utils.FileUploadUtil;
import com.pingan.carminiapp.utils.UserStatusUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


/**
 * @author 作者 : 舒
 * @date 创建时间：2018年8月6日 上午9:15:48
 * @version 1.0
 * @since JDK1.8
 * @Description (这里用一句话描述这个类的作用)
 */
@Controller
public class CarManageController {
	private static final Logger log = LoggerFactory.getLogger(CarManageController.class);
	@Autowired
	@Qualifier("carTypeServiceImpl")
	CarTypeService carTypeService;
	@Autowired
	@Qualifier("carSeriesServiceImpl")
	CarSeriesService carSeriesService;
	
	//试驾车型管理页
	@RequestMapping("/appcarconfig")
	public ModelAndView carConfigView(HttpServletRequest request,@RequestParam("currentPage") String currentPage,String fuzzy){
		log.info("carConfigView controller start!");
		ModelAndView mav = new ModelAndView("carconfig");
		int pageSize = 15;
		int pageNow = Integer.valueOf(currentPage);//页码，从0开始为第一页
		SystemUser user = UserStatusUtil.getUser(request);
		int category = user.getCategory();
		mav.addObject("category", category);//用户类型
		mav.addObject("username", user.getUsername());
		int total = 1;//车商用户登陆默认只展示自己，即总数为1
		
		List<CarSeries> carSeriesInfo = null;
		JSONArray jsonArray = null;
		if(category < 2){//管理员可以查看所有
			carSeriesInfo = this.carSeriesService.getAllCarSeries(pageNow, pageSize,fuzzy);
			if(null == carSeriesInfo){
				mav.addObject("total", 0);
				return mav;
			}
			total = this.carSeriesService.getTotal();//车系总数
		}else{
			carSeriesInfo = this.carSeriesService.getAllCarSeries(pageNow, pageSize,user.getCardealername());//车商用户只展示自己的车系
			total = this.carSeriesService.getTotalByName(user.getCardealername());//车系总数
		}
		jsonArray = JSONArray.fromObject(carSeriesInfo.toArray());
		mav.addObject("total", total);
		mav.addObject("carSeriesInfo", jsonArray);
		return mav;
	}
	
	//按id删除试驾车系
	@GetMapping("/appdeletecarseries")
	@ResponseBody
	public Object deleteCarseries(@RequestParam("id")String id){
		log.info("start deleteCarseries--delete!");
		this.carSeriesService.deleteCarseries(Integer.parseInt(id));
		this.carTypeService.deleteCarType(Integer.parseInt(id));//删除关联的所有车型
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("result", "success");
		return map;
	}
	
	//按id删除试驾车型
	@GetMapping("/appdeletecartype")
	@ResponseBody
	public Object deleteCarType(@RequestParam("id")String id){
		log.info("start deleteCarType--delete!");
		this.carTypeService.deleteCarTypeById(Integer.parseInt(id));//删除关联的所有车型
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("result", "success");
		return map;
	}
	
	//按id修改试驾车型信息
	@GetMapping("/appmodifycarseries")
	@ResponseBody
	public ModelAndView modifyCarSeries(@RequestParam("id")String id,HttpServletRequest request){
		log.info("start modifyCarSeries--delete!");
		int carseriesId = Integer.parseInt(id);
		ModelAndView mav = new ModelAndView("carconfig_edit");
		CarSeries carseries = this.carSeriesService.getCarSeriesById(carseriesId);
		List<CarType> carTypeInfo = this.carTypeService.getAllCarType(carseriesId);;
		mav.addObject("modifyCarTypeInfo", JSONArray.fromObject(carTypeInfo));
		mav.addObject("modifyCarseries", JSONObject.fromObject(carseries));
		SystemUser user = UserStatusUtil.getUser(request);
		mav.addObject("username", user.getUsername());
		return mav;
	}
	
	//添加车系+车型
	@PostMapping("/appaddcarseries")
	@ResponseBody
	public Object addCarSeries(@RequestBody JSONObject jsonObject,HttpServletRequest request){
		log.info("start appaddcardealer--add!");
		JSONObject jsonObject2 = JSONObject.fromObject(jsonObject.get("carSeries"));
		CarSeries carseries = (CarSeries) JSONObject.toBean(jsonObject2, CarSeries.class);
		CarSeries carSeries = this.carSeriesService.insertCarSeries(carseries);
		
		JSONArray jsonArray = (JSONArray) jsonObject.get("carTypeInfo");
		JSONObject jsonObject3 = null;
		CarType cartype2 = null;
		String imageNew = null;
		String imageOld = null;
		String id = null;
		int carseriesid = carSeries.getId();
		for(int i=0 ;i<jsonArray.size();i++){
			CarType carType = new CarType();
			jsonObject3 = jsonArray.getJSONObject(i);
			id = (String) jsonObject3.get("id");
			imageNew = jsonObject3.getString("image");
			carType.setCarseriesid(carseriesid);
			carType.setColor(jsonObject3.getString("color"));
			carType.setSerialnumber(Integer.parseInt(jsonObject3.getString("serialnumber")));
			carType.setImage(imageNew);
			if(null != id){//不为空表示是修改请求
				cartype2 = this.carTypeService.getCarTypeById(Integer.parseInt(id));
				if(carType.equals(cartype2)){
					continue;//该车型未做任何修改
				}
				imageOld = cartype2.getImage();
				//不相等表示有图片更新，这时处理carType更新并重命名为之前的图片名称以覆盖原先图片
				if(!imageNew.equals(imageOld)){
					carType.setImage(imageOld);
				}else{
					imageOld = "noupdate";//相等则表示没有更新图片的操作
				}
			}
			carTypeService.insertCarType(carType);
			FileUploadUtil.saveFile(imageNew,imageOld,request);
		}
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("result", "success");
		return map;
	}
	
	//试驾车型管理编辑页
	@GetMapping("/appcarconfigedit")
	public ModelAndView appCarConfigEdit(HttpServletRequest request){
		log.info("start appCarConfigEdit controller!");
		ModelAndView mav = new ModelAndView("carconfig_edit");
		SystemUser user = UserStatusUtil.getUser(request);
		mav.addObject("systemUser", user);
		mav.addObject("username", user.getUsername());
		return mav;
	}
	
	@PostMapping("/appupload")
	@ResponseBody
	public Object upload(@RequestParam("file") MultipartFile  file,HttpServletRequest request){
		log.info("start upload controller!");
		Map<String,Object> map = new HashMap<String,Object>();
		String filename = FileUploadUtil.writeUploadFile(file,request);
		map.put("imageName", filename);
		return map;
	}
}
