package com.pingan.carminiapp.interceptor;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年7月30日 下午4:21:30
 * @version 1.0
 * @since JDK1.8
 * @Description 拦截请求
 */
@Configuration
public class WebAppConfig implements WebMvcConfigurer {//extends WebMvcConfigurationSupport {

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		//向客户端发送token
		registry.addInterceptor(new TokenInterceptor()).addPathPatterns("/**").excludePathPatterns("/app*","/isactive");
		//拦截所有/app*请求作session存活性验证,不使用/app/**形式为防止css样式引入问题
		registry.addInterceptor(new VerifySessionLive()).addPathPatterns("/app*");
	}

	/** 
     * 配置拦截器 
     * @author lance 
     * @param registry 
     *//*  
    protected void addInterceptors(InterceptorRegistry registry) {  
        registry.addInterceptor(new TokenInterceptor()).addPathPatterns("/**").excludePathPatterns("/static/**");  
        super.addInterceptors(registry);
        // 多个拦截器组成一个拦截器链
        // addPathPatterns 用于添加拦截规则
        // excludePathPatterns 用户排除拦截
        registry.addInterceptor(new MyInterceptor1()).addPathPatterns("/xxx1/**");
        registry.addInterceptor(new MyInterceptor2()).addPathPatterns("/xxx2/**");
    }*/
	
}
