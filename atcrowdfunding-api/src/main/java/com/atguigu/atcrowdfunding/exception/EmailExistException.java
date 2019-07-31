package com.atguigu.atcrowdfunding.exception;

/**
 * @author zheng 邮箱已经存在
 */
public class EmailExistException extends RuntimeException {
	private static final long serialVersionUID = 1L;

	public EmailExistException() {
		super("邮箱已经存在");
	}

	public EmailExistException(String message) {
		super(message);
	}

}
