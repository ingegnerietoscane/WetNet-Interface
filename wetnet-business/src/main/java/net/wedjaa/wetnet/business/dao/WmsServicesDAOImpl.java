package net.wedjaa.wetnet.business.dao;

import net.wedjaa.wetnet.business.BusinessesException;
import net.wedjaa.wetnet.business.domain.Users;
import net.wedjaa.wetnet.business.domain.UsersHasDistricts;
import net.wedjaa.wetnet.business.domain.WmsServices;
import org.apache.commons.lang3.builder.ReflectionToStringBuilder;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.logging.Logger;

/**
 * @author daniele montagni
 *
 */
public class WmsServicesDAOImpl implements WmsServicesDAO {

    private static final Logger logger = Logger.getLogger(WmsServicesDAOImpl.class.getName());

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    /**
     * {@inheritDoc}
     */
    @Override
    public List<WmsServices> getAll() {
        try {
            List<WmsServices> result = sqlSessionTemplate.selectList("wms_services.getAll");
            return result;

        } catch (Exception e) {
            throw new BusinessesException(e);
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public WmsServices getById(long wmsServiceId) {
        try {
            WmsServices result = sqlSessionTemplate.selectOne("wms_services.getById", wmsServiceId);
            return result;

        } catch (Exception e) {
            throw new BusinessesException(e);
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public WmsServices saveOrUpdate(WmsServices wmsService) {
        try {
            int result = 0;
            if (wmsService.getIdwms_services() > 0) {
                result = sqlSessionTemplate.update("wms_services.update", wmsService);
            } else {
                result = sqlSessionTemplate.insert("wms_services.insert", wmsService);
            }
            if (result == 0) {
                logger.info("no row modified for " + ReflectionToStringBuilder.toString(wmsService));
            }
            return wmsService;
        } catch (Exception e) {
            throw new BusinessesException(e);
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void delete(long idwms_services) {
        try {
            int result = sqlSessionTemplate.delete("wms_services.delete", idwms_services);
            if (result == 0) {
                logger.info("no row deleted for userid: " + idwms_services);
            }

        } catch (Exception e) {
            throw new BusinessesException(e);
        }
    }
}
