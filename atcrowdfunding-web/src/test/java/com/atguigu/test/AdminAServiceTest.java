package com.atguigu.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.atguigu.atcrowdfunding.api.AdminService;

/**
 * 引入spring的单元测试
 * 		1引入junit的单元测试
 * 		2引入Spring-test模块
 * 将普通的单元测试变为spring的单元测试
 * 		@RunWith:告诉junit，使用spring框架驱动的这个测试
 * 		spring编写了一个SpringJUnit4ClassRunner驱动类
 * @ContextConfiguration 告诉Spring当前单元测试需要使用的配置文件时哪些
 */



@ContextConfiguration(locations= {"classpath*:spring-beans.xml","classpath*:spring-mybatis.xml","classpath*:spring-tx.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
public class AdminAServiceTest {

	@Autowired
	AdminService adminService;

	@Test
	public void pageTest() {

	}
}
