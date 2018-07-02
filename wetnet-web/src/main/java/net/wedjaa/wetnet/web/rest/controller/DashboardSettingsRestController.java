/**
 * 
 */
package net.wedjaa.wetnet.web.rest.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import net.wedjaa.wetnet.business.commons.PropertiesUtil;
import net.wedjaa.wetnet.business.domain.DashboardSettings;
import net.wedjaa.wetnet.business.domain.JSONResponse;

/**
 * @author graziella cipolletti
 *
 */
@Controller
@RequestMapping("/dashboardsettings")
public class DashboardSettingsRestController {
	
	  private static Logger log = LoggerFactory.getLogger(DashboardSettingsRestController.class);
	  

	  @RequestMapping(method = { RequestMethod.GET })
	    public JSONResponse getSettings(HttpServletRequest request) {
		  
		  DashboardSettings d = (DashboardSettings)request.getSession().getAttribute("dashboard_settings");
		  
		  JSONResponse jsonResponse = new JSONResponse(JSONResponse.SUCCESS);
	       
	        jsonResponse.setStatus(JSONResponse.SUCCESS);
	        jsonResponse.addData("dashboard_settings", d);
	        return jsonResponse;
	    }
	  
	  
	  
	  @RequestMapping(method = { RequestMethod.POST })
	    public JSONResponse save(HttpServletRequest request, @RequestBody DashboardSettings sett) {
		  
		  	request.getSession().setAttribute("dashboard_settings", sett);
		    DashboardSettings d = (DashboardSettings)request.getSession().getAttribute("dashboard_settings");
			  
		  
		    JSONResponse jsonResponse = new JSONResponse(JSONResponse.SUCCESS);
		       
	        jsonResponse.setStatus(JSONResponse.SUCCESS);
	        jsonResponse.addData("dashboard_settings", d);
	        return jsonResponse;
	    }
}
