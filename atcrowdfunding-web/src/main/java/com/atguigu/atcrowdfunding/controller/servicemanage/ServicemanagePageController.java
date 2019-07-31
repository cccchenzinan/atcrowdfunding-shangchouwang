package com.atguigu.atcrowdfunding.controller.servicemanage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ServicemanagePageController {
	@GetMapping("/cert/index.html")
	public String certPage() {
		return "servicemanage/cert";
	}

	@GetMapping("/certtype/index.html")
	public String typePage() {
		return "servicemanage/type";
	}

	@GetMapping("/process/index.html")
	public String processPage() {
		return "servicemanage/process";
	}

	@GetMapping("/advert/index.html")
	public String advertisementPage() {
		return "servicemanage/advertisement";
	}

	@GetMapping("/message/index.html")
	public String messagePage() {
		return "servicemanage/message";
	}

	@GetMapping("/projectType/index.html")
	public String projectTypePage() {
		return "servicemanage/project_type";
	}

	@GetMapping("/tag/index.html")
	public String tagPage() {
		return "servicemanage/tag";
	}
}
