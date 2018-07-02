/**
 * 
 */
package net.wedjaa.wetnet.web.app.rest;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.vividsolutions.jts.geom.Coordinate;
import com.vividsolutions.jts.geom.GeometryFactory;
import com.vividsolutions.jts.geom.PrecisionModel;

import net.wedjaa.wetnet.business.dao.MeasuresDAO;
import net.wedjaa.wetnet.business.dao.Response;
import net.wedjaa.wetnet.business.dao.UsersDAO;
import net.wedjaa.wetnet.business.domain.JSONResponse;
import net.wedjaa.wetnet.business.domain.Measures;
import net.wedjaa.wetnet.business.domain.MeasuresApp;
import net.wedjaa.wetnet.business.domain.MeasuresMeterReading;
import net.wedjaa.wetnet.business.domain.Users;
import net.wedjaa.wetnet.business.services.DataDistrictsService;
import net.wedjaa.wetnet.security.Roles;
import net.wedjaa.wetnet.security.UserDetailsImpl;
import org.geotools.geometry.jts.JTS;
import org.geotools.referencing.CRS;
import org.joda.time.format.DateTimeFormat;
import org.json.JSONArray;
import org.json.JSONObject;
import org.opengis.geometry.MismatchedDimensionException;
import org.opengis.referencing.FactoryException;
import org.opengis.referencing.crs.CoordinateReferenceSystem;
import org.opengis.referencing.operation.MathTransform;
import org.opengis.referencing.operation.TransformException;
import com.vividsolutions.jts.geom.Point;

/**
 * @author graziella cipolletti
 *
 */

@Controller
public class MesuresAppController {

	protected static final Logger logger = Logger.getLogger("MesuresAppController");

	
	
	 @Autowired
	    private MeasuresDAO measuresDAO;
	    
	 @Autowired
	    private UsersDAO usersDAO;

	    /**
	     * 
	     * @param response
	     * @return
	     */
	    @RequestMapping(value = "/measures/getByUser", method = { RequestMethod.GET })
	    public Response getAllByUserId(@RequestParam("id") long id) {
	        
	    	Response r = new Response();
	    	r.setCode("1");
	    	r.setMessage("OK");
	    	
	    	Users u = usersDAO.getById(id);
	    	
	    	if(u==null)
	    	{
	    		r.setCode("0");
	    		r.setMessage("KO");
	    		r.setResult(null);
	    		return r;
	    	}
	    	
	    	ArrayList<Measures> meas = (ArrayList<Measures>) measuresDAO.getAll(u);
	    	ArrayList<MeasuresApp> list = new ArrayList<MeasuresApp>();
	    	
	    	for(Measures m: meas)
	    	{
	    		String map = m.getMap();
	    		
	    		
	    	try {
	    		if(map!=null && map.trim().length()>0)
	    		{
	    			 JSONObject jsonObject = new JSONObject(m.getMap());
	                    JSONArray jsonArray = jsonObject.getJSONArray("features");
	                    JSONObject jsonObject2 = jsonArray.getJSONObject(0);
	                    JSONObject jsonObject3 = jsonObject2.optJSONObject("geometry");
	                    JSONArray jsonArray2 = jsonObject3.getJSONArray("coordinates");
	                    double lat = (double)jsonArray2.get(0);
	                    double longi = (double)jsonArray2.get(1);
	          		
				CoordinateReferenceSystem sourceCRS = CRS.decode("EPSG:3857",true);
		        CoordinateReferenceSystem targetCRS = CRS.decode("EPSG:4326",true);
		        MathTransform transform = CRS.findMathTransform(sourceCRS, targetCRS, true);
		        GeometryFactory geometryFactory = new GeometryFactory(new PrecisionModel(), 3857);
		        Point point = geometryFactory.createPoint(new Coordinate(lat,longi));
		        Point targetPoint = (Point) JTS.transform(point, transform);
		        
		        m.setLatitudeApp(""+targetPoint.getY());
		        m.setLongitudeApp(""+targetPoint.getX());
	    		}
	    		
	    		
	    		MeasuresApp mapp = new MeasuresApp(m.getIdMeasures(),m.getName(), m.getDescription(), m.getType(), m.getLatitudeApp(), m.getLongitudeApp());
	    		
		        list.add(mapp);
		        
		  	} catch (FactoryException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (MismatchedDimensionException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (TransformException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
	        
	    	}
	    	
	    	r.setResult(list);
	            
	        return r;
	    }

	    @RequestMapping(value = "/measuresMeterReading", method = { RequestMethod.GET })
	    public Response measuresMeterReadingAll(@RequestParam("id") long id) {
	    	
	    	Response r = new Response();
	    	
	    	r.setCode("1");
	    	r.setMessage("OK");
	    	
	    	ArrayList<MeasuresMeterReading> meas = (ArrayList<MeasuresMeterReading>) measuresDAO.getAllMeterReadingByMeasure(id);
	    	
	    	TimeZone tz = TimeZone.getDefault();
	    	
	    	for(MeasuresMeterReading m : meas)
	    	{
	    		 Date ret = new Date( m.getTimestamp().getTime() + tz.getRawOffset() );

	 	        // if we are now in DST, back off by the delta.  Note that we are checking the GMT date, this is the KEY.
	 	        if ( tz.inDaylightTime( ret )){
	 	            Date dstDate = new Date( ret.getTime() + tz.getDSTSavings() );
	 	            // check to make sure we have not crossed back into standard time
	 	            // this happens when we are on the cusp of DST (7pm the day before the change for PDT)
	 	            if ( tz.inDaylightTime( dstDate )){
	 	                ret = dstDate;
	 	            }
	 	         }
	 	    	
	 	    	m.setTimestamp(ret);
	    	}
	            
	    	r.setResult(meas);
	    	
	        return r;
	    }
	    
	    @RequestMapping(value = "/measuresMeterReading/save", method = {RequestMethod.POST })
	    public Response saveMeterReading(@RequestBody MeasuresMeterReading measuresMeterReading) {
	    	
	    	Response r = new Response();
	    	
	    	if(measuresMeterReading==null)
	    	{
	    		r.setCode("0");
	    		r.setMessage("KO");
	    		r.setResult(null);
	    		return r;
	    	}
	    	
	    	r.setCode("1");
	    	r.setMessage("OK");
	    	
	    	
	    	//adatto a timezone
	    	TimeZone tz = TimeZone.getDefault();
	    	 Date ret = new Date( measuresMeterReading.getTimestamp().getTime() - tz.getRawOffset() );

	        // if we are now in DST, back off by the delta.  Note that we are checking the GMT date, this is the KEY.
	        if ( tz.inDaylightTime( ret )){
	            Date dstDate = new Date( ret.getTime() - tz.getDSTSavings() );
	            // check to make sure we have not crossed back into standard time
	            // this happens when we are on the cusp of DST (7pm the day before the change for PDT)
	            if ( tz.inDaylightTime( dstDate )){
	                ret = dstDate;
	            }
	         }
	    	
	    	measuresMeterReading.setTimestamp(ret);
    		
	    
	    	MeasuresMeterReading m = measuresDAO.saveMeterReading(measuresMeterReading);
	        r.setResult(m);
	    	
	    	
	    	return r;
	    }
	    
	    
	    
	    @RequestMapping(value = "/measuresMeterReadingByUser", method = { RequestMethod.GET })
	    public Response measuresMeterReadingByUser(@RequestParam("id") long id) {
	    	
	    	Response r = new Response();
	    	
	    	r.setCode("1");
	    	r.setMessage("OK");
	    	Users u = usersDAO.getById(id);
	    	
	    	if(u==null)
	    	{
	    		r.setCode("0");
	    		r.setMessage("KO");
	    		r.setResult(null);
	    		return r;
	    	}
	    	
	    	ArrayList<Measures> meas = (ArrayList<Measures>) measuresDAO.getAll(u);
	    	
	    	ArrayList<MeasuresMeterReading> lects = new ArrayList<MeasuresMeterReading>();
	    	
	    	for(Measures m : meas)
	    	{
	    	ArrayList<MeasuresMeterReading> t = (ArrayList<MeasuresMeterReading>) measuresDAO.getAllMeterReadingByMeasure(m.getIdMeasures());
	    	
	    	TimeZone tz = TimeZone.getDefault();
	    	
	    	for(MeasuresMeterReading lettura : t)
	    	{
	    		 Date ret = new Date( lettura.getTimestamp().getTime() + tz.getRawOffset() );

	 	        // if we are now in DST, back off by the delta.  Note that we are checking the GMT date, this is the KEY.
	 	        if ( tz.inDaylightTime( ret )){
	 	            Date dstDate = new Date( ret.getTime() + tz.getDSTSavings() );
	 	            // check to make sure we have not crossed back into standard time
	 	            // this happens when we are on the cusp of DST (7pm the day before the change for PDT)
	 	            if ( tz.inDaylightTime( dstDate )){
	 	                ret = dstDate;
	 	            }
	 	         }
	 	    	
	 	       lettura.setTimestamp(ret);
	 	    }
	            
	    	lects.addAll(t);
	    	}
	    	
	    	r.setResult(lects);
	            
	        return r;
	    }
}
