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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.atguigu.atcrowdfunding.api.RoleService;
import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.constant.AppConstant;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;


//@RestController包含了@ResponseBody和@Controller
@RestController
//类上面标了@ResponseBody，每个方法不用标
//@Controller
public class RoleAjaxCrudController {
	@Autowired
	RoleService roleService;

	/**
	 * SpringMVC自动将返回的对象以json字符串的方式交给浏览器 1、导入jackson的包
	 * <groupId>com.fasterxml.jackson.core</groupId>
	 * <artifactId>jackson-core</artifactId>
	 * 
	 * <groupId>com.fasterxml.jackson.core</groupId>
	 * <artifactId>jackson-databind</artifactId> 
	 * 2、开启SpringMVC的高级模式
	 * <mvc:annotation-driven></mvc:annotation-driven>
	 */

	// @ResponseBody注解可以让服务器返回json对象给浏览器，而不是将返回值交由视图解析器拼接成url
	@ResponseBody
	@GetMapping("/role/list")
	public PageInfo<TRole> roleList(
			@RequestParam(value="pn",defaultValue="1")Integer pn,
			@RequestParam(value="ps",defaultValue=AppConstant.DEFAULT_PAGE_SIZE)Integer ps,
			@RequestParam(value="condition",defaultValue="")String condition) {
		PageHelper.startPage(pn,ps);
		//List<TRole> roles = roleService.getAllRoles();
		List<TRole> roles=roleService.getAllRolesByCondition(condition);
		PageInfo<TRole> pageInfo=new PageInfo<TRole>(roles,5);
		return pageInfo;
	}
	
	
	//添加角色
	@ResponseBody
	@PostMapping("/role/add")
	public String addRole(TRole role) {
		roleService.addRole(role);
		//告诉浏览器操作成败
		return "OK";
		
	}
	
	
	

		// 批量删除
	@ResponseBody
	@GetMapping("/role/delete")
	public String deleteRole(@RequestParam("ids")String ids) {
		
		if(!StringUtils.isEmpty(ids)) {
			String[] split=ids.split(",");
			for(String string:split) {
				try {
					int id=Integer.parseInt(string);
					roleService.deleteRole(id);
				} catch (NumberFormatException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			return "ok";
		}
		return "fale";		
	}
	
	//查询角色
	@ResponseBody
	@GetMapping("/role/get")
	public TRole getRole(@RequestParam("id")Integer id) {
		TRole role=roleService.getRoleById(id);
			//告诉浏览器操作成败
			return role;
		}
	//修改角色
	@ResponseBody
	@PostMapping("/role/update")
	public String updateRole(TRole role) {
		System.out.println(role);
		roleService.updateRole(role);		
		return "ok";	
	}
	
	
	
	
}
