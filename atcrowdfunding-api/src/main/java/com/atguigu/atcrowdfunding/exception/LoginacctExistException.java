package com.atguigu.atcrowdfunding.exception;

/**
 * @author zheng 账号存在异常
 */
public class LoginacctExistException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public LoginacctExistException(String message) {
		super(message);
	}

	public LoginacctExistException() {
		super("账号已经存在");
	}

}
