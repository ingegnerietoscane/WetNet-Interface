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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import net.wedjaa.wetnet.business.commons.PropertiesUtil;
import net.wedjaa.wetnet.business.domain.JSONResponse;

/**
 * @author graziella cipolletti
 *
 */
@Controller
@RequestMapping("/properties")
public class PropertiesRestController {
	
	  private static Logger log = LoggerFactory.getLogger(PropertiesRestController.class);
	  
	  @Autowired
	    private PropertiesUtil propertiesSource;
	  
	  @Autowired
	    private MessageSource messages;
	  

	  @RequestMapping(method = { RequestMethod.GET })
	    public JSONResponse getProperties(HttpServletRequest request) {
		  
		    String zoom = (String) request.getSession().getServletContext().getAttribute("dashboard_zoom");
		    String lat = (String) request.getSession().getServletContext().getAttribute("dashboard_latitude");
		    String longi = (String) request.getSession().getServletContext().getAttribute("dashboard_longitude");
			  
		    if(zoom==null || lat==null || longi == null)
		    {
		    	zoom = propertiesSource.getProperty("dashboard.zoom");
		    	lat = propertiesSource.getProperty("dashboard.map.center.latitude");
		    	longi = propertiesSource.getProperty("dashboard.map.center.longitude");
		    	
		    	request.getSession().getServletContext().setAttribute("dashboard_zoom", zoom);
		    	request.getSession().getServletContext().setAttribute("dashboard_latitude", lat);
		    	request.getSession().getServletContext().setAttribute("dashboard_longitude", longi);
		    }
		   
		    
	        JSONResponse jsonResponse = new JSONResponse(JSONResponse.SUCCESS);
	       
	        jsonResponse.setStatus(JSONResponse.SUCCESS);
	        jsonResponse.addData("dashboard_zoom", Integer.parseInt(zoom));
	        jsonResponse.addData("dashboard_latitude", Double.parseDouble(lat));
	        jsonResponse.addData("dashboard_longitude", Double.parseDouble(longi));
	        jsonResponse.addData("mapsKey", propertiesSource.getProperty("maps.google.api.key"));
		    System.out.println("SETT2017 PropertiesRestController.java > getProperties");
	        return jsonResponse;
	    }
	  
	  
	  
	  @RequestMapping(method = { RequestMethod.POST })
	    public JSONResponse save(HttpServletRequest request,@RequestParam("zoom") int zoom,@RequestParam("lat") double lat,@RequestParam("longi") double longi ) {
		  
			request.getSession().getServletContext().setAttribute("dashboard_zoom", zoom+"");
		    request.getSession().getServletContext().setAttribute("dashboard_latitude", lat+"");
		    request.getSession().getServletContext().setAttribute("dashboard_longitude", longi+"");
		     
	        JSONResponse jsonResponse = new JSONResponse(JSONResponse.SUCCESS);
	       
	        jsonResponse.setStatus(JSONResponse.SUCCESS);
	        jsonResponse.addData("dashboard_zoom", zoom);
	        jsonResponse.addData("dashboard_latitude", lat);
	        jsonResponse.addData("dashboard_longitude", longi);
	        
	        jsonResponse.setMessage(messages.getMessage("configure-map.form.alert.success", null, request.getLocale()));
	        jsonResponse.setStatus(JSONResponse.SUCCESS);
		    System.out.println("SETT2017 PropertiesRestController.java > save");
	        return jsonResponse;
	    }
}
