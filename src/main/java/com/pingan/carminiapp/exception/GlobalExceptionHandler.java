package com.pingan.carminiapp.exception;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年7月30日 上午9:10:37
 * @version 1.0
 * @since JDK1.8
 * @Description (这里用一句话描述这个类的作用)
 */
@ControllerAdvice
public class GlobalExceptionHandler {

	public static final String DEFAULT_ERROR_VIEW = "error";
	
	/**
	 * 
	 * @author 作者 : 舒
	 * @date 创建时间：2018年7月30日 上午9:13:24
	 * @version 1.0
	 * @since JDK1.8
	 * @param req
	 * @param e
	 * @return
	 * @throws Exception
	 * ModelAndView 
	 * @Description 全局处理Exception异常
	 */
	@ExceptionHandler(value=Exception.class)
	public ModelAndView defaultErrorHandler(HttpServletRequest req, Exception e) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.addObject("exception", e);
		mav.addObject("url", req.getRequestURL());
		mav.setViewName(DEFAULT_ERROR_VIEW);
		return mav;
	}
}
