package net.wedjaa.wetnet.business.commons;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import net.wedjaa.wetnet.business.services.EpanetServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;


/*
 * Utilizzata come estensione del bean di default di spring PropertyPlaceholderConfigurer
 * per accedere al file application.properties e per consentire ad altre classi del progetto
 * anche non spring di accedere alle stesse properties
 */

public class PropertiesUtil extends PropertyPlaceholderConfigurer {

	private static final Logger logger = LoggerFactory.getLogger(PropertiesUtil.class);

	   @SuppressWarnings("rawtypes")
	private static Map propertiesMap;
	 
	   @SuppressWarnings("unchecked")
	@Override
	   protected void processProperties(ConfigurableListableBeanFactory beanFactory,
	             Properties props) throws BeansException {
	        super.processProperties(beanFactory, props);
	 
	        propertiesMap = new HashMap<String, String>();
		  	logger.debug("Loading properties...");
	        for (Object key : props.keySet()) {
	            String keyStr = key.toString();
				logger.debug("  " + keyStr + " = " + props.getProperty(keyStr));
	            propertiesMap.put(keyStr, props.getProperty(keyStr));
	           // propertiesMap.put(keyStr, parseStringValue(props.getProperty(keyStr),   props, new HashSet()));
	        }
		   logger.info("Loading properties complete");
	    }
	 
	    public String getProperty(String name) {
	        return (String) propertiesMap.get(name);
	    }
	}