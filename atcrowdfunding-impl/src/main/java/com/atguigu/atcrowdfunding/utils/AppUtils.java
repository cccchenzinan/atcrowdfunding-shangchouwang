package com.atguigu.atcrowdfunding.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.util.DigestUtils;

public class AppUtils {
	// 密码不可逆加密
	public static String getDigestPwd(String str) {
		String string = str;
		for (int i = 0; i < 2; i++) {
			string = DigestUtils.md5DigestAsHex(string.getBytes());
		}
		return string;
	}

	// 时间工具
	public static String getCurrentTimeStr() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return format.format(new Date());
	}

	// 时间工具类
	public static String getCurrentTimeStr(Date date) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return format.format(date);
	}

	// 时间工具类
	public static String getCurrentTimeStr(Date date, String pattern) {
		SimpleDateFormat format = new SimpleDateFormat(pattern);
		return format.format(date);
	}
}
