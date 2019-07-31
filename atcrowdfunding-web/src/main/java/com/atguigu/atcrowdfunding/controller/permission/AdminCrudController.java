package com.atguigu.atcrowdfunding.controller.permission;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.atguigu.atcrowdfunding.api.AdminService;
import com.atguigu.atcrowdfunding.api.RoleService;
import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.constant.AppConstant;
import com.atguigu.atcrowdfunding.exception.EmailExistException;
import com.atguigu.atcrowdfunding.exception.LoginacctExistException;

@Controller
public class AdminCrudController {
	// 请求以html结尾就是跳转页面，否则就是进行真正的操作

	/**
	 * 如果封装请求参数是一个对象TAdmin admin； SpringMVC会自动将这个对象放在model中
	 * 驼峰规则，如果首字母与紧挨着的字母都是大写，驼峰出来也是大写 key的默认规则是按照类名首字母小写的驼峰方式做的； key用的是TAdmin；
	 * 
	 */

	@Autowired
	AdminService adminService;

	@Autowired
	RoleService roleService;

	// 跳转到修改页面
	@GetMapping("/user/edit.html")
	public String toEditPage(@RequestParam("id") Integer id, Model model) {
		TAdmin admin = adminService.getAdminById(id);
		model.addAttribute("data", admin);

		return "permission/user-edit";
	}

	// 提交修改请求
	@PostMapping("/user/update")
	public String updateAdmin(TAdmin admin, HttpSession session, Model model) {
		adminService.updateAdmin(admin);
		Integer pn = (Integer) session.getAttribute("pn");
		String condition = (String) session.getAttribute(AppConstant.QUERY_CONDITION_KEY);
		//
		model.addAttribute("pn", pn);
		model.addAttribute("condition", condition);
		/**
		 * SpringMVC的特性 1、在Model中放的数据 转发到下一个页面，数据是在请求域中${requestScope.param}
		 * 重定向到下一个页面，数据放在url地址后面，以请求参数的方式，解决中文乱码问题
		 */
		return "redirect:/admin/index.html";
	}

	// 跳转到添加页面
	@GetMapping("/user/add.html")
	public String addPage() {

		// 来到用户添加页面
		return "permission/user-add";
	}

	// 提交添加页面
	@PostMapping("/user/add")
	public String addAdmin(TAdmin admin, Model model) {
		boolean vaild = true;
		// 用异常机制使得上层感知下层的状态
		try {
			adminService.saveAdmin(admin);
		} catch (LoginacctExistException e) {
			// 1、账号占用
			vaild = false;
			model.addAttribute("loginacctmsg", e.getMessage());
		} catch (EmailExistException e) {
			// 2、邮箱占用
			vaild = false;
			model.addAttribute("emailmsg", e.getMessage());
		}

		if (!vaild) {
			// 校验失败
			return "permission/user-add";
		}

		// 新增完后跳转到最后一页,利用分页合理化机制，跳到最后一页
		return "redirect:/admin/index.html?pn=" + Integer.MAX_VALUE;
	}

	// 单个删除
	@GetMapping("/user/delete")
	public String deleteAdmin(@RequestParam("id") Integer id, HttpSession session, Model model) {
		String condition = (String) session.getAttribute(AppConstant.QUERY_CONDITION_KEY);
		Integer pn = (Integer) session.getAttribute("pn");
		model.addAttribute("condition", condition);
		model.addAttribute("pn", pn);
		// 删除方法
		adminService.deleteAdminById(id);

		return "redirect:/admin/index.html";
	}

	// 批量删除
	@GetMapping("/user/batch/delete")
	public String deleteBathchAdmin(@RequestParam("ids") String ids, HttpSession session, Model model) {
		String condition = (String) session.getAttribute(AppConstant.QUERY_CONDITION_KEY);
		Integer pn = (Integer) session.getAttribute("pn");
		model.addAttribute("condition", condition);
		model.addAttribute("pn", pn);
		// ids中的id以 1,2,3... 的形式保存
		if (!StringUtils.isEmpty(ids)) {
			// 分割存到数组中
			String[] split = ids.split(",");
			// 遍历删除
			for (String id : split) {
				try {
					int i = Integer.parseInt(id);
					adminService.deleteAdminById(i);
				} catch (NumberFormatException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

		return "redirect:/admin/index.html";
	}

	//查询用户已有角色和没有的角色
	@GetMapping("/user/assignRole.html")
	public String toAssignRolePage(@RequestParam("id") Integer id, Model model) {
		// 查出用户已有发角色
		List<TRole> roles = roleService.getUserHasRoles(id);
		// 查出用户没有的角色
		List<TRole> unRoles = roleService.getUserUnRoles(id);

		model.addAttribute("roles", roles);
		model.addAttribute("unRoles", unRoles);
		return "permission/user-role";

	}

	//给用户添加角色
	@GetMapping("/user/assign/role")
	public String assignUserRole(@RequestParam("uid") Integer uid, 
			@RequestParam("rids") String rids) {
		roleService.assignUserRole(uid, rids);
		return "redirect:/user/assignRole.html？id="+uid;
	}
	
	//删除用户的角色
	@GetMapping("/user/unassign/role")
	public String unAssignUserRole(@RequestParam("uid") Integer uid, 
			@RequestParam("rids") String rids) {
		roleService.unAssignUserRole(uid, rids);
		return "redirect:/user/assignRole.html？id="+uid;
		
	}
}
