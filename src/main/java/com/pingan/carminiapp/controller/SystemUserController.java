package com.pingan.carminiapp.controller;


import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pingan.carminiapp.domain.SystemUser;
import com.pingan.carminiapp.service.face.SystemUserService;
import com.pingan.carminiapp.utils.UserStatusUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 
 * @author 作者 : 舒
 * @date 创建时间：2018年7月25日 下午1:57:57
 * @version 1.0
 * @since JDK1.8
 * @parameter
 * @return
 * 
 */
@Controller
public class SystemUserController {
	private static final Logger log = LoggerFactory.getLogger(SystemUserController.class);
	
	@Autowired
	@Qualifier("systemUserServiceImpl")
	SystemUserService userService;
	
	//系统账号管理管理页
	@GetMapping("/appusermanage")
	@ResponseBody
	public ModelAndView userManageView(HttpServletRequest request,@RequestParam("currentPage") String currentPage){
		log.info("userManageView controller start!");
		ModelAndView mav = new ModelAndView("usermanage");
		int pageSize = 15;
		int pageNow = Integer.valueOf(currentPage);//页码，从0开始为第一页
		SystemUser user = UserStatusUtil.getUser(request);
		int category = user.getCategory();
		mav.addObject("category", category);//用户类型
		mav.addObject("username", user.getUsername());
		int total = 1;//车商用户登陆默认只展示自己，即总数为1
		
		Page<SystemUser> userInfo = null;
		JSONArray jsonArray = null;
		if(category < 2){//管理员可以查看所有
			userInfo = this.userService.getALLUser(pageNow, pageSize);
			jsonArray = JSONArray.fromObject(userInfo.getContent().toArray());
			total = this.userService.getTotal();//用户总数
		}else{
			jsonArray = JSONArray.fromObject(user);
		}
		
		mav.addObject("total", total);
		mav.addObject("userInfo", jsonArray);
		return mav;
	}
	
	//按id删除用户
	@GetMapping("/appdeleteuser")
	@ResponseBody
	public Object deleteSystemUser(@RequestParam("id")String id){
		log.info("start deleteSystemUser--delete!");
		this.userService.deleteSystemUser(Integer.parseInt(id));
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("result", "success");
		return map;
	}
	
	//按id修改用户
	@GetMapping("/appmodifyuser")
	@ResponseBody
	public ModelAndView modifySystemUser(@RequestParam("id")String id,HttpServletRequest request){
		log.info("start modifySystemUser--modify!");
		SystemUser user = this.userService.getSystemUserById(Integer.parseInt(id));
		ModelAndView mav = new ModelAndView("usermanage_edit");
		SystemUser loginUser = UserStatusUtil.getUser(request);
		mav.addObject("username", loginUser.getUsername());
		mav.addObject("modifyUser", JSONObject.fromObject(user));
		return mav;
	}
	
	//新增或更新用户信息请求
	@PostMapping("/appadduser")
	@ResponseBody
	public Object addSystemUser(@RequestBody JSONObject jsonObject){
		log.info("start addSystemUser--add!");
		SystemUser user = (SystemUser) JSONObject.toBean(jsonObject, SystemUser.class);
		this.userService.insertOrUpdateSystemUser(user);
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("result", "success");
		return map;
	}
	
	//系统账号管理管理编辑页
	@GetMapping("/appusermanageedit")
	public ModelAndView appUserManageEdit(HttpServletRequest request){
		ModelAndView mav = new ModelAndView("usermanage_edit");
		SystemUser loginUser = UserStatusUtil.getUser(request);
		mav.addObject("username", loginUser.getUsername());
		return mav;
	}
	
	//添加用户时检测用户名是否已存在
	@GetMapping("/appcheckusername")
	@ResponseBody
	public Object checkUsername(@RequestParam("username")String username){
		String flag = "false";
		SystemUser user = this.userService.getSystemUserByUsername(username);
		if(null != user){
			flag = "true";
		}
		return flag;
	}
	
}
