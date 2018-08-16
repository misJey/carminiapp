package com.pingan.carminiapp.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pingan.carminiapp.common.CacheManager;
import com.pingan.carminiapp.domain.SystemUser;
import com.pingan.carminiapp.interceptor.Token;
import com.pingan.carminiapp.service.face.SystemUserService;
import com.pingan.carminiapp.utils.UserStatusUtil;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年7月26日 下午3:12:47
 * @version 1.0
 * @since JDK1.8
 * @Description (这里用一句话描述这个类的作用)
 */
@Controller
public class LoginController {
	private static final Logger log = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	@Qualifier("systemUserServiceImpl")
	SystemUserService userService;
	
	//域名登陆
	@RequestMapping("/")
	@Token(save=true)
	public ModelAndView defaultIndexView(HttpServletRequest request, HttpServletResponse response,Model model){
		HttpSession session = request.getSession();
		ModelAndView mav = new ModelAndView();
		Integer userId = (Integer) session.getAttribute("userId");
		log.info("userId is "+userId);
		if (null == userId){
			mav.setViewName("login");
			//mav.addObject("error", "用户名或密码错误,请重新输入!");
			return mav;
        } else {
        	SystemUser user = UserStatusUtil.getUser(request);
        	mav.addObject("username",user.getUsername());
        	mav.setViewName("welcome");
        	return mav;
        }
	}
	
	//登陆处理
	@Token(remove=true)
	@RequestMapping(value="/backstageLogin",method=RequestMethod.POST)
	public ModelAndView login(@RequestParam("username") String username,@RequestParam("password") String password,HttpServletRequest request,Model model){
		log.info("start LoginController!,username is "+username);
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		SystemUser user = new SystemUser();
		user = userService.selectSystemUser(username, password);
		if(null == user){
			log.info("用户名或密码错误！user:"+user);
			mav.setViewName("login");
			mav.addObject("error", "用户名或密码错误,请重新输入!");
			return mav;
		}
		
		//单点登陆检查
		UserStatusUtil.checkoutSession(session, user.getId());		
		
		session.setAttribute("userId", user.getId());
		session.setMaxInactiveInterval(30*60);
		CacheManager.getInstance().addCache(session.getId(),user);//用户登陆后保存用户的信息到缓存中key:sessionid,value:user
		model.addAttribute("username", username);
		mav.setViewName("welcome");
		return mav;
	}
	
	//安全退出,并清理session
	@RequestMapping("/apploginout")
	@ResponseBody
	public Object loginout(HttpServletRequest request){
		UserStatusUtil.cleanSession(request);
		Map<String, Object> map  = new HashMap<String,Object>();
		map.put("message", "账号已经安全退出!");
		return map;
	}
	
	//轮询请求处理
	@RequestMapping("/isactive")
	@ResponseBody
	public Object polling(HttpServletRequest request){
		HttpSession session = request.getSession(false);
		Map<String, Object> map  = new HashMap<String,Object>();
		if(null != session &&  null !=session.getAttribute("userId")){
			map.put("data", "1");//用户在线状态
		}
		return map;
	}
}
