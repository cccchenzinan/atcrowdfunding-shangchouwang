package com.atguigu.atcrowdfunding.api;

import java.util.List;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.exception.EmailExistException;
import com.atguigu.atcrowdfunding.exception.LoginacctExistException;

public interface AdminService {
	// 登录验证
	TAdmin login(String username, String password);

	// 查出所有菜单组装好父子关系
	List<TMenu> listMenus();

	// 查出系统中所有的用户
	List<TAdmin> listAllAdmin();

	// 带条件查询所有Admin
	List<TAdmin> listAllAdminByCondition(String condition);

	// 按照id查询用户
	TAdmin getAdminById(Integer id);

	// 按照id修改admin
	void updateAdmin(TAdmin admin);

	// 保存新增admin对象
	void saveAdmin(TAdmin admin) throws LoginacctExistException, EmailExistException;

	// 1、检查账号是否被占用（true表示可用，false表示不可用，已经被占用）
	public boolean checkLoginacct(TAdmin admin);

	// 2、检查邮箱是否被占用（true表示可用，false表示不可用，已经被占用）
	public boolean checkEmail(TAdmin admin);

	// 根据id删除admin（单个）
	void deleteAdminById(Integer id);

	//查询用户自己能操作的菜单
	List<TMenu> listYourMenus(Integer id);
}
