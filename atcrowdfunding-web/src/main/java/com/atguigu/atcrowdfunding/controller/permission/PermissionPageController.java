package com.atguigu.atcrowdfunding.controller.permission;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.atguigu.atcrowdfunding.api.AdminService;
import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.constant.AppConstant;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class PermissionPageController {
	@Autowired
	AdminService adminService;

	@GetMapping("/admin/index.html")
	public String userPage(Model model, @RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "ps", defaultValue = AppConstant.DEFAULT_PAGE_SIZE) Integer ps,
			@RequestParam(value = "condition", defaultValue = "") String condition, HttpSession session) {

		// 将查询条件放在session中
		session.setAttribute(AppConstant.QUERY_CONDITION_KEY, condition);
		session.setAttribute("pn", pn);

		// 查出系统中所有的用户TAdmin
		PageHelper.startPage(pn, ps);
		// List<TAdmin> admins = adminService.listAllAdmin();
		List<TAdmin> admins = adminService.listAllAdminByCondition(condition);

		PageInfo<TAdmin> page = new PageInfo<TAdmin>(admins, AppConstant.CONTINUES_PAGE_KEY);
		model.addAttribute("page", page);
		return "permission/user";
	}

	@GetMapping("/role/index.html")
	public String rolePage() {
		return "permission/role";
	}

	@GetMapping("/permission/index.html")
	public String permissionPage() {
		return "permission/permission";
	}

	@GetMapping("/menu/index.html")
	public String menuPage() {
		return "permission/menu";
	}

}
