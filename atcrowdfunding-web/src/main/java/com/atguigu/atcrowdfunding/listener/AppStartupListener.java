package com.atguigu.atcrowdfunding.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;





public class AppStartupListener implements ServletContextListener {
	Logger logger = LoggerFactory.getLogger(AppStartupListener.class);

	/**
	 * 项目初始化，给application域中保存项目路径方便浏览器解析时添加项目名
	 */
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		// TODO Auto-generated method stub
		ServletContext servletContext = sce.getServletContext();
		// 当前项目路径，以/开始，不以/结束
		String contextPath = servletContext.getContextPath();
		/**
		 * 相同：其实servletContext和application 是一样的，就相当于一个类创建了两个不同名称的变量。
		 * servlet中ServletContext就是application对象。
		 * 不同：两者的区别就是application用在jsp中，servletContext用在servlet中。 application和page
		 * request session 都是JSP中的内置对象， 在后台用ServletContext存储的属性数据可以用application对象获得。
		 */
		servletContext.setAttribute("ctx", contextPath);
		logger.debug("项目启动成.....访问路径是{}", contextPath);
	}

	/**
	 * 项目销毁
	 */
	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		// TODO Auto-generated method stub

	}

}
