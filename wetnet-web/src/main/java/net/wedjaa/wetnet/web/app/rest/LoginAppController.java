/**
 * 
 */
package net.wedjaa.wetnet.web.app.rest;

import java.util.logging.Logger;


import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.authentication.encoding.MessageDigestPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import net.wedjaa.wetnet.business.dao.Response;
import net.wedjaa.wetnet.business.dao.UsersDAO;
import net.wedjaa.wetnet.business.domain.Users;

/**
 * @author graziella cipolletti
 *
 */
@Controller
public class LoginAppController {

	protected static final Logger logger = Logger.getLogger("LoginAppController");

	 @Autowired
	    private MessageSource messages;
	 @Autowired
	    private UsersDAO usersDAO;
	 
	 @Autowired
	    private MessageDigestPasswordEncoder messageDigestPasswordEncoder;
	
	@RequestMapping(value = "/login", method = { RequestMethod.POST })
    public Response getLoginApp(HttpServletResponse response,@RequestParam("username") String username, @RequestParam("password") String password) {
        logger.info("received request for 'getLoginApp' " + username + " " + password);
        Users u = new Users();
        u.setUsername(username);
        //u.setPassword(messageDigestPasswordEncoder.encodePassword(password, null));
        u.setPassword(password);
        Users result = usersDAO.getByUserNamePassword(u);
        
        Response r = new Response();
        r.setMessage("OK");
        r.setCode("1");
        r.setResult(result);
        return r;
    }
}
