package com.atguigu.atcrowdfunding.component;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TAdminExample;
import com.atguigu.atcrowdfunding.bean.TPermission;
import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.mapper.TAdminMapper;
import com.atguigu.atcrowdfunding.mapper.TPermissionMapper;
import com.atguigu.atcrowdfunding.mapper.TRoleMapper;

@Component("myUserDetailService")
public class MyUserDetailService implements UserDetailsService {

	@Autowired
	TAdminMapper adminMapper;

	@Autowired
	TRoleMapper roleMapper;

	@Autowired
	TPermissionMapper permissionMapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		TAdminExample example = new TAdminExample();
		example.createCriteria().andLoginacctEqualTo(username);
		List<TAdmin> list = adminMapper.selectByExample(example);
		if (list == null || list.size() == 0) {
			// 没查到
			return null;
		}
		if (list.size() != 1) {
			return null;
		} else {
			TAdmin tAdmin = list.get(0);
			// 权限集合
			List<GrantedAuthority> grantedAuthoritys = new ArrayList<GrantedAuthority>();
			// 查出当前用户的角色信息
			List<TRole> roles = roleMapper.getUserHasRoles(tAdmin.getId());
			for (TRole role : roles) {
				// 把角色放入权限集合 加 ROLE_
				grantedAuthoritys.add(new SimpleGrantedAuthority("ROLE_" + role.getName()));
				// 遍历所有角色的权限
				List<TPermission> permissions = permissionMapper.selectRolePermissions(role.getId());
				for (TPermission permission : permissions) {
					String name = permission.getName();
					//剔除空的权限
					if (!StringUtils.isEmpty(name)) {

						grantedAuthoritys.add(new SimpleGrantedAuthority(name));
					}
				}
			}
			
			
			
			/**
			 * User 需要的参数 String username, String password, boolean enabled, 启用，激活 boolean
			 * accountNonExpired, 账户是否过期 boolean credentialsNonExpired,证书是否过期 boolean
			 * accountNonLocked, 账户是否锁定 Collection<? extends GrantedAuthority> authorities
			 */
			//该user对象只封装了账号，密码和权限
//			User user = new User(tAdmin.getLoginacct(), tAdmin.getUserpswd(), true, true, true, true,
//					grantedAuthoritys);
			
			
			//自定义一个封装了用户信息的UserDetail
			MyUserDetail user=new MyUserDetail(
					tAdmin.getLoginacct(),
					tAdmin.getUserpswd(),
					grantedAuthoritys, 
					tAdmin);
			return user;
		}

	}

}
