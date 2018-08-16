package com.pingan.carminiapp.interceptor;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年7月30日 下午2:41:12
 * @version 1.0
 * @since JDK1.8
 * @Description (这里用一句话描述这个类的作用)
 */

import java.lang.annotation.*;
 
@Target(ElementType.METHOD)
@Retention (RetentionPolicy.RUNTIME)
@Documented
public @interface Token {
   boolean save() default false;
   boolean remove() default false;
}

