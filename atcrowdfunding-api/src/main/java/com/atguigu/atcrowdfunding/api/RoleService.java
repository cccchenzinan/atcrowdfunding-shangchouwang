package com.atguigu.atcrowdfunding.api;

import java.util.List;

import com.atguigu.atcrowdfunding.bean.TRole;

public interface RoleService {
	// 返回所有的role数据
	List<TRole> getAllRoles();

	// 按照检索条件查询
	List<TRole> getAllRolesByCondition(String condition);

	// 角色添加
	void addRole(TRole role);

	// 通过id删除角色
	void deleteRole(int id);

	// 通过id查询角色
	TRole getRoleById(Integer id);

	// 修改角色
	void updateRole(TRole role);

	// 用户已有角色
	List<TRole> getUserHasRoles(Integer id);

	// 用户没有角色
	List<TRole> getUserUnRoles(Integer id);

	//给用户添加角色
	void assignUserRole(Integer uid, String rids);

	//删除用户的角色
	void unAssignUserRole(Integer uid, String rids);

}
