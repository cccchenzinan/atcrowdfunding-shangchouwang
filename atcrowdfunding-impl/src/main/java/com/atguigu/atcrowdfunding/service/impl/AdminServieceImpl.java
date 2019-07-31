package com.atguigu.atcrowdfunding.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.atcrowdfunding.api.AdminService;
import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TAdminExample;
import com.atguigu.atcrowdfunding.bean.TAdminExample.Criteria;
import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.bean.TMenuExample;
import com.atguigu.atcrowdfunding.exception.EmailExistException;
import com.atguigu.atcrowdfunding.exception.LoginacctExistException;
import com.atguigu.atcrowdfunding.mapper.TAdminMapper;
import com.atguigu.atcrowdfunding.mapper.TMenuMapper;
import com.atguigu.atcrowdfunding.utils.AppUtils;

@Service
public class AdminServieceImpl implements AdminService {
	Logger logger = LoggerFactory.getLogger(AdminServieceImpl.class);

	@Autowired
	TAdminMapper adminMapper;

	@Autowired
	TMenuMapper menuMapper;

	// 登录验证
	@Override
	public TAdmin login(String username, String password) {
		// 执行登录
		// 密码加密（不可逆加密，将加密后的结果与数据库中的结果进行对比）
		String pwd = AppUtils.getDigestPwd(password);
		logger.info(pwd);

		// xxxByExample结尾的，代表带复杂条件的Crud
		// xxxByPrimaryKey结尾的，代表通过主键的Crud
		// xxxSelective:常见于insert和update;代表有选择的插入更新，只更新不为null的字段
		TAdminExample example = new TAdminExample();
		Criteria criteria = example.createCriteria();
		criteria.andLoginacctEqualTo(username).andUserpswdEqualTo(pwd);
		List<TAdmin> list = adminMapper.selectByExample(example);

		return list != null && list.size() == 1 ? list.get(0) : null;
	}

	// 查出所有菜单组装好父子关系
	@Override
	public List<TMenu> listMenus() {
		// 1、查出父菜单
		TMenuExample example = new TMenuExample();
		example.createCriteria().andPidEqualTo(0);
		List<TMenu> parentMenus = menuMapper.selectByExample(example);

		// 2把这些父菜单的子菜单找到
		for (TMenu menu : parentMenus) {
			TMenuExample example2 = new TMenuExample();
			// 父菜单的id就是子菜单的pid
			example2.createCriteria().andPidEqualTo(menu.getId());
			List<TMenu> childMenus = menuMapper.selectByExample(example2);
			// 保存起来
			menu.setChilds(childMenus);

		}

		return parentMenus;
	}

	// 查出系统中所有的用户
	@Override
	public List<TAdmin> listAllAdmin() {

		return adminMapper.selectByExample(null);
	}

	// 带条件查询所有Admin
	@Override
	public List<TAdmin> listAllAdminByCondition(String condition) {
		TAdminExample example = new TAdminExample();
		if (!StringUtils.isEmpty(condition)) {
			// 所有and条件都放第一个Criteria
			Criteria c0 = example.createCriteria();
			c0.andLoginacctLike("%" + condition + "%");
			Criteria c1 = example.createCriteria();

			c1.andUsernameLike("%" + condition + "%");

			Criteria c2 = example.createCriteria();
			c2.andEmailLike("%" + condition + "%");
			example.or(c1);
			example.or(c2);
		}
		return adminMapper.selectByExample(example);

	}

	// 按照id查询用户
	@Override
	public TAdmin getAdminById(Integer id) {
		return adminMapper.selectByPrimaryKey(id);
	}

	// 按照id修改admin
	@Override
	public void updateAdmin(TAdmin admin) {
		// 有选择的更新
		adminMapper.updateByPrimaryKeySelective(admin);
	}

	// 保存新增admin对象
	@Override
	public void saveAdmin(TAdmin admin) {
		// 1、检查邮箱是否被占用
		boolean email = checkEmail(admin);

		if (!email) {
			throw new EmailExistException();
		}
		// 2、检查账号是否被占用
		boolean loginacct = checkLoginacct(admin);
		if (!loginacct) {
			throw new LoginacctExistException();
		}

		// 3、保存用户（有选择的插入）
		admin.setUserpswd(AppUtils.getDigestPwd("123456"));
		admin.setCreatetime(AppUtils.getCurrentTimeStr());
		adminMapper.insertSelective(admin);
	}

	// 1、检查账号是否被占用
	@Override
	public boolean checkLoginacct(TAdmin admin) {
		TAdminExample example = new TAdminExample();
		example.createCriteria().andLoginacctEqualTo(admin.getLoginacct());
		long l = adminMapper.countByExample(example);
		return l == 0 ? true : false;
	}

	// 2、检查邮箱是否被占用
	@Override
	public boolean checkEmail(TAdmin admin) {
		TAdminExample example = new TAdminExample();
		example.createCriteria().andEmailEqualTo(admin.getEmail());
		long l = adminMapper.countByExample(example);
		return l == 0 ? true : false;
	}

	// 根据id删除admin(单个)
	@Override
	public void deleteAdminById(Integer id) {
		adminMapper.deleteByPrimaryKey(id);
	}

	// 按照用户id查询自己能操作的菜单
	@Override
	public List<TMenu> listYourMenus(Integer id) {
		List<TMenu> parentsMenu = new ArrayList<TMenu>();
		List<TMenu> myMenus = menuMapper.getMyMenus(id);
		// 组装所有这些菜单的父子关系；
		for (TMenu tMenu : myMenus) {
			if (tMenu.getPid() == 0) {
				// 父菜单
				parentsMenu.add(tMenu);
			}
		}
		// 找到每一个父菜单的子菜单
		for (TMenu pMenu : parentsMenu) {
			// 1、为当前父菜单找子菜单
			for (TMenu childMenu : myMenus) {
				if (childMenu.getPid() == pMenu.getId()) {
					pMenu.getChilds().add(childMenu);
				}
			}
		}
		return parentsMenu;
	}
}
