package com.atguigu.atcrowdfunding.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.atguigu.atcrowdfunding.api.MenuService;
import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.bean.TPermissionMenuExample;
import com.atguigu.atcrowdfunding.mapper.TMenuMapper;
import com.atguigu.atcrowdfunding.mapper.TPermissionMenuMapper;

@Service
public class MenuServiceImpl implements MenuService {
	@Autowired
	TMenuMapper menuMapper;

	@Autowired
	TPermissionMenuMapper permissionMenuMapper;

	@Override
	public List<TMenu> getAllMenus() {
		return menuMapper.selectByExample(null);
	}

	@Override
	public void saveMenu(TMenu menu) {
		menuMapper.insertSelective(menu);
	}

	@Override
	public void updateMenu(TMenu menu) {
		menuMapper.updateByPrimaryKeySelective(menu);
	}

	@Override
	public void deleteMenu(Integer id) {
		menuMapper.deleteByPrimaryKey(id);
	}

	@Override
	public TMenu getMenuById(Integer id) {
		return menuMapper.selectByPrimaryKey(id);
	}

	@Override
	public void saveMenuPermissions(Integer permissionId, String menuIds) {
		List<Integer> menuIdsList = new ArrayList<Integer>();
		if (!StringUtils.isEmpty(menuIds)) {
			String[] split = menuIds.split(",");
			for (String string : split) {
				int menuId = Integer.parseInt(string);
				menuIdsList.add(menuId);
			}

			// 删除这个权限对应的所有菜单
			TPermissionMenuExample example = new TPermissionMenuExample();
			example.createCriteria().andPermissionidEqualTo(permissionId);
			permissionMenuMapper.deleteByExample(example);

			// 保存这个权限对应的所有菜单
			permissionMenuMapper.insertBatchMenuPermission(permissionId, menuIdsList);

		}

	}

}
