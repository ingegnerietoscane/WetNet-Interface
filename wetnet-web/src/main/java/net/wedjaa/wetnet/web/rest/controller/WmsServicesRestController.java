package net.wedjaa.wetnet.web.rest.controller;

import net.wedjaa.wetnet.business.dao.UsersDAO;
import net.wedjaa.wetnet.business.dao.WmsServicesDAO;
import net.wedjaa.wetnet.business.domain.JSONResponse;
import net.wedjaa.wetnet.business.domain.Users;
import net.wedjaa.wetnet.business.domain.UsersHasDistricts;
import net.wedjaa.wetnet.business.domain.WmsServices;
import net.wedjaa.wetnet.security.UserDetailsImpl;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.encoding.MessageDigestPasswordEncoder;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * @author daniele montagni
 *
 */
@Controller
@RequestMapping("/wmsservices")
public class WmsServicesRestController {
    
    @Autowired
    private MessageSource messages;
    @Autowired
    private WmsServicesDAO wmsServicesDAO;
    @Autowired
    private MessageDigestPasswordEncoder messageDigestPasswordEncoder;

    /**
     * 
     * @param response
     * @return
     */
    @PreAuthorize("hasRole('ROLE_ADMINISTRATOR')")
    @RequestMapping(method = { RequestMethod.GET })
    public List<WmsServices> getWmsServices(HttpServletResponse response) {
        List<WmsServices> result = wmsServicesDAO.getAll();
        return result;
    }


    /**
     *
     * @param wmsServicesId
     * @return
     */
    @PreAuthorize("hasRole('ROLE_ADMINISTRATOR')")
    @RequestMapping(value = "{id}", method = { RequestMethod.GET })
    public WmsServices getWmsService(@PathVariable("id") long wmsServicesId) {
        WmsServices result = wmsServicesDAO.getById(wmsServicesId);
        return result;
    }

    /**
     *
     * @param request
     * @param wmsService
     * @return
     */
    @PreAuthorize("hasRole('ROLE_ADMINISTRATOR')")
    @RequestMapping(method = { RequestMethod.PUT, RequestMethod.POST })
    public JSONResponse saveWmsService(HttpServletRequest request, @RequestBody WmsServices wmsService) {
        JSONResponse jsonResponse = new JSONResponse(JSONResponse.SUCCESS);
        jsonResponse.addData("wmsService", wmsServicesDAO.saveOrUpdate(wmsService));
        jsonResponse.setMessage(messages.getMessage("wmsservice.form.save.alert.success", null, request.getLocale()));
        return jsonResponse;
    }

    /**
     *
     * @param request
     * @param wmsServiceId
     * @return
     */
    @PreAuthorize("hasRole('ROLE_ADMINISTRATOR')")
    @RequestMapping(value = "{id}", method = { RequestMethod.DELETE })
    public JSONResponse deleteWmsService(HttpServletRequest request, @PathVariable("id") long wmsServiceId) {
        JSONResponse jsonResponse = new JSONResponse(JSONResponse.SUCCESS);
        jsonResponse.setMessage(messages.getMessage("wmsservice.form.delete.alert.success", null, request.getLocale()));
        wmsServicesDAO.delete(wmsServiceId);
        return jsonResponse;
    }

}
