package sy.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import sy.model.User;
import sy.service.UserServiceI;

@Controller
@RequestMapping("/userController")
public class UserController {

	@Resource
	private UserServiceI userService;

	/*@Autowired
	public void setUserService(UserServiceI userService) {
		this.userService = userService;
	}*/

	@RequestMapping("/{id}/showUser")
	public String showUser(@PathVariable String id, HttpServletRequest request) {
		System.out.println("showUser...");
		User u = userService.getUserById(id);
		request.setAttribute("user", u);
		return "easyui_demo";
	}

}
