package com.pingan.carminiapp.utils;

import java.util.HashSet;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年7月28日 下午5:19:22
 * @version 1.0
 * @since JDK1.8
 * @Description (这里用一句话描述这个类的作用)
 */
public class UserLoginStatusCheckout {
	
	private static final Logger log = LoggerFactory.getLogger(UserLoginStatusCheckout.class);
	/**
	 * 
	 * @author 作者 : 舒
	 * @date 创建时间：2018年7月28日 下午5:21:32
	 * @version 1.0
	 * @since JDK1.8
	 * @param session
	 * @return
	 * boolean 
	 * @Description 为确保用户单点登陆，在用户登陆时，遍历所有session,看是否有该用户的userId，若存在，表示该用户已经登陆,删除掉原先登陆的所有相关缓存
	 */
	public static void checkoutSession(HttpSession session,int userId){
		log.info("start checkoutSession!");
		ServletContext application = session.getServletContext();
		@SuppressWarnings("unchecked")
		HashSet<HttpSession> sessions = (HashSet<HttpSession>) application.getAttribute("sessions");
		
		if(null == sessions){
			return ;
		}
		HashSet<HttpSession> template = new HashSet<HttpSession>();//避免遍历时又删除集合元素
		template.addAll(sessions);
		//遍历session,在SessionListener中同步清除缓存信息
		for(HttpSession session2:template){
			Integer temp = (Integer) session2.getAttribute("userId");
			if(null != temp && temp.equals(userId)){
				session2.invalidate();
			}
		}
	}
}
