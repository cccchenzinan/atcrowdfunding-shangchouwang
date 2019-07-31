package com.atguigu.atcrowdfunding.config;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.component.MyUserDetail;
import com.atguigu.atcrowdfunding.constant.AppConstant;

//启动web安全
@EnableWebSecurity
@Configuration
public class AtcrowdfundingSecurityConfig extends WebSecurityConfigurerAdapter {

	protected static final Authentication UsernamePasswordAuthenticationToken = null;

	@Qualifier("myUserDetailService")
	@Autowired
	UserDetailsService userDetailsService;

	// @Qualifier:指定使用哪个组件
	@Qualifier("myPasswordEncoder")
	@Autowired
	PasswordEncoder passwordEncoder;

	// 定义认证规则
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		// TODO Auto-generated method stub
		// super.configure(auth);
		auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder);

	}

	// 定义http访问规则
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		// TODO Auto-generated method stub
		// super.configure(http);

		// authorize授权 Matcher匹配器 permit允许
		http.authorizeRequests().antMatchers("/static/**").permitAll()
				.antMatchers("/index.jsp", "/login.jsp", "/reg.jsp").permitAll()
				// 任何请求 都要已认证
				.anyRequest().authenticated();

		// 跨站请求伪造 form表单提交的时候必须带一个_csrf令牌
		// 暂时关闭
		http.csrf().disable();

		// 表单登录功能
		// GET /login 去登录页
		// POST /login.jsp去登录请求
		http.formLogin().loginPage("/login").usernameParameter("loginacct").passwordParameter("pwd")
				// 登录成功怎么做
				.successHandler(new AuthenticationSuccessHandler() {
					@Override
					public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
							Authentication authentication) throws IOException, ServletException {
						// 当前登录的用户对象
						UsernamePasswordAuthenticationToken token = (UsernamePasswordAuthenticationToken) authentication;
						// 封装了当前登录的用户
						MyUserDetail principal = (MyUserDetail) token.getPrincipal();
						TAdmin admin = principal.getAdmin();
						request.getSession().setAttribute(AppConstant.LOGIN_USER_SESSION_KEY, admin);
						// 登录成功去main页面 原生重定向加项目名
						response.sendRedirect(request.getContextPath() + "/main.html");

					}
				})
				// 登录失败怎么做
				.failureHandler(new AuthenticationFailureHandler() {

					@Override
					public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
							AuthenticationException exception) throws IOException, ServletException {
						//回显错误消息
						request.setAttribute("msg", "账号密码错误，请重试");
						request.getRequestDispatcher("/login.jsp").forward(request, response);;
					}
				}).permitAll();

	}

}
