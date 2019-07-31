package com.atguigu.test;

import org.junit.Test;
import org.springframework.util.DigestUtils;

public class MD5Test {

	@Test
	public void md5Test() {
		String pwd2 = "123456";
		for (int i = 0; i < 2; i++) {
			pwd2 = pwd(pwd2);
		}
		System.out.println(pwd2);
	}

	public String pwd(String str) {
		return DigestUtils.md5DigestAsHex(str.getBytes());
		
	}
}
