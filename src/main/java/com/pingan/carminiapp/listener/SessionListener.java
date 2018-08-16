package com.pingan.carminiapp.listener;

import java.util.HashSet;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.pingan.carminiapp.common.CacheManager;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年7月28日 上午9:14:14
 * @version 1.0
 * @since JDK1.8
 * @Description 会话监控类
 */
@WebListener
public class SessionListener implements HttpSessionListener{ //, HttpSessionAttributeListener{
	private static final Logger logger = LoggerFactory.getLogger(SessionListener.class);

	/*@Override
	public void attributeAdded(HttpSessionBindingEvent se) {
		logger.info("--add session--");
        HttpSession session = se.getSession();
        logger.info("key----:"+se.getName());
        logger.info("value---:"+se.getValue());

	}

	@Override
	public void attributeRemoved(HttpSessionBindingEvent se) {
		logger.info("--remove session--");
	}

	@Override
	public void attributeReplaced(HttpSessionBindingEvent se) {
		logger.info("--replace session--");
	}*/

	@Override
	public void sessionCreated(HttpSessionEvent event) {
		logger.info("---create session----");
        HttpSession session = event.getSession();
        ServletContext application = session.getServletContext();
        // 在application范围由一个HashSet集保存所有的session
        @SuppressWarnings("unchecked")
		HashSet<HttpSession> sessions =  (HashSet<HttpSession>) application.getAttribute("sessions");
        if (null == sessions) {
            sessions = new HashSet<HttpSession>();
            application.setAttribute("sessions", sessions);
        }
        // 新创建的session均添加到HashSet集中
       sessions.add(session);
       logger.info("------------sessions.size总会话数为:"+sessions.size());
        // 可以在别处从application范围中取出sessions集合
        // 然后使用sessions.size()获取当前活动的session数，即为“在线人数”
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent event) {
		logger.info("---destroy session----");
        HttpSession session = event.getSession();
        logger.info("deletedSessionId: "+session.getId());
        ServletContext application = session.getServletContext();
        @SuppressWarnings("unchecked")
		HashSet<HttpSession> sessions = (HashSet<HttpSession>) application.getAttribute("sessions");
        //当会话结束删除缓存中登陆用户的信息
        CacheManager.getInstance().removeCache(session.getId());
        //销毁的session均从HashSet集中移除
        if(null != sessions){
        	sessions.remove(session);
        }
	}
}
