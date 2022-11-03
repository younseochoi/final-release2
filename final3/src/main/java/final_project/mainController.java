package final_project;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class mainController {
	
	@GetMapping("/mainpage")
	public String main() {
		return "mainpage";
	}

}
