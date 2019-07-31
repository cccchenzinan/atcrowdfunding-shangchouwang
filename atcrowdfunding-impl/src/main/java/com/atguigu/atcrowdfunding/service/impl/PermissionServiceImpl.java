package com.atguigu.atcrowdfunding.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.atcrowdfunding.api.PermissionService;
import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.bean.TPermission;
import com.atguigu.atcrowdfunding.bean.TRolePermissionExample;
import com.atguigu.atcrowdfunding.mapper.TMenuMapper;
import com.atguigu.atcrowdfunding.mapper.TPermissionMapper;
import com.atguigu.atcrowdfunding.mapper.TRolePermissionMapper;

@Service
public class PermissionServiceImpl implements PermissionService {
	Logger logger = LoggerFactory.getLogger(PermissionServiceImpl.class);
	@Autowired
	TPermissionMapper permissionMapper;

	@Autowired
	TRolePermissionMapper rolePermissionMapper;

	@Autowired
	TMenuMapper menuMapper;
	
	
	@Override
	public List<TPermission> getAllPermissions() {
		// TODO Auto-generated method stub
		return permissionMapper.selectByExample(null);
	}

	@Override
	public void savePermission(TPermission permission) {
		// TODO Auto-generated method stub
		permissionMapper.insertSelective(permission);
	}

	@Override
	public void updatePermission(TPermission permission) {
		// TODO Auto-generated method stub
		permissionMapper.updateByPrimaryKey(permission);
	}

	@Override
	public void deletePermission(Integer id) {
		// TODO Auto-generated method stub
		permissionMapper.deleteByPrimaryKey(id);

	}

	@Override
	public TPermission getPermissionById(Integer id) {
		// TODO Auto-generated method stub
		return permissionMapper.selectByPrimaryKey(id);
	}

	@Override
	public void assignPermissionForRole(Integer rid, String permissionIds) {
		List<Integer> permissionIdList = new ArrayList<Integer>();
		if (!StringUtils.isEmpty(permissionIds)) {
			String[] split = permissionIds.split(",");
			for (String string : split) {
				Integer pid = Integer.parseInt(string);
				permissionIdList.add(pid);
			}
			// 1、插入之前先删除，这个角色的全部删除。
			TRolePermissionExample example = new TRolePermissionExample();
			example.createCriteria().andRoleidEqualTo(rid);
			rolePermissionMapper.deleteByExample(example);
			// 插入角色对应的所有权限,
			rolePermissionMapper.insertPermissionsToRoleBatch(rid, permissionIdList);
		}
	}

	@Override
	public List<TPermission> getRolePermissions(Integer rid) {
		List<TPermission> permissions = permissionMapper.selectRolePermissions(rid);
		return permissions;
	}

	@Override
	public List<TMenu> getMenusByPermissionId(Integer permissionId) {
		// TODO Auto-generated method stub
		return menuMapper.getMenusByPermissionId(permissionId);
	}

}
