package com.atguigu.atcrowdfunding.controller.serviceauth;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ServiceauthPageController {
	@GetMapping("/auth_cert/index.html")
	public String authCertPage() {
		return "serviceauth/auth_cert";
	}

	@GetMapping("/auth_adv/index.html")
	public String authAdvPage() {
		return "serviceauth/auth_adv";
	}

	@GetMapping("/auth_project/index.html")
	public String authProjctPage() {
		return "serviceauth/auth_project";
	}
}
