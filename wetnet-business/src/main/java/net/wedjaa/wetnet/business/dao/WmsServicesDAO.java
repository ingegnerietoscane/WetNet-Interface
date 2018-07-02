package net.wedjaa.wetnet.business.dao;

import net.wedjaa.wetnet.business.domain.Users;
import net.wedjaa.wetnet.business.domain.UsersHasDistricts;
import net.wedjaa.wetnet.business.domain.WmsServices;

import java.util.List;

/**
 * @author daniele montagni
 *
 */
public interface WmsServicesDAO {

    /**
     * 
     * @return
     */
    public List<WmsServices> getAll();

    /**
     *
     * @param wmsServiceId
     * @return
     */
    public WmsServices getById(long wmsServiceId);

    /**
     *
     * @param wmsService
     * @return
     */
    public WmsServices saveOrUpdate(WmsServices wmsService);

    /**
     *
     * @param idwms_services
     */
    public void delete(long idwms_services);
}
