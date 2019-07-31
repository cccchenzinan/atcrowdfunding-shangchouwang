package com.atguigu.atcrowdfunding.controller.permission;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.atguigu.atcrowdfunding.api.PermissionService;
import com.atguigu.atcrowdfunding.bean.TPermission;

@RestController
public class PermissionAjaxCrudController {
	Logger logger =LoggerFactory.getLogger(PermissionAjaxCrudController.class);

	@Autowired
	PermissionService permissionService;

	@GetMapping("/permission/list")
	public List<TPermission> getAllPermissions() {
		return permissionService.getAllPermissions();
	};

	// 保存
	@PostMapping("/permission/add")
	public String savePermission(TPermission permission) {
		permissionService.savePermission(permission);
		return "ok";
	}

	// 修改
	@PostMapping("/permission/update")
	public String updatePermission(TPermission permission) {
		permissionService.updatePermission(permission);
		return "ok";
	}

	// 删除
	@GetMapping("/permission/delete")
	public String deletePermission(Integer id) {
		permissionService.deletePermission(id);
		return "ok";
	}

	// 通过id查询
	@GetMapping("/permission/get")
	public TPermission getPermission(Integer id) {
		TPermission permission = permissionService.getPermissionById(id);
		return permission;
	}

	// 给角色分配权限
	@PostMapping("/permission/role/assign")
	public String roleAssignPermission(@RequestParam("rid") Integer rid,
			@RequestParam("permissionIds") String permissionIds) {
		permissionService.assignPermissionForRole(rid, permissionIds);
		return "ok";
	}

	// 返回角色权限
	@GetMapping("/permission/role/get")
	public List<TPermission> getRolePermissions(@RequestParam("rid")Integer rid) {
		List<TPermission> permissions = permissionService.getRolePermissions(rid);
		return permissions;
	}
}
