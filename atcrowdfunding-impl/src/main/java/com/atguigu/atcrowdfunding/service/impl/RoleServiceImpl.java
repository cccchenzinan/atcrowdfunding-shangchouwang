package com.atguigu.atcrowdfunding.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.atcrowdfunding.api.RoleService;
import com.atguigu.atcrowdfunding.bean.TAdminRoleExample;
import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.bean.TRoleExample;
import com.atguigu.atcrowdfunding.mapper.TAdminRoleMapper;
import com.atguigu.atcrowdfunding.mapper.TRoleMapper;

@Service
public class RoleServiceImpl implements RoleService {
	@Autowired
	TRoleMapper roleMapper;

	@Autowired
	TAdminRoleMapper adminRoleMapper;

	// 查询所有角色
	@Override
	public List<TRole> getAllRoles() {

		return roleMapper.selectByExample(null);
	}

	// 根据条件查询角色
	@Override
	public List<TRole> getAllRolesByCondition(String condition) {
		TRoleExample example = new TRoleExample();
		if (!StringUtils.isEmpty(condition)) {
			example.createCriteria().andNameLike("%" + condition + "%");
		}
		return roleMapper.selectByExample(example);
	}

	// 添加角色
	@Override
	public void addRole(TRole role) {
		roleMapper.insertSelective(role);
	}

	// 通过id删角色
	@Override
	public void deleteRole(int id) {
		roleMapper.deleteByPrimaryKey(id);
	}

	// 通过id查询角色
	@Override
	public TRole getRoleById(Integer id) {
		TRole role = roleMapper.selectByPrimaryKey(id);
		return role;
	}

	// 修改角色
	@Override
	public void updateRole(TRole role) {
		roleMapper.updateByPrimaryKey(role);
	}

	// 查询用户已有角色
	@Override
	public List<TRole> getUserHasRoles(Integer id) {
		List<TRole> roles = roleMapper.getUserHasRoles(id);
		return roles;
	}

	// 查询用户没有角色
	@Override
	public List<TRole> getUserUnRoles(Integer id) {
		List<TRole> unRoles = roleMapper.getUserUnRoles(id);

		return unRoles;
	}

	// 给用户插入角色
	@Override
	public void assignUserRole(Integer uid, String rids) {
		List<Integer> ridsList = new ArrayList<Integer>();
		if (!StringUtils.isEmpty(rids)) {
			String[] strings = rids.split(",");
			for (String string : strings) {
				Integer rid = Integer.parseInt(string);
				ridsList.add(rid);
			}
		}
		// 插入之前先删除
		TAdminRoleExample example = new TAdminRoleExample();
		example.createCriteria().andAdminidEqualTo(uid).andRoleidIn(ridsList);
		adminRoleMapper.deleteByExample(example);
		// 批量插入角色
		adminRoleMapper.insertBatchUserRole(uid, ridsList);
	}

	@Override
	public void unAssignUserRole(Integer uid, String rids) {
		List<Integer> ridsList = new ArrayList<Integer>();
		if (!StringUtils.isEmpty(rids)) {
			String[] strings = rids.split(",");
			for (String string : strings) {
				Integer rid = Integer.parseInt(string);
				ridsList.add(rid);
			}
		}
		TAdminRoleExample example = new TAdminRoleExample();
		example.createCriteria().andAdminidEqualTo(uid).andRoleidIn(ridsList);
		adminRoleMapper.deleteByExample(example);		
	}

}
