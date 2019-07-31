package com.atguigu.atcrowdfunding.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atguigu.atcrowdfunding.api.AdminService;
import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.constant.AppConstant;

/**
 * controller只用来处理请求（@xxxMapping），调用service进行真正的业务处理（xxxservice.xxxmethod()）,
 * controller判断业务成功还是失败if()，成功去哪里 （return "url"）（提示放域中setAttribute）， 失败去哪里（提示）
 *
 */
@Controller
public class LoginController {
	Logger logger = LoggerFactory.getLogger(LoginController.class);

	@Autowired
	AdminService adminService;

	// @RequestMapping(value="/doLogin",method=RequestMethod.POST)
	// 等同于@PostMapping("/doLogin")
//	@PostMapping("/doLogin")
//	public String login(String username, String password, HttpSession session, Model model) {
//		logger.info("{}用户正在使用密码{}进行登录操作", username, password);
//
//		// admin为null说明登录失败，否则就是成功
//		TAdmin admin = adminService.login(username, password);
//		if (admin != null) {
//			logger.info("{}用户登录成功", username);
//			// 登录成功，将登录成功的用户保存到session域中
//			session.setAttribute(AppConstant.LOGIN_USER_SESSION_KEY, admin);
//			// 重定向完全解决重复提交，重定向不能访问受保护的资源
//			return "redirect:/main.html";
//		} else {
//			// 登录不成功，来到登录页提示账号密码错误
//			model.addAttribute(AppConstant.PAGE_MSG_KEY, "账号密码错误，请重试");
//			model.addAttribute("username", username);
//			// 只要forward：（转发） redirect：（重定向）视图解析器就不会拼接了
//			// 都加上/；表示当前项目路径
//			return "forward:/login.jsp";
//		}
//	}

	@GetMapping("/main.html")
	public String mainPage(HttpSession session, Model model) {
		// 判断登录了没，
		// 编程习惯，系统里常用的固定的值（特别是K&V的K第一次存就固定的以后都要用）抽取为常量
		TAdmin loginUser = (TAdmin) session.getAttribute(AppConstant.LOGIN_USER_SESSION_KEY);
		if (loginUser == null) {
			// session中没有就是没登录,在request中存提示信息
			model.addAttribute(AppConstant.PAGE_MSG_KEY, "你还未登录，请先登录");
			return "forward:/login.jsp";
		} else {
			// 登录成功后动态的去数据库查出菜单,并组装好
			//List<TMenu> meunus = adminService.listMenus();
			
			List<TMenu> meunus = adminService.listYourMenus(loginUser.getId());
			
			
			// 将查出来的菜单放在session域中，各个页面都要使用菜单
			session.setAttribute(AppConstant.MENU_SESSION_KEY, meunus);
			return "main";
		}
	}
	
	
	
	
	@GetMapping("/login")
	public String loginPage() {
		return "forward:/login.jsp";
	}
	
	
	
	
	
	

}
