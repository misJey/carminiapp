package com.pingan.carminiapp.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年7月31日 下午9:42:23
 * @version 1.0
 * @since JDK1.8
 * @Description (这里用一句话描述这个类的作用)
 */
@Component
public class VerifySessionLive extends HandlerInterceptorAdapter {
	private static final Logger log = LoggerFactory.getLogger(VerifySessionLive.class);

	/**
	 * 
	 * @author 作者 : 舒
	 * @date 创建时间：2018年7月31日 下午9:42:54
	 * @version 1.0
	 * @since JDK1.8
	 * @param request
	 * @param response
	 * @param handler
	 * @return
	 * @throws Exception
	 * @throws
	 * @Description 拦截/app**相关请求，验证session是否还存活
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		log.info("---------------------开始进入请求地址拦截(/app*)----------------------------");//request.getServletPath();
		HttpSession session = request.getSession(false);
		if(null == session){
			response.sendRedirect("login");
			return false;
		}else {
			return super.preHandle(request, response, handler);
		}
	}
}
