package com.atguigu.atcrowdfunding.component;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.atguigu.atcrowdfunding.utils.AppUtils;

//自己的密码加密器
@Component("myPasswordEncoder")
public class MyPasswordEncoder implements PasswordEncoder {
	// 明文转密文
	@Override
	public String encode(CharSequence rawPassword) {
		String digestPwd = AppUtils.getDigestPwd(rawPassword.toString());
		return digestPwd;
	}

	// rawPassword:明文
	// encodedPassword:密文
	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {

		String digestPwd = AppUtils.getDigestPwd(rawPassword.toString());

		return digestPwd.equals(encodedPassword);
	}

}
