package com.atguigu.atcrowdfunding.api;

import java.util.List;

import com.atguigu.atcrowdfunding.bean.TMenu;

public interface MenuService {
	//
	List<TMenu> getAllMenus();

	void saveMenu(TMenu menu);

	void updateMenu(TMenu menu);

	void deleteMenu(Integer id);

	TMenu getMenuById(Integer id);

	void saveMenuPermissions(Integer permissionId, String menuIds);

}
