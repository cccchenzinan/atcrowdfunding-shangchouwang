package com.atguigu.atcrowdfunding.api;

import java.util.List;

import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.bean.TPermission;

public interface PermissionService {

	List<TPermission> getAllPermissions();

	void savePermission(TPermission permission);

	void updatePermission(TPermission permission);

	void deletePermission(Integer id);

	TPermission getPermissionById(Integer id);

	void assignPermissionForRole(Integer rid, String permissionIds);

	List<TPermission> getRolePermissions(Integer rid);

	List<TMenu> getMenusByPermissionId(Integer permissionId);


}
