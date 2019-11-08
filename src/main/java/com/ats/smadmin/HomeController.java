package com.ats.smadmin;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.smadmin.common.Constants;
import com.ats.smadmin.model.Admin;
import com.ats.smadmin.model.LoginProcess;
import com.ats.smadmin.model.TableCat;
import com.ats.smadmin.model.TableList;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	RestTemplate restTemplate = new RestTemplate();
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	/*@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}*/
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(Locale locale, Model model) {

		ModelAndView mav = new ModelAndView("login");

		return mav;
	}
	
	@RequestMapping(value = "/sessionTimeOut", method = RequestMethod.GET)
	public String sessionTimeOut(HttpSession session) {
		System.out.println("User Logout in sessionTimeOut");

		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(Locale locale, Model model, HttpSession session) {

		session.invalidate();

		return "redirect:/";
	}
	
	@RequestMapping(value = "/loginProcess", method = RequestMethod.POST)
	public String loginProcess(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		String mav = null;
		
		try {

			RestTemplate restTemplate = new RestTemplate();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();			
			map.add("userName", request.getParameter("username"));
			map.add("pass", request.getParameter("password"));

			LoginProcess admlogin = restTemplate.postForObject(Constants.url + "/adminLogin", map,
					LoginProcess.class);		
			System.err.println("Admin Login----------" + admlogin.getAdmin());	
			if (admlogin.isError()==true) {
				
				mav = "redirect:/";
				
				System.err.println("Login failed");
				model.addAttribute("errorPassMsg", "Invalid Login Credentials");
				
			} else {
					mav = "redirect:/welcomePage";
					session = request.getSession();	
					session.setAttribute("admLogin", admlogin);
					
					System.err.println("Successful Login----------" + admlogin);						
				
				}
		} catch (Exception e) {
			mav = "redirect:/";
			System.err.println("Exception in Login Process  " + e.getMessage());
			e.printStackTrace();
		}

		return mav;
	}
	
	@RequestMapping(value = "/welcomePage", method = RequestMethod.GET)
	public ModelAndView welcomePage(Locale locale, Model model,HttpSession session) {
		ModelAndView mav = new ModelAndView("welcome");
		try {
				
				String currDate = Constants.getSimpleCurDate();
				mav.addObject("currdate", currDate);					
				
				TableCat[] tableCatArr = restTemplate.getForObject(Constants.url + "/getAllTablesCatByIsUsed",TableCat[].class);
				List<TableCat> tableCatList = new ArrayList<TableCat>(Arrays.asList(tableCatArr));
				mav.addObject("tableCatList", tableCatList);
				
				TableList[]	tableArr = restTemplate.getForObject(Constants.url+"/getFreeTableList", TableList[].class);
				List<TableList> tableList = new ArrayList<TableList>(Arrays.asList(tableArr));
				mav.addObject("tableList", tableList);
				
				TableList[] busyTableArr = restTemplate.getForObject(Constants.url+"/getBsyTableList", TableList[].class);
				List<TableList> busyTableLists = new ArrayList<TableList>(Arrays.asList(tableArr));
				mav.addObject("busyTableList", busyTableLists);
				/*Admin adm = (Admin) session.getAttribute("admLogin");
				String  userName = adm.getUsername();
				model.addAttribute("userName", userName);*/
				
				mav.addObject("disc", 0);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	
	
}
